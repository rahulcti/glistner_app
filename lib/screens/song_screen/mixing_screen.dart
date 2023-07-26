import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';
import '../../common/commonwidgets/button.dart';
import '../../common/formtextfield/mytextfield.dart';
import '../../common/styles/const.dart';
import '../../modal/Artist_Song_Model.dart';
import '../bottombar/bottombar.dart';
import 'package:rxdart/rxdart.dart';
import '../home/webview.dart';
import 'SeekBar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Mixing extends StatefulWidget {
  var id;
  var title;
  Mixing({Key? key,
    required this.id,
    required this.title,

  }) : super(key: key);

  @override
  State<Mixing> createState() => _MixingState();
}
class _MixingState extends State<Mixing> with WidgetsBindingObserver {
  // var song_Url="https://glistener.s3.amazonaws.com/";
  bool isToggled = false;
  bool boxshedow = false;
  bool rcordershow = true;
  bool seekhide = false;
  bool seekhide1 = false;
  bool seekhide2 = false;
  bool seekhide3 = false;
  bool editeon = true;


  //late final WebViewController controller;
  late WebViewXController webviewController;
  @override
  void initState() {
    super.initState();
    // print("idddddd ${widget.id}");
    // print("category ${widget.category}");
    // print("artist ${widget.artist}");
    // print('url' + 'http://44.197.223.72/reactApp/id=' + '?${widget.id}' +
    //     '&category=' + '${widget.category}' + '&artist=' + '${widget.artist}');



    // #docregion webview_controller
    // controller = WebViewController()
    //
    // ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..setBackgroundColor(const Color(0x00000000))
    // ..setNavigationDelegate(
    // NavigationDelegate(
    // onProgress: (int progress) {
    // controller.enableZoom(false);
    // print('???????????????????????????????????');
    // // Update loading bar.
    // },
    // onPageStarted: (String url) {
    // controller.enableZoom(false);
    // },
    // onPageFinished: (String url) {
    // controller.clearCache();
    //
    // },
    // onWebResourceError: (WebResourceError error) {},
    //
    // ),
    // )
    //
    // ..loadRequest(Uri.parse('http://44.197.223.72/reactApp/?id='+'${widget.id}'+'&category='+'${widget.category}'+'&artist='+'${widget.artist}'));
    // // #enddocregion webview_controller
    // }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    webviewController.clearCache();
    super.dispose();

  }

  Widget _buildWebViewX() {
    //_setUrl();

    return WebViewX(

      key: const ValueKey('webviewx'),
      //initialContent: 'http://44.197.223.72/reactApp/?id=${widget.id}&category=${widget.category}&artist=${widget.artist}',
      initialContent: 'http://44.197.223.72/reactApp/?${widget.id}',
      initialSourceType: SourceType.url,
      height: MediaQuery.of(context).size.height ,
      //screenSize.height / 2,
      width: double.infinity,


      ignoreAllGestures: false,

      onWebViewCreated: (controller) => webviewController = controller,

      // onPageStarted: (src) =>
      // _setUrl(),
      // // debugPrint('A new page has started loading: $src\n'),
      // onPageFinished: (src) =>
      // _setUrl(),
      // debugPrint('The page has finished loading: $src\n'),
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs:
          "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs:
          "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },
      dartCallBacks: {
        // DartCallback(
        //   name: 'TestDartCallback',
        //   // callBack: (msg) => showSnackBar(msg.toString(), context),
        // )
      },
      webSpecificParams: const WebSpecificParams(
          webAllowFullscreenContent: false
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
        gestureNavigationEnabled: false,


      ),
      // navigationDelegate: (navigation) {
      // debugPrint(navigation.content.sourceType.toString());
      // return NavigationDecision.navigate;
      // },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset : false,


      // appBar: appbarseting(context, 'Mixing'),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorscreenbackground,
        leading: IconButton(
            icon: SvgPicture.asset('assets/icons/Back-Navs.svg',width: 25,height:25,),
            onPressed: () {
              Navigator.pop(context);

            }),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.title.toString(),
              style: TextStyle(color: colorWhite ,fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,fontSize: 20,),
            ),
            // Text(
            //   widget.songslist_data[widget.indexnumber].label.toString(),
            //   style: TextStyle(color: colorhintcolor ,fontFamily: 'Mulish',
            //     fontWeight: FontWeight.w400,fontSize:14,),
            // ),
          ],
        ),

        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(5.0),
            child: Container(
              color: HexColor("#D9D9D9"),
              padding: const EdgeInsets.all(0.4),
            )),
        actions: [
          IconButton(
              onPressed: (){},
              icon: SvgPicture.asset('assets/icons/more-vertical 5.svg')
          )
        ],
      ),

      body: SingleChildScrollView(physics: const NeverScrollableScrollPhysics(),


          child: _buildWebViewX()),


      // body : SingleChildScrollView(
      //
      //   child: Column(
      //     children: <Widget>[
      //       _buildWebViewX(),
      //       // Expanded(
      //       // child: SizedBox(
      //       // width: MediaQuery.of(context).size.width*.78,
      //       // // width: min(screenSize.width * 1.0, 712),
      //       // // child: ListView(
      //       // // children: _buildButtons(),
      //       // // ),
      //       // ),
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }

}