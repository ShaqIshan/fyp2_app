import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp2_app/models/app_user.dart';

// dispose this stream provider when not being used to free recources
final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async* {
  print("Auth provider stream started");

  // (async *) is to know well yield several values overtime and not returning any value // YEILD is now replaced with return down there

  // subscribe to firebaseauth changes which return a stream which can be user or null

  // were making a stream that will eventually return app user or null (<AppUser?>) // well get the value overtime when diff auth events occur like logging in or out
  // (authStateChanges) returns a stream of values which are null(logout) or firebase user object (log in, sign up)
  // firebase user object returns so many unnecessary things we dont need so were gonna map it and put (user) as the variable that will run by each value that comes back and in (Appuser) return we call that user variable which has all the values in firebase user and only get uid and email which already exists as variables as well in firebase
  final Stream<AppUser?> userStream =
      FirebaseAuth.instance.authStateChanges().map((user) {
    print("Auth state changed: ${user?.email}"); // Debug print

    if (user != null) {
      return AppUser(uid: user.uid, email: user.email!);
    }
    // if user is null meaning user logged out or unauthenticated
    return null;
  });

  // [yield that value when it changes] every value we get back from that stream to provide each (streamprovider) to any that consumes it later on [so consumers can access it}
  await for (final user in userStream) {
    print("Yielding user: ${user?.email}"); // Debug print

    yield user;
  }
});
