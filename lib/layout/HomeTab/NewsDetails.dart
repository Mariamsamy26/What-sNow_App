import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../color_manager.dart';

class NewsDetails extends StatelessWidget {
  String url;
  WebViewController controller = WebViewController();

  NewsDetails({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "News Details",
            style: GoogleFonts.sevillana(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: ColorManager.primaryColor,
            ),
          ),
          backgroundColor: ColorManager.colorOffwhite,
          centerTitle: true,
        ),
        body: WebViewWidget(
            controller: controller..loadRequest(Uri.parse(url))
        )
        // WebView(
        //   initialUrl: 'https://example.com',
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),
        );
  }
}
