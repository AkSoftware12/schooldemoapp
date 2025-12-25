import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_state_provider.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _isLoading = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // 🔥 API success ke baad
      ref.read(authStateProvider.notifier).state =
          AuthStatus.loggedIn;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.sp),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/loginbg3.png',
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          // 🔹 Card with custom notch shape
                          Padding(
                            padding:  EdgeInsets.only(top: 60.sp),
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              margin: EdgeInsets.only(bottom: 30.sp),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                                side: BorderSide(
                                  color: AppColors.primary,
                                  width: 1.sp, // 👈 border thickness
                                ),

                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(12.sp),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [


                                    SizedBox(height: 100.sp),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Email & Admission number',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                     SizedBox(height: 5.sp),

                                    TextFormField(
                                      controller: _emailController,
                                      validator: Validators.email,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email,
                                            color: AppColors.primary),
                                        hintText: 'Email',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 16),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Password',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.sp),

                                    // 🔒 Password
                                    TextFormField(
                                      controller: _passwordController,
                                      validator: Validators.password,
                                      obscureText: _obscure,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock,
                                            color: AppColors.primary),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscure
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: AppColors.primary,
                                          ),
                                          onPressed: () {
                                            setState(() => _obscure = !_obscure);
                                          },
                                        ),
                                        hintText: 'Password',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30.sp),

                                  ],
                                ),
                              ),
                            ),
                          ),

                          // 🔹 Circular button inside notch
                          Positioned(
                            bottom: 10,
                            child: SizedBox(
                              width: 150.sp,
                              height: 40.sp,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  // color: HexColor('d63b7e'),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      Colors.blue.shade400,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20.sp),
                                ),
                                child: ElevatedButton(
                                    onPressed: _isLoading ? null : _login,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          20.sp,
                                        ),
                                      ),
                                    ),
                                    child: _isLoading
                                        ? SizedBox(
                                      height: 20.sp,
                                      width: 20.sp,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                        : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Login',
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        SizedBox(width: 8.sp),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 16.sp,
                                        ),
                                      ],
                                    )

                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: Column(
                              children: [
                                Container(
                                  width: 120.sp,
                                  height: 120.sp,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20.sp),
                                      border: Border.all(width: 1,color: AppColors.primary)
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    child: Image.asset(
                                      'assets/playstore.jpg',
                                      width: 120.sp,
                                      height: 120.sp,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                Text(
                                  'School Demo App',
                                  style: GoogleFonts.poppins(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    letterSpacing: 1.5,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(2.0, 2.0),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.sp),

                    // Terms and conditions
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.sp),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'By using your email & admission number you accept our ',
                          style: GoogleFonts.roboto(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: GoogleFonts.roboto(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (_) => const PrivacyPage()),
                                  // );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.sp),
              child: Container(
                height: 50.sp,
                color: AppColors.primary,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Provided by ',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                      children: [
                        TextSpan(
                          text: 'Ak Software',
                          style: GoogleFonts.poppins(
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            decoration: TextDecoration.none,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Ak Software Clicked");
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
