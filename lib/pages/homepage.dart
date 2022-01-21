import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebView'), centerTitle: true, elevation: 0),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://amazon.in',
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        onPageStarted: (url) {
          print('Url $url');
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.import_export, size: 32),
            onPressed: () async {
              controller.evaluateJavascript(
                  "document.getElementsByTagName('header')[0].style.display='none'");
              controller.evaluateJavascript(
                  "document.getElementsByTagName('footer')[0].style.display='none'");
              // final url = await controller.currentUrl();
              // print('Previous website: $url');
              // controller.loadUrl('https://youtube.com');
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.import_export, size: 32),
            onPressed: () async {
              // controller.evaluateJavascript(
              //     "document.getElementsByTagName('header')[0].style.display='none'");
              // controller.evaluateJavascript(
              //     "document.getElementsByTagName('footer')[0].style.display='none'");
              // final url = await controller.currentUrl();
              // print('Previous website: $url');
              controller.loadUrl('https://youtube.com');
            },
          ),
        ],
      ),
    );
  }
}
