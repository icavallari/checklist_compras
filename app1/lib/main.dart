import 'package:app1/src/ui/home.dart';
import 'package:app1/src/ui/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(Home());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Splash();
        } else {
          // Loading is done, return the app:
          return Home();
        }
      },
    );
  }
}
