import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(
  );
  const FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyA-bQlTD2rl2XUifcTo_d8Dn2wWA40lke4',
    appId: '1:115463759322:android:cb028cfff3094f6f6f8ce3',
    messagingSenderId: '115463759322',
    projectId: 'buzz-chat-41728',
    databaseURL: 'https://buzz-chat-41728.firebaseio.com',
    storageBucket: 'buzz-chat-41728.appspot.com',
  );
  await Firebase.initializeApp(
    options: firebaseOptions
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
