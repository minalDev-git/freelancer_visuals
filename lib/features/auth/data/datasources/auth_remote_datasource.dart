import 'package:freelancer_visuals/core/error/exceptions.dart';
import 'package:freelancer_visuals/core/secrets/app_secrets.dart';
import 'package:freelancer_visuals/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();

  Future<UserModel> handleGoogleAuth();

  Future<double> getTotalEarningsForMonth({
    required String userId,
    required int month,
    required int year,
  });

  Future<void> signOut();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException('Unsuccessful Login!');
      }
      // print(response.user!.id);
      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      // print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw const ServerException('Unsuccessful Sign Up!');
      }
      // print(response.user!.id);
      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      // print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> handleGoogleAuth() async {
    const webClientId = AppSecrets.webClientId;
    const iosClientId = AppSecrets.iosClientId;

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        clientId: iosClientId,
        serverClientId: webClientId,
      );

      final googleUser = await googleSignIn.authenticate();
      // Token retrieval
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) throw Exception('No ID Token found.');

      final response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );
      if (response.user == null) {
        throw const ServerException('Unsuccessful SignUp/Login with Google!');
      }
      final userId = response.user!.id;
      final email = response.user!.email;

      // 🔹 Step 1: Try to fetch user profile from DB
      final existingUser = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (existingUser != null) {
        return UserModel.fromJson(
          existingUser,
        ).copyWith(email: currentUserSession!.user.email);
      }

      // 🔹 Step 2: If not found, insert new profile
      final newUser = {
        'id': userId,
        'name': response.user!.userMetadata?['full_name'] ?? '',
        'email': email ?? '',
      };

      final insertedUser = await supabaseClient
          .from('profiles')
          .insert(newUser)
          .select()
          .single();
      return UserModel.fromJson(
        insertedUser,
      ).copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(
          userData.first,
        ).copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<double> getTotalEarningsForMonth({
    required String userId,
    required int month,
    required int year,
  }) async {
    try {
      final response = await supabaseClient
          .from('earnings_history')
          .select('amount')
          .eq('user_id', userId)
          .eq('month', month)
          .eq('year', year);

      if (response.isEmpty) {
        return 0.0;
      }

      // Sum all the 'amount' values for that month
      final total = response.fold<double>(
        0.0,
        (sum, record) => sum + (record['amount'] as num).toDouble(),
      );

      return total;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }
}
