import 'package:flutter/material.dart';
import 'package:social_media_video_downloader/views/utils/ImgUtils.dart';

class SocialMediaGrid extends StatelessWidget {
  final List<Map<String, String>> socialMediaList;

  const SocialMediaGrid({
    Key? key,
    required this.socialMediaList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: socialMediaList.length,
        itemBuilder: (context, index) {
          final item = socialMediaList[index];
          return Column(
            children: [
              Container(
                height: h * 0.12,
                width: h * 0.12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(item['iconPath']!),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Text(
                item['name']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: h * 0.024,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}