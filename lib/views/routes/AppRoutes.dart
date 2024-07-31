import 'package:get/get.dart';
import 'package:social_media_video_downloader/views/screens/HomePage.dart';

class AppRoutes {
  static const String HOME = "/";

  static final routes = [
    GetPage(
      name: HOME,
      page: () => HomePage(),
    ),
  ];
}