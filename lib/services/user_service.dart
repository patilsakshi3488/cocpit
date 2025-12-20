import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static Future<void> createUserIfNotExists() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final docRef =
    FirebaseFirestore.instance.collection('users').doc(user.uid);

    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        'uid': user.uid,
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'profileImage': '',
        'coverImage': '',
        'headline': '',
        'location': '',
        'about': '',
        'connections': 0,
        'profileViews': 0,
        'createdAt': FieldValue.serverTimestamp(),

        // LinkedIn-style sections
        'experience': [],
        'education': [],
        'skills': [],
      });
    }
  }
}
