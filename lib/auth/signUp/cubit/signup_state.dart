part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoaded extends SignupState {
  String msg;
  SignupLoaded({required this.msg});
}

class SignupImageLoaded extends SignupState {
  String? imagePath;
  SignupImageLoaded({this.imagePath});
}


class SignupLoading extends SignupState {}

class SignupError extends SignupState {
  String error;
  SignupError({required this.error});
}
