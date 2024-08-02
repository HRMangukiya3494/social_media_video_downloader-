import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For Uint8List

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_video_downloader/controller/LinkController.dart';
import 'package:social_media_video_downloader/views/utils/ImgUtils.dart';
import '../widgets/AppBarWidget.dart';

class LinkPage extends StatelessWidget {
  const LinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LinkController linkController = Get.put(LinkController());
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageUtils.ImagePath + ImageUtils.AppBG,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(h * 0.02),
            child: Obx(() {
              return Column(
                children: [
                  SizedBox(height: h * 0.05),
                  AppBarWidget(
                    iconPath: ImageUtils.ImagePath + ImageUtils.MenuIcon,
                    onTap: () {},
                    title: "URL",
                  ),
                  SizedBox(height: h * 0.14),
                  Container(
                    height: h * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(h * 0.02),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: linkController.urlController,
                      decoration: InputDecoration(
                        hintText: 'Enter URL here',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: h * 0.02,
                          vertical: h * 0.02,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: Colors.black),
                          onPressed: () => linkController.fetchVideoDetails(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Show loading indicator if isLoading is true
                          if (linkController.isLoading.value)
                            Center(child: CircularProgressIndicator()),

                          // Show error message if any
                          if (linkController.errorMessage.value.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.02),
                              child: Text(
                                linkController.errorMessage.value,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),

                          // Show video details if available
                          if (linkController.videoTitle.value.isNotEmpty)
                            Column(
                              children: [
                                SizedBox(height: h * 0.02),
                                Text(
                                  linkController.videoTitle.value,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: h * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: h * 0.06,
                                      width: w * 0.4,
                                      padding: EdgeInsets.symmetric(horizontal: h * 0.01),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(h * 0.02),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        value: linkController.videoQualities
                                            .map((quality) => quality['url'])
                                            .contains(linkController.selectedQuality.value)
                                            ? linkController.selectedQuality.value.isEmpty
                                            ? null
                                            : linkController.selectedQuality.value
                                            : null,
                                        hint: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: h * 0.02),
                                          child: Text(
                                            'Select Quality',
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                        ),
                                        items: linkController.videoQualities.map((quality) {
                                          return DropdownMenuItem<String>(
                                            value: quality['url'],
                                            child: Text(
                                              '${quality['formattedSize']}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          linkController.selectedQuality.value = value ?? '';
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: h * 0.06,
                                      width: w * 0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(h * 0.02),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Download',
                                          style: TextStyle(fontSize: 16, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: h * 0.02),
                                // Display the thumbnail
                                if (linkController.videoThumbnail.value.isNotEmpty)
                                  if (linkController.videoThumbnail.value.startsWith('data:image'))
                                    Image.memory(
                                      base64Decode(
                                        linkController.videoThumbnail.value.replaceAll(
                                          RegExp(r'^data:image\/[a-zA-Z]+;base64,'),
                                          '',
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  else
                                    Image.network(
                                      linkController.videoThumbnail.value,
                                      fit: BoxFit.cover,
                                    ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}