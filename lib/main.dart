import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intergez_webview/Views/SplashScreen/View/splash_screen_view.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("7279cfd2-e865-4713-896f-27fc971d0b1e");

  // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  runApp(
      Phoenix(
          child: IntergezWebView(),
      ),
  );
}

class IntergezWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Intergez',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.white,
            primaryColor: Color(0xffB03242),
            primarySwatch: Colors.red,
            canvasColor: Colors.grey.shade900),
        home: SplashScreenView(),
    );
  }
}
