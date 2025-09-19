import 'package:freelancer_visuals/core/error/exceptions.dart';
import 'package:freelancer_visuals/core/secrets/app_secrets.dart';
import 'package:freelancer_visuals/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  // Future<AuthResponse> googleSignUp(String name, String email, String password);
  Future<UserModel> handleGoogleAuth();
  // Future<void> signOut();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasourceImpl(this.supabaseClient);

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
      return UserModel.fromJson(response.user!.toJson());
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
      return UserModel.fromJson(response.user!.toJson());
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
        return UserModel.fromJson(existingUser);
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
      return UserModel.fromJson(insertedUser);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<void> signOut() async {
  //   await supabaseClient.auth.signOut();
  // }
}
  // @override
  // Future<AuthResponse> googleSignUp(
  //   String name,
  //   String email,
  //   String password,
  // ) async {
  //   const webClientId = AppSecrets.webClientId;
  //   const iosClientId = AppSecrets.iosClientId;

  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  //     await googleSignIn.initialize(
  //       clientId: iosClientId,
  //       serverClientId: webClientId,
  //     );

  //     final response = await supabaseClient.auth.signUp(
  //       email: email,
  //       password: password,
  //       data: {'name': name},
  //     );
  //     if (response.user == null) {
  //       throw const ServerException('Unsuccessful Login with Google!');
  //     }
  //     return response;
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }