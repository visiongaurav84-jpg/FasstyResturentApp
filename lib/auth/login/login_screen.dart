import 'package:fassty_resturents_app/auth/signUp/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/app_utilities/app_theme.dart';
import '../../helper/app_utilities/method_utils.dart';
import '../../helper/custom_widgets/app_circular_loader.dart';
import '../../home/approval_status_screen.dart';
import '../forgot_password_BottomSheet.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  late LoginCubit _cubit;


  /// Email OR Phone validation
  String? _validateEmailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email or phone number is required";
    }

    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^[0-9]{10}$');

    if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
      return "Enter a valid email or 10-digit phone number";
    }

    return null;
  }

  /// Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    // if (value.length < 6) {
    //   return "Password must be at least 6 characters";
    // }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = "vision.gaurav84@gmail.com";
    _passwordController.text = "123456";
    _cubit = context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
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
          if (state is LoginError && state.error.isNotEmpty) {
            MethodUtils.toast(state.error);
          } else if (state is LoginLoaded) {
            if (state.msg == "Admin login successful.") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ApprovalStatusScreen(
                        status: ApprovalStatus.approved,
                      ),
                ),
              );
            } else {
              MethodUtils.toast(state.msg);
            }
          }
        },
      ),
    );
  }

  Widget body(){
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),

            Center(
              child: Image.asset(
                'assets/images/appLogo.png',
                height: 180,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Fassty",
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.amber[600],
              ),
            ),
            Text(
              "Restaurants APP",
              style: GoogleFonts.poppins(
                fontSize: 14,
                letterSpacing: 2,
                color: Colors.white.withOpacity(0.9),
              ),
            ),

            const SizedBox(height: 40),

            /// --- Email / Phone Field ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: _emailController,
                validator: _validateEmailOrPhone,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: "Email or Phone",
                  hintStyle:
                  GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                  prefixIcon: const Icon(Icons.email_outlined,
                      color: Colors.white, size: 20),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  errorStyle: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// --- Password Field ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                validator: _validatePassword,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle:
                  GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: Colors.white, size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  errorStyle: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ),

            const Spacer(),

            /// --- Bottom Container ---
            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        forgotPasswordBottomSheet(context);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.poppins(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// --- Login Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _cubit.loginUser(_emailController.text, _passwordController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text("or",
                      style: GoogleFonts.poppins(color: Colors.grey)),

                  const SizedBox(height: 16),

                  /// --- Create Account ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: subPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Create an account",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void forgotPasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return const ForgotPasswordScreen();
      },
    );
  }
}
