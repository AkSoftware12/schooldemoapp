import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/auth_state_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 5));
    final bool isLoggedIn = false;

    ref.read(authStateProvider.notifier).state =
    isLoggedIn ? AuthStatus.loggedIn : AuthStatus.loggedOut;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150.sp,
                  width: 150.sp,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.sp))
                  ),
                  child:   Padding(
                    padding:  EdgeInsets.all(15.sp),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.sp),

                      child: Image.asset(
                        'assets/playstore.jpg',
                        width: 80.sp,
                        height: 80.sp,
                      ),
                    ),
                  ),
                ),
                // Logo image

                SizedBox(height: 10.sp), // Spacing between logo and app name
                // App name
                Text(
                  'School Demo App', // Replace with your app name
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for contrast
                  ),
                ),

                SizedBox(height: 10.sp), // Spacing before loader
                Container(
                  height: 60.sp,
                  width: 60.sp,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5.sp),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Lottie.asset(
                      'assets/loadingbar.json',
                      height: 50.sp,
                      width: 50.sp,
                      fit: BoxFit.cover,
                      delegates: LottieDelegates(
                        values: [
                          // 🎨 Apply a global color tint (change to your desired color)
                          ValueDelegate.color(
                            const ['**'], // Apply to all layers
                            value: Colors.white, // Change this to any color
                          ),
                        ],
                      ),

                    ),
                  ),
                ),

              ],
            ),
          ),


        ],
      ),
    );
  }
}
