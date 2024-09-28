
abstract class AuthState {}

final class InitialAuthState extends AuthState {}

/// -------------------Logging States----------------------->

final class LoggingLoadingState extends AuthState {}

final class LoggingSuccessfulState extends AuthState {}

final class LoggingErrorState extends AuthState {
  // we create contractor to emit the error message inside to the user .
  final String message;
  LoggingErrorState(this.message);
}

/// -------------------Register States----------------------->

final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessfulState extends AuthState {}

final class RegisterErrorState extends AuthState {
  // we create contractor to emit the error message inside to the user .
  final String message;
  RegisterErrorState(this.message);
}

/// -------------------Reset Password States----------------------->

final class ResetPasswordLoadingState extends AuthState {}

final class ResetPasswordSuccessfulState extends AuthState {}

final class ResetPasswordErrorState extends AuthState {
  // we create contractor to emit the error message inside to the user .
  final String message;
  ResetPasswordErrorState(this.message);
}

/// -------------------SigningOut States----------------------->

final class SigningOutLoadingState extends AuthState {}

final class SigningOutSuccessfulState extends AuthState {}

final class SigningOutErrorState extends AuthState {
  // we create contractor to emit the error message inside to the user .
  final String message;
  SigningOutErrorState(this.message);
}

/// -------------------toggle password States----------------------->

final class TogglePasswordState extends AuthState {}

final class PickImageState extends AuthState {}
