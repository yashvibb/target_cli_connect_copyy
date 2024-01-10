import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:target_cli_connect_copyy/contact/Screens/contact_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyD3yi0axZ6x10ccBjUw7Tsmr4SKPvKj7RA',
      appId: '1:921530642310:android:07326c3821c72b6b794607',
      messagingSenderId: '921530642310',
      projectId: 'cli-firebase-7e997',
      storageBucket: 'cli-firebase-7e997.appspot.com',
    ),
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      home: ContactPage(),
    );
  }
}
// routes: {
//   '/': (context) => SplashScreen(
//     child: LoginPage(),
//   ),
//   '/login': (context) => LoginPage(),
//   '/signUp': (context) => SignUpPage(),
//   '/home': (context) => ContactPage(),
// },