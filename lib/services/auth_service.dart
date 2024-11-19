import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2_app/models/app_user.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // sign up a new user
  // (?) means the (AppUser) value can be null
  static Future<AppUser?> signUp(String email, String password) async {
    //try catch is to catch any errors if there are any
    try {
      // when we sign up we get back an object (usercredential) // (_firebaseAuth) has to be called with because its the one that connects to firebase auth
      // (createUserWithEmailAndPassword) is a method in it // this whole method signs up a user with firebase
      final UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // we will get (credential) back we get access to a user object on it, which is the user firebase just created
      // user might be null because credentials that were not allowed or password too short, email already exist // below is to check valid credential or user value[is it null]
      if (credential.user != null) {
        // the (signup) function we set has to return an (appuser) or null because of (?)
        // the fields that are in app user as required also exists in (credential.user) so we declare as the required and set the uid and email in here as the credential in firebase // the uid and email will be set in (appuser) model
        return AppUser(
            // (!) is to say we know its not gonna be empty on before it or on it
            uid: credential.user!.uid,
            email: credential.user!.email!);
      }

      // firebase said no to signing up the user , credential.user will not be gotten, return null.
      return null;
    } catch (e) {
      return null; // if we get a null value[if the info didnt send] we can show you cant sign up with these credentials
    }
  }

  // Log Out

  // (signOut()) doesnt need an arguement passed in it bcs firebase take the json web token for the user and deletes it to say theyre signed out
  static Future<void> signOut() async {
    await _firebaseAuth.signOut(); // this is the function
  }

  // sign users in
  static Future<AppUser?> signIn(String email, String password) async {
    //try catch is to catch any errors if there are any
    try {
      // when we sign in we get back an object (usercredential) // (_firebaseAuth) has to be called with because its the one that connects to firebase auth
      // (signInWithEmailAndPassword) is a method in it // this whole method signs in a user with firebase
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // we will get (credential) back we get access to a user object on it, which is the user firebase just created
      // user might be null because credentials that were not allowed or password too short, email already exist // below is to check valid credential or user value[is it null]
      if (credential.user != null) {
        // the (signup) function we set has to return an (appuser) or null because of (?)
        // the fields that are in app user as required also exists in (credential.user) so we declare as the required and set the uid and email in here as the credential in firebase // the uid and email will be set in (appuser) model
        return AppUser(
            // (!) is to say we know its not gonna be empty on before it or on it
            uid: credential.user!.uid,
            email: credential.user!.email!);
      }

      // if we dont have a user we return null if we dont sign in
      return null;
    } catch (e) {
      return null; // if we get some other kind of error
    }
  }
}
