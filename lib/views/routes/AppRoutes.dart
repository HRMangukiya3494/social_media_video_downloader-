import 'package:get/get.dart';
import 'package:social_media_video_downloader/views/screens/BottomNavigationPage.dart';
import 'package:social_media_video_downloader/views/screens/HomePage.dart';
import 'package:social_media_video_downloader/views/screens/LinkPage.dart';

class AppRoutes {
  static const String BOTTOMNAVIIGATION = "/";
  static const String HOME = "/home_page";
  static const String LINK = "/link_page";

  static final routes = [
    GetPage(
      name: BOTTOMNAVIIGATION,
      page: () => BottomNavigationPage(),
    ),
    GetPage(
      name: HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: LINK,
      page: () => LinkPage(),
    ),
  ];
}