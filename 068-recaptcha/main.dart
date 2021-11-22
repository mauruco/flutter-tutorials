import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*
  android/app/build.gradle
  defaultConfig {
    ...
      minSdkVersion 20
    ...
  }
*/
/*
  ios/Runner/Info.plist
  ...
	<dict>
	    <key>NSAllowsArbitraryLoads</key>
	    <true />
	</dict>
  ...
*/
/*
  android/app/src/main/AndroidManifest.xml
  <manifest xmlns:android="http://schemas.android.com/apk/res/android"
      package="...">
    <application
        ...
        android:usesCleartextTraffic="true"
        ...
  ...
*/

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static var title = 'Flutter App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open Recaptcha'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Recaptcha()),
            );
          },
        ),
      ),
    );
  }
}

class Recaptcha extends StatelessWidget {
  const Recaptcha({Key? key}) : super(key: key);
  static var title = 'Captcha';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Recaptcha.title),
        centerTitle: true,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "http://172.17.0.2:8181/ms-auth/v1/recaptcha",
        javascriptChannels: Set.from([
          JavascriptChannel(
              name: 'Captcha',
              onMessageReceived: (JavascriptMessage message) {
                print('Message Ready');
                print(message.message);
                Navigator.pop(context);
              })
        ]),
        onWebViewCreated: (controller) {
          print('WebViewCreated');
        },
      ),
    );
  }
}