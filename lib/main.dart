import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/screens/login_screens.dart';
import 'package:flutter_instagram_clone/screens/sign_up_screen.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase options for web and mobile because they works differently, if not the app  gonna crash
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyBHZBhdu35h0pjO64R3olhzm2kAmFyqICE',
            appId: '1:599115405775:web:776c6b8bdc88a2d9029aba',
            messagingSenderId: '599115405775',
            projectId: 'instagram-clone-bb77e',
            storageBucket: 'instagram-clone-bb77e.appspot.com'));
  } else {
    //access firebase for mobile
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        // home: const ResponsiveLayout(
        //     webScreenLayout: WebScreenLayout(),
        //     mobileScreenLayout: MobileScreenLayout())
        home: LoginScreen());
  }
}
