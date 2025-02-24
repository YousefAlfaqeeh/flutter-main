import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PDF extends StatelessWidget {
  late String url,name ;
  PDF({required this.url,required this.name });
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _downloadPDF() async {
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: await _localPath,
      fileName: name,
      showNotification: true,
      openFileFromNotification: true,
    );
    // print("Download task id: $taskId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {

              await launch(url.toString());






          }, icon: Icon(Icons.download)),
          IconButton(onPressed: () async {
            Share.share(url);
            // await launch(url.toString());






          }, icon: Icon(Icons.share))

        ],

      ),
      body: SfPdfViewer.network(
        url,

      ),
    );
  }
}
