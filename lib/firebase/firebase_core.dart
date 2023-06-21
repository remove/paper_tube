import 'package:firebase_core/firebase_core.dart';
import 'package:paper_tube/firebase_options.dart';

class FireBaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
