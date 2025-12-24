import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// App-wide auth status
enum AuthStatus {
  unknown,   // App start (Splash)
  loggedIn,  // Dashboard
  loggedOut, // Login
}

/// Global auth state provider
final authStateProvider =
StateProvider<AuthStatus>((ref) => AuthStatus.unknown);
