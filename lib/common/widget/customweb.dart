import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class CustomWebView extends StatelessWidget {
  final String? url;
  const CustomWebView({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: url,
      ),
    );
  }
}