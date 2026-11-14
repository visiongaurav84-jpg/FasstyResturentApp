import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../helper/app_utilities/method_utils.dart';
import '../../../../helper/constant/appMessages.dart';
import '../../../../network_configs/networkRequest.dart';
import '../../../Model/reposeCallBack.dart';
import '../../../menu/Item/repo/itemRepo.dart';
import '../../../model/modelAuth/modelSignUp.dart';
import '../repo/signupRepo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final SignupRepo signUpRepo =
  SignupRepo(networkRequest: NetworkRequest());

  final ItemRepo itemRepo =
  ItemRepo(networkRequest: NetworkRequest());

  /// Entry point
  void signUpValidation(SignupRequest request) {
    final String? error = _validateFields(request);

    if (error != null) {
      emit(SignupError(error: error));
      return;
    }

    _validateSignup(request);
  }

  /// Validation logic
  String? _validateFields(SignupRequest request) {
    if (request.restaurantName.isEmpty) {
      return AppMessages.restaurantName;
    }

    if (request.firstName.isEmpty) {
      return AppMessages.firtName;
    }

    if (request.lastName.isEmpty) {
      return AppMessages.lastName;
    }

    if (request.email.isEmpty) {
      return AppMessages.email;
    }

    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(request.email)) {
      return AppMessages.validEmail;
    }

    if (request.number.isEmpty) {
      return AppMessages.validMobile;
    }

    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(request.number)) {
      return AppMessages.validMobile;
    }

    if (request.password.isEmpty) {
      return AppMessages.password;
    }

    if (request.pan.isEmpty) {
      return AppMessages.pan;
    }

    if (request.aadhar.isEmpty) {
      return AppMessages.aadhar;
    }

    return null;
  }

  /// API call
  Future<void> _validateSignup(SignupRequest request) async {
    emit(SignupLoading());

    if (!await MethodUtils.isInternetPresent()) {
      emit(SignupError(error: AppMessages.getNoInternetMsg));
      return;
    }

    try {
      final ApiResponse<ModelSignUP> apiResponse =
      await signUpRepo.validSignUp(request);

      if (apiResponse.isSuccess && apiResponse.resObject != null) {
        final ModelSignUP response = apiResponse.resObject!;

        MethodUtils.toast(response.message ?? "");

        emit(
          SignupLoaded(
            msg: response.message ?? "",
          ),
        );
      } else {
        emit(
          SignupError(
            error: apiResponse.errorCause,
          ),
        );
      }
    } catch (e) {
      debugPrint("Signup Cubit Error: $e");

      emit(
        SignupError(
          error: "This email or phone already exists!",
        ),
      );
    }
  }


  /// Upload Items
  void uploadPhoto(String imageFile) async {
    try {
      emit(SignupLoading());
      if (await MethodUtils.isInternetPresent()) {
        final response = await itemRepo.uploadImage(imageFile, "ItemImages");
        if (response.isSuccess) {
          emit(SignupImageLoaded(imagePath: response.resObject?["cloudinaryUrl"]));
        } else {
          emit(SignupError(error: response.errorCause));
        }
      } else {
        emit(SignupError(error: AppMessages.getNoInternetMsg));
      }
    } catch (e) {
      emit(SignupError(error: e.toString()));
    }
  }

  void refresh() {
    emit(SignupInitial());
  }
}
