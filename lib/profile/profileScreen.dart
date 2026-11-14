import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../helper/app_utilities/app_theme.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/accessDenied/accessDenied.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../model/modelAuth/modelSignUp.dart';
import '../auth/Otp/otp_screen.dart';
import '../auth/signUp/cubit/signup_cubit.dart';

enum RestaurantType { veg, nonVeg, both }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  RestaurantType? restaurantType;
  bool isAccepted = false;
  File? profileImage;

  late SignupCubit _cubit;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SignupCubit>();

    nameCtrl.text = "Gaurav Awasthi";
    restaurantCtrl.text = "Halide Ram";
    mobileCtrl.text = "9476448213";
    descriptionCtrl.text = "Best veg and non-veg food with fast delivery.";
    emailCtrl.text = "pecsdata786@gmail.com";
    passwordCtrl.text = "123456";
    confirmPasswordCtrl.text = "123456";
    aadhaarCtrl.text = "123412341234";
    panCtrl.text = "ABCDE1234F";
  }

  Future<void> pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 70);
    if (picked != null) {
      setState(() => profileImage = File(picked.path));
    }
  }

  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
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

    /// API call here
    //Navigator.pop(context);

    final nameParts = nameCtrl.text.trim().split(" ");
    final firstName = nameParts.first;
    final lastName =
    nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";

    _cubit.signUpValidation(
      SignupRequest(
        isActive: false,
        id: 0,

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
        restaurantType: restaurantType!.index, // 0,1,2

        isApproved: false,
        openingTime: "",
        closingTime: "",
        address: "",
        city: "",
        state: "",
        pincode: "",
        latitude: 0.0,
        longitude: 0.0,
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
        builder: (BuildContext context, state) {

          if (state is SignupLoaded ||
              state is SignupInitial ||
              state is SignupError) {
            return body();
          } else if (state is SignupLoading) {
            return Stack(
              children: [
                body(),
                const AppLoaderProgress(),
              ],
            );
          }
          return AccessDeniedScreen(
            onPressed: () {
              _cubit.refresh();
            },
          );
        },
        listener: (BuildContext context, state) {
          if (state is SignupError) {
            if (state.error.isNotEmpty) {
              MethodUtils.toast(state.error);
            }
          } else if (state is SignupLoaded) {
            if (state.msg! == "Restaurant Created") {
              Navigator.push(context, MaterialPageRoute(builder: (
                  context)=> OtpScreen(email: emailCtrl.text ?? "", comeFrom: 'SignUp',)));
            } else {
              MethodUtils.toast(state.msg);
              Future.delayed(const Duration(milliseconds: 500));
            }
          }
        },
      ),
    );
  }

  Widget body(){
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// HEADER
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
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
                    /// Back Button
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Your\nAccount\nDetails",
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
                            backgroundImage:
                            profileImage != null ? FileImage(profileImage!) : null,
                            child: profileImage == null
                                ? const Icon(Icons.camera_alt, color: Colors.grey)
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
                    _buildField(
                      controller: nameCtrl,
                      hint: "Full Name",
                      icon: Icons.person_outline,
                      validator: (v) => v!.isEmpty ? "Enter full name" : null,
                    ),

                    const SizedBox(height: 16),

                    _buildField(
                      controller: restaurantCtrl,
                      hint: "Restaurant Name",
                      icon: Icons.restaurant,
                      validator: (v) => v!.isEmpty ? "Enter restaurant name" : null,
                    ),

                    const SizedBox(height: 16),

                    _buildField(
                      controller: mobileCtrl,
                      hint: "Mobile Number",
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (v!.isEmpty) return "Enter mobile number";
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
                          return "Enter valid 10-digit number";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    _buildField(
                      controller: descriptionCtrl,
                      hint: "Restaurant Description",
                      icon: Icons.description,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      validator: (v) {
                        if (v!.isEmpty) return "Enter restaurant description";
                        if (v.length < 10) {
                          return "Minimum 10 characters required";
                        }
                        return null;
                      },
                    ),


                    const SizedBox(height: 20),

                    /// Restaurant Type
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Restaurant Type",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        _restaurantRadio(RestaurantType.veg, "Veg"),
                        _restaurantRadio(RestaurantType.nonVeg, "Non-Veg"),
                        _restaurantRadio(RestaurantType.both, "Both"),
                      ],
                    ),


                    const SizedBox(height: 16),

                    _buildField(
                      controller: emailCtrl,
                      hint: "Email Address",
                      icon: Icons.email_outlined,
                      validator: (v) {
                        if (v!.isEmpty) return "Enter email";
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                            .hasMatch(v)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    _buildField(
                      controller: passwordCtrl,
                      hint: "Password",
                      icon: Icons.lock_outline,
                      obscure: true,
                      validator: (v) => v!.length < 6 ? "Min 6 characters" : null,
                    ),

                    const SizedBox(height: 16),

                    _buildField(
                      controller: confirmPasswordCtrl,
                      hint: "Confirm Password",
                      icon: Icons.lock_outline,
                      obscure: true,
                      validator: (v) =>
                      v != passwordCtrl.text ? "Password mismatch" : null,
                    ),

                    const SizedBox(height: 20),

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
                        child: const Text("Update"),
                      ),
                    )
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
            onChanged: (v) {
              setState(() => restaurantType = v);
            },
          ),
          Flexible(
            child: Text(
              label,
              style: GoogleFonts.poppins(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        alignLabelWithHint: maxLines > 1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
