// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewPage extends StatefulWidget {
//   String id;
//    WebViewPage({super.key,required this.id});
//
//   @override
//   State<WebViewPage> createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   late WebViewController _controller;
//   @override
//   void initState() {
//     print("idddddd ${widget.id}");
//
//     try{
//       super.initState();
//       _controller = WebViewController()
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..setBackgroundColor(const Color(0x00000000))
//         ..setNavigationDelegate(
//           NavigationDelegate(
//             onProgress: (int progress) {
//               // Update loading bar.
//             },
//             onPageStarted: (String url) {},
//             onPageFinished: (String url) {},
//             onWebResourceError: (WebResourceError error) {},
//             onNavigationRequest: (NavigationRequest request) {
//               if (request.url.startsWith('https://www.youtube.com/')) {
//                 return NavigationDecision.prevent;
//               }
//               return NavigationDecision.navigate;
//             },
//           ),
//         )
//         ..loadRequest(Uri.parse('http://44.197.223.72/reactApp/'+'?${widget.id}'));
//     }
//     catch (e){
//
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WebViewWidget(controller: _controller);
//   }
//
// }
//
//
