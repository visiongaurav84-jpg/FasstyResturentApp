import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../helper/app_utilities/method_utils.dart';
import '../../../../helper/constant/appMessages.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../helper/localStorage/preference_handler.dart';
import '../repo/loginRepo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final LoginRepo loginRepo =
  LoginRepo(networkRequest: NetworkRequest());

  void loginUser(String email, String password) async {
    try {
      emit(LoginLoading());

      if (await MethodUtils.isInternetPresent()) {
        final response = await loginRepo.validLogin(
          email: email,
          password: password,
        );
        if (response.isSuccess) {
          await PreferenceHandler.setUserId(response.resObject!.data!.adminId!.toString() ?? "");

          final restaurantId = response.resObject?.data?.restaurants?.isNotEmpty == true
              ? response.resObject!.data!.restaurants!.first.id
              : null;

          if (restaurantId != null) {
            await PreferenceHandler.setUserId(restaurantId.toString());
          }


          var name = (response.resObject!.data!.fullName!.toString() ?? "");
          await PreferenceHandler.setName(name);
          await PreferenceHandler.setEmail(response.resObject!.data!.email!.toString() ?? "");
          await PreferenceHandler.setRoleId(response.resObject!.data!.role!.toString() ?? "");
          await PreferenceHandler.setLoginToken(response.resObject!.data!.token!.toString() ?? "");

          emit(LoginLoaded(
            msg: response.resObject?.message ?? "",
          ));
        } else {
          emit(LoginError(error: response.errorCause));
        }
      } else {
        emit(LoginError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      MethodUtils.toast("Invalid email or password!");
      emit(LoginError(error: ""));
    }
  }

  void refresh() {
    emit(LoginInitial());
  }
}
