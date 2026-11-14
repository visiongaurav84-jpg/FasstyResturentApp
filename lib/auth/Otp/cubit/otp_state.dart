part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoaded extends OtpState {
  String msg;
  OtpLoaded({required this.msg});
}

class OtpResendLoaded extends OtpState {
  String msg;
  OtpResendLoaded({required this.msg});
}

class OtpLoading extends OtpState {}

class OtpError extends OtpState {
  String error;
  OtpError({required this.error});
}
