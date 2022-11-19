import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:flutter_instagram_clone/responsive/web_screen_layout.dart';
import 'package:flutter_instagram_clone/screens/home_screens.dart';
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
      // home: LoginScreen()
      home: StreamBuilder(
        //auth state only changes when sign in or sign out
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          //check if connection has been made with a stream or not
          if (snapshot.connectionState == ConnectionState.active) {
            //check if snapshot has data or not
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return LoginScreen();
        }),
      ),
    );
  }
}
