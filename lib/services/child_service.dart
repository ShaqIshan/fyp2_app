import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/parents_models/child_profile.dart';

class ChildService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add a new child profile
  Future<String> addChild(String name) async {
    try {
      final String userId = _auth.currentUser!.uid;

      // Create a new document in the children collection
      DocumentReference docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('children')
          .add({
        'name': name,
        'createdAt': Timestamp.now(),
        'textToSpeechEnabled': true,
        'userId': userId,
      });

      // Set as selected child if it's the first one
      await _firestore
          .collection('users')
          .doc(userId)
          .set({'selectedChildId': docRef.id}, SetOptions(merge: true));

      return docRef.id; // Return the new child's document ID
    } catch (e) {
      print('Error adding child: $e');
      throw Exception('Failed to add child profile');
    }
  }

  // Get all children for current user
  Stream<List<ChildProfile>> getChildren() {
    final String userId = _auth.currentUser!.uid;

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('children')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChildProfile(
                  id: doc.id,
                  name: doc['name'],
                  textToSpeechEnabled: doc['textToSpeechEnabled'] ?? true,
                ))
            .toList());
  }

  // Update child profile
  Future<void> updateChild(ChildProfile profile) async {
    try {
      final String userId = _auth.currentUser!.uid;

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('children')
          .doc(profile.id)
          .update({
        'name': profile.name,
        'textToSpeechEnabled': profile.textToSpeechEnabled,
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      print('Error updating child: $e');
      throw Exception('Failed to update child profile');
    }
  }
}
