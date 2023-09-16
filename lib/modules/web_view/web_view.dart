import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  
  late final WebViewController controller;
  
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Al Molakhas"),
          leading: IconButton(
            onPressed: ()
            {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
          ),
        ),
        body: WebViewWidget(
          controller: controller,
        )
    );
  }
}
