import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_hub/core/usecase/usecase.dart';
import 'package:blog_hub/features/auth/domain/usecases/user_signup.dart';
import 'package:meta/meta.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/common/entities/user.dart';
import '../../domain/usecases/current_user.dart';
import '../../domain/usecases/user_signin.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({required UserSignUp userSignUp, required UserSignIn userSignIn, required CurrentUser currentUser, required AppUserCubit appUserCubit})
      : _userSignUp= userSignUp, _userSignIn= userSignIn, _currentUser= currentUser, _appUserCubit = appUserCubit , super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(AuthIsUserLoggedIn event, Emitter<AuthState> emit) async{
    emit(AuthLoading());
    final res = await _currentUser(NoParameters());
    res.fold(
            (l) => emit(AuthFailure(l.message)),
            (r) => _emitAuthSuccess(r, emit)
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async{
      emit(AuthLoading());
      final res = await _userSignUp(
          UserSignUpParams(
              name: event.name,
              email: event.email,
              password: event.password
          )
      );
      res.fold(
              (failure) => emit(AuthFailure(failure.message)),
              (user) => _emitAuthSuccess(user, emit)
      );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async{
    emit(AuthLoading());
    final res = await _userSignIn.call(
      UserSignInParams(
          email: event.email,
          password: event.password
      )
    );
    res.fold(
            (l) => emit(AuthFailure(l.message)),
            (r) => _emitAuthSuccess(r, emit)
    );

  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit){
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
