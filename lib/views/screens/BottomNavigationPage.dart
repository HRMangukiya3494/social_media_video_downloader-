import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:get/get.dart';
import 'package:social_media_video_downloader/controller/BottomNavigationController.dart';
import 'package:social_media_video_downloader/views/screens/HomePage.dart';
import 'package:social_media_video_downloader/views/screens/LinkPage.dart';

class BottomNavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller = Get.put(
      BottomNavigationController(),
    );

    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            HomePage(),
            LinkPage(),
            HomePage(),
            HomePage(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return MoltenBottomNavigationBar(
          selectedIndex: controller.selectedIndex.value,
          domeCircleColor: Colors.black,
          onTabChange: (clickedIndex) {
            controller.changeIndex(clickedIndex);
          },
          tabs: [
            MoltenTab(
              icon: Icon(Icons.home),
            ),
            MoltenTab(
              icon: Icon(Icons.link),
            ),
            MoltenTab(
              icon: Icon(Icons.download),
            ),
            MoltenTab(
              icon: Icon(Icons.download_done),
            ),
          ],
        );
      }),
    );
  }
}