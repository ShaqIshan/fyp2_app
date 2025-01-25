// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/child_name/child_name_input.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/sign_in_up/sign_wrapper.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/welcome/welcome_page.dart';

//firebase,riverpod,login logout imports
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_wrapper.dart';
import 'package:fyp2_app/models/parents_models/app_user.dart';
import 'package:fyp2_app/providers/auth_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize TTS
  final FlutterTts flutterTts = FlutterTts();
  await flutterTts.getDefaultEngine;

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set the orientation to portrait for better user experience
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MultiTalk AAC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Consumer(builder: (context, ref, child) {
          final AsyncValue<AppUser?> user = ref.watch(authProvider);
          return user.when(data: (value) {
            print("\n--- Main.dart Navigation Debug ---");
            print("Auth state value: ${value?.email}");
            final isNewSignup = ref.watch(isNewSignupProvider);
            print("IsNewSignup value: $isNewSignup");
            print(
                "Current navigation target: ${value == null ? 'WelcomePage' : isNewSignup ? 'ChildNameInput' : 'ParentWrapper'}");
            print("--------------------------------\n");
            // user isnt logged in
            if (value == null) {
              return const WelcomePage();
            }
            if (isNewSignup) {
              // For new signups, show child name input
              return const ChildNameInput();
            } else {
              // For existing users, go straight to parent wrapper
              return ParentWrapper();
            }
          }, error: (error, stack) {
            print("Auth error: $error"); // Debug print
            return const Text('Error Loading Auth Status...');
          }, loading: () {
            print("Auth loading..."); // Debug print
            return const CircularProgressIndicator();
          });
        }));
  }
}
