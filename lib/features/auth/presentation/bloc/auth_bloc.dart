import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/features/auth/domain/entities/user.dart';
import 'package:freelancer_visuals/features/auth/domain/usecases/google_auth.dart';
import 'package:freelancer_visuals/features/auth/domain/usecases/user_login.dart';
import 'package:freelancer_visuals/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final GoogleAuth _googleUser;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required GoogleAuth googleUser,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _googleUser = googleUser,
       super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthGoogle>(_onAuthGoogle);
  }
  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthGoogle(AuthGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _googleUser();
    res.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
  }
}
