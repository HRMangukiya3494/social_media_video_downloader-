import 'package:flutter/material.dart';
import 'package:social_media_video_downloader/views/utils/AppUtils.dart';
import 'package:social_media_video_downloader/views/utils/ImgUtils.dart';
import 'package:social_media_video_downloader/views/utils/ListUtils.dart';
import 'package:social_media_video_downloader/views/widgets/AppBarWidget.dart';
import 'package:social_media_video_downloader/views/widgets/SocialMediaGrid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;



    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageUtils.ImagePath + ImageUtils.AppBG,
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              h * 0.02,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.05,
                ),
                AppBarWidget(
                  iconPath: ImageUtils.ImagePath + ImageUtils.MenuIcon,
                  onTap: () {},
                  title: AppUtils.AppName,
                ),
                SizedBox(
                  height: h * 0.18,
                ),
                Expanded(
                  child: SocialMediaGrid(
                    socialMediaList: socialMediaList,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
