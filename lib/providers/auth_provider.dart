// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp2_app/models/parents_models/app_user.dart';
import 'package:fyp2_app/services/auth_service.dart';

final isNewSignupProvider =
    StateProvider<bool>((ref) => AuthService.isNewSignup);

final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async* {
  print("Auth provider stream started");

  await for (final User? user in FirebaseAuth.instance.authStateChanges()) {
    print("\n--- Auth State Change ---");
    print("User: ${user?.email}");
    print("IsNewSignup value: ${AuthService.isNewSignup}");

    if (user != null) {
      print("Setting isNewSignup to: ${AuthService.isNewSignup}");
      ref.read(isNewSignupProvider.notifier).state = AuthService.isNewSignup;
      yield AppUser(uid: user.uid, email: user.email!);
    } else {
      print("User logged out");
      ref.read(isNewSignupProvider.notifier).state = false;
      yield null;
    }
  }
});
