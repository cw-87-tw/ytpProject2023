import 'package:firebase_auth/firebase_auth.dart';

String getCurrentUserId() {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String userId = user.uid;
    return userId;
  } else {
    Error();
  }

  return "";
}
