import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/auth/presentation/pages/dashboard_page.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/auth/presentation/providers/auth_state_provider.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    Widget home;

    switch (authState) {
      case AuthStatus.unknown:
        home = const SplashPage();
        break;
      case AuthStatus.loggedIn:
        home = const DashboardPage();
        break;
      case AuthStatus.loggedOut:
        home = const LoginPage();
        break;
    }

    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School App',
        home: home,
      ),

    );



  }
}
