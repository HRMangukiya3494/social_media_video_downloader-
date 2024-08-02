import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LinkController extends GetxController {
  var videoTitle = ''.obs;
  var videoThumbnail = ''.obs;
  var videoUrl = ''.obs;
  var videoQualities = <Map<String, dynamic>>[].obs;
  var selectedQuality = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final TextEditingController urlController = TextEditingController();

  @override
  void onClose() {
    urlController.dispose(); // Clean up the controller
    super.onClose();
  }

  Future<void> fetchVideoDetails() async {
    final url = urlController.text;
    if (url.isEmpty) {
      errorMessage.value = 'Please enter a URL';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final request = http.MultipartRequest('POST', Uri.parse('https://customize.brainartit.com/social-media/video_download_old.php'));
    request.fields['url'] = url;

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final data = jsonDecode(responseString);

        if (data['status'] == 200) {
          videoTitle.value = data['title'] ?? '';
          videoThumbnail.value = data['thumbnail'] ?? '';
          videoUrl.value = data['url'] ?? '';

          // Parse video qualities
          videoQualities.value = List<Map<String, dynamic>>.from(data['data'] ?? []);
        } else {
          errorMessage.value = 'No Video Found';
        }
      } else {
        errorMessage.value = 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> downloadVideo(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getExternalStorageDirectory();
        final filePath = '${directory!.path}/downloaded_video.mp4';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        Get.snackbar('Download', 'Video downloaded successfully at $filePath');
      } else {
        Get.snackbar('Download Error', 'Failed to download video');
      }
    } catch (e) {
      Get.snackbar('Download Error', 'An error occurred: ${e.toString()}');
    }
  }
}