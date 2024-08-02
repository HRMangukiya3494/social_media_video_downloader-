import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_video_downloader/views/routes/AppRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();
  // try {
  //   GoogleAdsHelper.googleAdsHelper.loadAppOpenAd();
  // } catch (e) {
  //   log("$e");
  // }

  // await PermissionService.checkAndRequestPermissions();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.BOTTOMNAVIIGATION,
      getPages: AppRoutes.routes,
    );
  }
}