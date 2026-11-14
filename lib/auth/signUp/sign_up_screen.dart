import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../helper/app_utilities/app_theme.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/modelAuth/modelSignUp.dart';
import '../Otp/otp_screen.dart';
import 'cubit/signup_cubit.dart';

enum RestaurantType { veg, nonVeg, both }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final restaurantCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final aadhaarCtrl = TextEditingController();
  final panCtrl = TextEditingController();
  final openingTimeCtrl = TextEditingController();
  final closingTimeCtrl = TextEditingController();


  RestaurantType? restaurantType;
  bool isAccepted = false;
  File? profileImage;
  String? uploadedImagePath;

  late SignupCubit _cubit;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameCtrl.text = "Gaurav Awasthi";
    restaurantCtrl.text = "Roshan Sharma";
    mobileCtrl.text = "9558252277";
    descriptionCtrl.text = "Best food in town";
    emailCtrl.text = "letsperf768308@gmail.com";
    passwordCtrl.text = "123456";
    confirmPasswordCtrl.text = "123456";
    aadhaarCtrl.text = "123412341237";
    panCtrl.text = "ABCDE1234P";
    openingTimeCtrl.text = "14:00";
    closingTimeCtrl.text = "23:00";


    _cubit = context.read<SignupCubit>();
  }

  Future<void> pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 70);
    if (picked != null) {
      setState(() => profileImage = File(picked.path));
    }

    _cubit.uploadPhoto(picked!.path);
  }

  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (restaurantType == null) {
      MethodUtils.toast("Please select restaurant type");
      return;
    }

    if (!isAccepted) {
      MethodUtils.toast("Please accept Terms & Privacy");
      return;
    }

    if (profileImage == null) {
      MethodUtils.toast("Please select profile image");
      return;
    }

    final nameParts = nameCtrl.text.trim().split(" ");
    final firstName = nameParts.first;
    final lastName =
    nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";

    _cubit.signUpValidation(
      SignupRequest(
        id: 0,
        isActive: false,
        restaurantName: restaurantCtrl.text.trim(),
        firstName: firstName,
        lastName: lastName,
        number: mobileCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        pan: panCtrl.text.trim(),
        aadhar: aadhaarCtrl.text.trim(),
        logoUrl: profileImage!.path,
        restaurantDes: descriptionCtrl.text.trim(),
        password: passwordCtrl.text,
        restaurantType: restaurantType!.index, // 0=Veg,1=NonVeg,2=Both

        isApproved: false,
        openingTime: openingTimeCtrl.text,
        closingTime: closingTimeCtrl.text,
        address: "Flat no 424, NOida",
        city: "Noida",
        state: "UP",
        pincode: "201301",
        latitude: 28.644800,
        longitude: 77.216721,
        averageRating: 0,
        totalReviews: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SignupCubit, SignupState>(
        builder: (context, state) {
          if (state is SignupLoading) {
            return Stack(
              children: [
                body(),
                const AppLoaderProgress(),
              ],
            );
          }
          return body();
        },
        listener: (context, state) {
          if (state is SignupError && state.error.isNotEmpty) {
            MethodUtils.toast(state.error);
          } else if (state is SignupLoaded) {
            if (state.msg == "Restaurant created successfully") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OtpScreen(
                    email: emailCtrl.text,
                    comeFrom: 'SignUp',
                  ),
                ),
              );
            } else {
              MethodUtils.toast(state.msg);
            }
          }else if (state is SignupImageLoaded) {
            uploadedImagePath = state.imagePath ?? "";
            print("Uploaded Image Path: ${uploadedImagePath}");
          }
        },
      ),
    );
  }

  Widget body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// HEADER
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Create\nYour\nAccount",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: showImagePicker,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage: profileImage != null
                                ? FileImage(profileImage!)
                                : null,
                            child: profileImage == null
                                ? const Icon(Icons.camera_alt,
                                color: Colors.grey)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _field(nameCtrl, "Full Name", Icons.person_outline),
                    _space(),
                    _field(restaurantCtrl, "Restaurant Name", Icons.restaurant),
                    _space(),
                    _field(
                      mobileCtrl,
                      "Mobile Number",
                      Icons.phone,
                      keyboard: TextInputType.phone,
                      validator: (v) =>
                      RegExp(r'^[0-9]{10}$').hasMatch(v ?? "")
                          ? null
                          : "Enter valid 10-digit number",
                    ),
                    _space(),
                    _field(
                      descriptionCtrl,
                      "Restaurant Description",
                      Icons.description,
                      maxLines: 4,
                      validator: (v) =>
                      (v ?? "").length < 10 ? "Minimum 10 characters" : null,
                    ),

                    _space(height: 20),

                    /// RESTAURANT TYPE
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Restaurant Type",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        _restaurantRadio(RestaurantType.veg, "Veg"),
                        _restaurantRadio(RestaurantType.nonVeg, "Non-Veg"),
                        _restaurantRadio(RestaurantType.both, "Both"),
                      ],
                    ),

                    _space(),
                    _field(
                      emailCtrl,
                      "Email Address",
                      Icons.email_outlined,
                      validator: (v) => RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                          .hasMatch(v ?? "")
                          ? null
                          : "Enter valid email",
                    ),
                    _space(),
                    _field(
                      panCtrl,
                      "PAN Number",
                      Icons.credit_card,
                      validator: (v) => RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$')
                          .hasMatch(v ?? "")
                          ? null
                          : "Enter valid PAN",
                    ),
                    _space(),
                    _field(
                      aadhaarCtrl,
                      "Aadhaar Number",
                      Icons.badge_outlined,
                      keyboard: TextInputType.number,
                      validator: (v) =>
                      RegExp(r'^[0-9]{12}$').hasMatch(v ?? "")
                          ? null
                          : "Enter valid Aadhaar",
                    ),
                    _space(),

                    Row(
                      children: [
                        Expanded(
                          child: _timeField(
                            openingTimeCtrl,
                            "Opening Time",
                            Icons.access_time,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _timeField(
                            closingTimeCtrl,
                            "Closing Time",
                            Icons.access_time_filled,
                          ),
                        ),
                      ],
                    ),

                    _space(),

                    _field(
                      passwordCtrl,
                      "Password",
                      Icons.lock_outline,
                      obscure: true,
                      validator: (v) =>
                      (v ?? "").length < 6 ? "Min 6 characters" : null,
                    ),
                    _space(),
                    _field(
                      confirmPasswordCtrl,
                      "Confirm Password",
                      Icons.lock_outline,
                      obscure: true,
                      validator: (v) =>
                      v != passwordCtrl.text ? "Password mismatch" : null,
                    ),

                    _space(height: 20),

                    Row(
                      children: [
                        Checkbox(
                          value: isAccepted,
                          onChanged: (v) =>
                              setState(() => isAccepted = v!),
                        ),
                        const Expanded(
                            child: Text("I agree to Terms & Privacy")),
                      ],
                    ),

                    _space(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text("Sign Up"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _restaurantRadio(RestaurantType value, String label) {
    return Expanded(
      child: Row(
        children: [
          Radio<RestaurantType>(
            value: value,
            groupValue: restaurantType,
            activeColor: primaryColor,
            onChanged: (v) => setState(() => restaurantType = v),
          ),
          Text(label),
        ],
      ),
    );
  }

  Widget _timeField(
      TextEditingController controller,
      String hint,
      IconData icon,
      ) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => pickTime(controller),
      validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }


  Widget _field(
      TextEditingController c,
      String hint,
      IconData icon, {
        String? Function(String?)? validator,
        bool obscure = false,
        TextInputType keyboard = TextInputType.text,
        int maxLines = 1,
      }) {
    return TextFormField(
      controller: c,
      obscureText: obscure,
      keyboardType: keyboard,
      maxLines: maxLines,
      validator: validator ??
              (v) => (v == null || v.isEmpty) ? "Required field" : null,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _space({double height = 16}) => SizedBox(height: height);

  Future<void> pickTime(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      controller.text = "$hour:$minute";
    }
  }

}
