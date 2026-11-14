import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../helper/app_utilities/method_utils.dart';
import '../../../../helper/constant/appMessages.dart';
import '../../../../network_configs/networkRequest.dart';
import '../repo/otpRepo.dart';
part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  OtpRepo otpRepo = OtpRepo(networkRequest: NetworkRequest());

  void validSignUP(String email, String mobile, String OTP) async {
    try {
      emit(OtpLoading());
      if (await MethodUtils.isInternetPresent()) {
        final response = await otpRepo.validSignUp(email: email, phone: mobile, otp: OTP,);
        if (response.isSuccess) {
          emit(OtpLoaded(
            msg: response.resObject?.message ?? ""
          ));
        } else {
          emit(OtpError(error: response.errorCause));
        }
      } else {
        emit(OtpError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      MethodUtils.toast("This email or Phone already exists!");
      emit(OtpError(error: ""));
    }
  }

  void refresh() {
    emit(OtpInitial());
  }
}
