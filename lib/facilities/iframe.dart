import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Frame extends StatefulWidget {
  const Frame({super.key});

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    const iframeUrl =
        'https://ee-aryan21csu017.projects.earthengine.app/view/smapsoilmoisture';
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 44, 41),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: const Color.fromARGB(255, 36, 69, 66),
        title: const Text(
          'Satellite Data',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest:
            URLRequest(url: WebUri(Uri.parse(iframeUrl).toString())),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
        ),
      ),
    );
  }
}
