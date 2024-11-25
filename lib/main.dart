import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/childs_assessment/assess_wrapper.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/child_name/child_name_input.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/sign_in_up/sign_wrapper.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/welcome/welcome_page.dart';

//firebase,riverpod,login logout imports
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics_wrapper/levels/animal_puzzle_game/animal_puzzle_wrapper.dart';
import 'package:fyp2_app/Screens/child_screens/child_wrapper.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_wrapper.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/child_games_wrapper.dart';
import 'package:fyp2_app/models/app_user.dart';
import 'package:fyp2_app/providers/auth_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

        // (builder) gives access to a ref object we can use to watch authprovider state // and it lets us run logic inside it to conditionally return diff widgets or widget trees which might get rendered here
        // (context) is what we get to rebuild that screen or maybe screens
        home: Consumer(builder: (context, ref, child) {
          // now we user the ref to access the authprovider state
          // (AsyncValue) is a value we access asyncronously // we get access to loading, finished and error states that we can handle differently which is gotten form the (.when) method // specifying (authprovider) as an async value
          // (ref.watch()) lets us watch a provider for state values, (authProvider) inside it is the provider its watching
          final AsyncValue<AppUser?> user = ref.watch(authProvider);

          // everytime that provider yields a new value we get access to it

          // react to diff states of this async data // pass each one of states as a named arguement // value of each arguement should be a funciton that gets fired when the state occurs
          // (data :) data is received and read // new stream value yielded from provider if its user or null
          // (data: (value)) we get value back from the stream and get access to it as (user)
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

            // if we have a user value in (appuser) means user is logged in

            // for this we need to make an if statement to go to home page , if cant eye contact and set child to low and so forth

            // TODO: When implementing state management, this can be replaced with:
            // final userProfile = ref.watch(userProfileProvider(value.uid));
            // bool isNewSignup = userProfile.data?.isNew ?? true;

            if (isNewSignup) {
              // For new signups, show child name input
              return const ChildNameInput();
            } else {
              // For existing users, go straight to parent wrapper
              return ChildWrapper();
            }

            // its supposed to be below here but replace for a while to assess
            // return ParentHome(user: value);
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
