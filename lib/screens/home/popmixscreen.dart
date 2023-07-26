import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../TestScreen.dart';
import '../../common/appbar/appbarpage.dart';
import '../../common/appbar/appbarwidgetpage.dart';
import '../../common/styles/const.dart';
import '../../modal/Artist_Song_Model.dart';
import '../bottombar/bottombar.dart';
import '../song_screen/mixing_screen.dart';
import 'package:http/http.dart'as http;

import 'home.dart';


class PopMixScreen extends StatefulWidget {
  final String? type;
   var artist_id;
   var genre_id;
   var album_id;
   var artist_modd_id;
   var name;
   PopMixScreen({Key? key, this.type,this.artist_id,this.genre_id,this.album_id,this.artist_modd_id,this.name}) : super(key: key);

  @override
  State<PopMixScreen> createState() => _PopMixScreenState(artist_id:artist_id,type:type,genre_id:genre_id,
      album_id:album_id,artist_modd_id:artist_modd_id,name:name);
}

class _PopMixScreenState extends State<PopMixScreen> {
  bool playposh = true;
  var artist_id;
  var genre_id;
  var album_id;
  var artist_modd_id;
  var type;
  var name;
  _PopMixScreenState(
      { Key? key,
        this.artist_id,
        this.type,
        this.genre_id,
        this.album_id,
        this.artist_modd_id,
        this.name,
      });

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  String?   image_file,user_id = "";
  var status,message,tokanget,data,song_name;
  List<Data> songslist_data=[];
  Future? _future;
  int? selectedIndex;
  final player  = AudioPlayer();
  var song;
  var song_Url="https://glistener.s3.amazonaws.com/";

  @override
  void initState() {
    fechData();
   // setState(() {
   //   super.initState();
   //   if(type=='1'){
   //
   //     _future=get_genre_song_api();
   //     print("type");
   //     print(type);
   //     print("type");
   //     print("genre_id");
   //     print(genre_id.toString());
   //     print("genre_id");
   //
   //   }else if(type=='2'){
   //     _future=get_artist_song_api();
   //     print("type");
   //     print(type);
   //     print("type");
   //     print("artist_id");
   //     print(artist_id.toString());
   //     print("artist_id");
   //
   //   }else if(type=='3'){
   //     _future=get_album_song_api();
   //     print("type");
   //     print(type);
   //     print("type");
   //     print("album_id");
   //     print(album_id.toString());
   //     print("album_id");
   //   }else if(type=='4'){
   //     _future=get_mood_song_api();
   //     print("type");
   //     print(type);
   //     print("type");
   //     print("artist_modd_id");
   //     print(artist_modd_id.toString());
   //     print("artist_modd_id");
   //   }
   // });

  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    setState(() {

    });
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content:  Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  //
  // Future<Artist_Song_Model> get_genre_song_api() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   tokanget=prefs.getString('login_user_token');
  //
  //   var response = await http.post(Uri.parse(BASE_URL+getSongsOfGenreapi),headers: {'Authorization': 'Bearer $tokanget',}, body: toMap1());
  //   showLoaderDialog(context);
  //
  //   data=response.body;
  //   print('????????????????????');
  //   print(json.decode(response.body));
  //   print('???????????????????');
  //
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).status);
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).success);
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).message);
  //
  //   status = (Artist_Song_Model.fromJson(json.decode(response.body)).status);
  //   message = (Artist_Song_Model.fromJson(json.decode(response.body)).message);
  //
  //   setState((){
  //
  //     songslist_data = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
  //     print("POPMIXSCREEN");
  //     print(songslist_data);
  //     print("POPMIXSCREEN");
  //
  //   });
  //   Navigator.pop(context);
  //
  //   if(status==200){
  //
  //     // Fluttertoast.showToast(
  //     //     msg: message,
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.BOTTOM,
  //     //     backgroundColor:Colors.black,
  //     //     textColor: Colors.white,
  //     //     fontSize: 16.0);
  //
  //   }else{
  //     Navigator.pop(context);
  //
  //     Fluttertoast.showToast(
  //         msg: message,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor:Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  //   return Artist_Song_Model.fromJson(json.decode(response.body));
  // }
  //
  // Future<Artist_Song_Model> get_album_song_api() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   tokanget=prefs.getString('login_user_token');
  //
  //   var response = await http.post(Uri.parse(BASE_URL+getSongsOfAlbumapi),headers: {'Authorization': 'Bearer $tokanget',}, body: toMap2());
  //   showLoaderDialog(context);
  //
  //   data=response.body;
  //   print('????????????????????');
  //   print(json.decode(response.body));
  //   print('???????????????????');
  //
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).status);
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).success);
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).message);
  //
  //   status = (Artist_Song_Model.fromJson(json.decode(response.body)).status);
  //   message = (Artist_Song_Model.fromJson(json.decode(response.body)).message);
  //
  //   setState((){
  //     songslist_data = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
  //
  //   });
  //   Navigator.pop(context);
  //
  //   if(status==200){
  //
  //     // Fluttertoast.showToast(
  //     //     msg: message,
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.BOTTOM,
  //     //     backgroundColor:Colors.black,
  //     //     textColor: Colors.white,
  //     //     fontSize: 16.0);
  //
  //   }else{
  //     Navigator.pop(context);
  //
  //     Fluttertoast.showToast(
  //         msg: message,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor:Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  //   return Artist_Song_Model.fromJson(json.decode(response.body));
  // }
  //
  // Future<Artist_Song_Model> get_artist_song_api() async {
  //
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   tokanget=prefs.getString('login_user_token');
  //
  //   var response = await http.post(Uri.parse(BASE_URL+getSongsOfArtistapi),headers: {'Authorization': 'Bearer $tokanget',}, body: toMap());
  //   showLoaderDialog(context);
  //
  //   data=response.body;
  //   print('????????????????????');
  //   print(json.decode(response.body));
  //   print('???????????????????');
  //
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).status);
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).success);
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).message);
  //
  //   status = (Artist_Song_Model.fromJson(json.decode(response.body)).status);
  //   message = (Artist_Song_Model.fromJson(json.decode(response.body)).message);
  //
  //   setState((){
  //     songslist_data = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
  //   });
  //   Navigator.pop(context);
  //
  //   if(status==200){
  //     //
  //     // Fluttertoast.showToast(
  //     //     msg: message,
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.BOTTOM,
  //     //     backgroundColor:Colors.black,
  //     //     textColor: Colors.white,
  //     //     fontSize: 16.0);
  //
  //   }else{
  //     Navigator.pop(context);
  //
  //     Fluttertoast.showToast(
  //         msg: message,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor:Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  //   return Artist_Song_Model.fromJson(json.decode(response.body));
  // }
  //
  // Future<Artist_Song_Model> get_mood_song_api() async {
  //
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   tokanget=prefs.getString('login_user_token');
  //
  //   var response = await http.post(Uri.parse(BASE_URL+getSongsOfMoodapi),headers: {'Authorization': 'Bearer $tokanget',}, body: toMap3());
  //   showLoaderDialog(context);
  //
  //   data=response.body;
  //
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).status);
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).success);
  //   print(Artist_Song_Model.fromJson(json.decode(response.body)).message);
  //
  //   status = (Artist_Song_Model.fromJson(json.decode(response.body)).status);
  //   message = (Artist_Song_Model.fromJson(json.decode(response.body)).message);
  //
  //   setState((){
  //     songslist_data = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
  //
  //   });
  //   Navigator.pop(context);
  //
  //   if(status==200){
  //
  //     // Fluttertoast.showToast(
  //     //     msg: message,
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.BOTTOM,
  //     //     backgroundColor:Colors.black,
  //     //     textColor: Colors.white,
  //     //     fontSize: 16.0);
  //
  //   }else{
  //     Navigator.pop(context);
  //
  //     Fluttertoast.showToast(
  //         msg: message,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor:Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  //   return Artist_Song_Model.fromJson(json.decode(response.body));
  // }


  Map toMap() {
    var map = new Map<String, dynamic>();


    map["id"] = artist_id.toString();

    return map;
  }
  Map toMap1() {
    var map =  Map<String, dynamic>();


    map["genre_id"] = genre_id.toString();

    return map;
  }

  Map toMap2() {
    var map =  Map<String, dynamic>();


    map["album_id"] = album_id.toString();

    return map;
  }

  Map toMap3() {
    var map =  Map<String, dynamic>();


    map["your_mood_id"] = artist_modd_id.toString();

    return map;
  }
  var index1 = null;

// Future<void> downlod(imgurl,banner) async {
//   print('aman');
//   Map<Permission, PermissionStatus> statuses = await [
//   Permission.storage,
//   //add more permission to request here.
//   ].request();
//   if(statuses[Permission.storage]!.isGranted){
//     print('aman1');
//     var dir = await DownloadsPathProvider.downloadsDirectory;
//     if(dir != null){
//       print('aman2');
//       String savename = "$banner.mp3";
//       String savePath = dir.path + "/$savename";
//       print(savePath);
//       print('aman3');
//
//       //output:  /storage/emulated/0/Download/banner.png
//
//       try {
//         await Dio().download(
//             imgurl,
//             savePath,
//             onReceiveProgress: (received, total) {
//               if (total != -1) {
//                 print((received / total * 100).toStringAsFixed(0) + "%");
//                 //you can build progressbar feature too
//               }
//             });
//         print("Image is saved to download folder.");
//       } on DioError catch (e) {
//         print(e.message);
//       }
//     }
//   }else{
//     print("No permission to read and write.");
//   }
//
// }



  Future<Artist_Song_Model> fechData() async {
    print("tesgtdfshggfhhdf");

    Artist_Song_Model bm;
    String url = "http://44.197.223.72:4000/getAllSongs/";
    http.Response response = await http.get(Uri.parse(url),);


    Map<String, dynamic> jsonresponse = jsonDecode(response.body);
    songslist_data = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
    bm = Artist_Song_Model.fromJson(jsonresponse);
    print("tesgtdfshggasdfghfhhdf22222" + jsonresponse.toString());

    return bm;
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: colorappblack,
    //   appBar:  AppBar(
    //       elevation: 0,
    //       backgroundColor: colorappblack,
    //       leading: IconButton(
    //           icon: SvgPicture.asset('assets/icons/Back-Navs.svg',width: 25,height:25,),
    //           onPressed: () {
    //             player.stop();
    //             Get.back();
    //             Get.off(BottomBar());
    //           }),
    //       centerTitle: true,
    //       title: Text(name.toString(),
    //         // widget.type=='1'? 'Pop Mix': widget.type=='2'?  'Artist'  :widget.type=='3'?  'Album' :widget.type=='4'?'Mood':"",
    //
    //         style: textstyleHeading6(context)!.copyWith(color: colorWhite),
    //       ),
    //       bottom:  PreferredSize(
    //           preferredSize: const Size.fromHeight(1.0),
    //           child:  Container(
    //             color: HexColor("#D9D9D9"),
    //             padding: const EdgeInsets.all(0.4),
    //           ))
    //   ),
    //   // appbartitlebackbtn(context, widget.type=='1'? 'Pop Mix': widget.type=='2'?  'Artist'  :widget.type=='3'?  'Album' :widget.type=='4'?'Mood':""
    //
    //
    //   body: FutureBuilder(
    //     future: _future,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return songslist_data.isEmpty
    //             ?  const Center(child: Text('No Data Found Here',style: TextStyle(
    //           color: Colors.white
    //         ),))
    //             :    Container(
    //           padding: EdgeInsets.all(10),
    //           width: deviceWidth(context),
    //           height: deviceheight(context),
    //           child: SingleChildScrollView(
    //             physics: ScrollPhysics(),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 widget.type=='1'?  Align(
    //                   alignment: Alignment.centerLeft,
    //                   child: Text('Let’s try some pop mix',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
    //                       fontWeight: FontWeight.w700,fontSize: 20,height: 2)),
    //                 ):Container(),
    //                 widget.type=='1'?   Align(
    //                   alignment: Alignment.centerLeft,
    //                   child: Text('${songslist_data.length} songs',style: TextStyle(color: colorhintcolor  ,fontFamily: 'Mulish',
    //                       fontWeight: FontWeight.w400,fontSize: 14,height: 2)),
    //                 ):Container(),
    //
    //                 widget.type=='2'?   Container(
    //                   width: 80,
    //                   height: 80,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(50),
    //                       image: const DecorationImage(
    //                           image: AssetImage('assets/icons/image.png')
    //                       )
    //                   ),
    //                 ):Container(),
    //                 widget.type=='2'?  Text('${songslist_data[0].artistName}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
    //                     fontWeight: FontWeight.w700,fontSize: 18,height: 2)):Container(),
    //                 widget.type=='2'?   Text('${songslist_data.length} songs',style: TextStyle(color: colorhintcolor  ,fontFamily: 'Mulish',
    //                     fontWeight: FontWeight.w400,fontSize: 12,height: 2)):Container(),
    //                 sizedboxheight(10.0),
    //                 Container(
    //
    //                   child: ListView.builder(
    //                       physics: NeverScrollableScrollPhysics(),
    //                       shrinkWrap: true,
    //                       itemCount: songslist_data.length,
    //                       itemBuilder: (BuildContext context, int index){
    //                         return InkWell(
    //                           // onTap: (){
    //                           //   Get.to(() => Mixing(
    //                           //       indexnumber: index,
    //                           //       songslist_data:songslist_data,
    //                           //       DRUMSsongs:songslist_data[index].drums.toString(),
    //                           //       BASSSsongs:songslist_data[index].bass.toString(),
    //                           //       GUITARSsongs:songslist_data[index].guitar.toString(),
    //                           //       VOCALSSsongs:songslist_data[index].vocals.toString(),
    //                           //   ));
    //                           // },
    //                           child: Card(
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(10.0),
    //                             ),
    //                             color: colorlightblack,
    //                             child: Container(
    //                               padding: EdgeInsets.all(5),
    //                               child: Row(
    //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Container(
    //                                     width: deviceWidth(context,0.15),
    //                                     height: 55,
    //                                     decoration: BoxDecoration(
    //                                         borderRadius: BorderRadius.circular(20),
    //                                         image:  DecorationImage(
    //                                             fit: BoxFit.fill,
    //                                             // image: AssetImage('assets/icons/image.png')
    //                                             image: NetworkImage('https://glistener.s3.amazonaws.com/${songslist_data[index].coverImage}')
    //                                         )
    //                                     ),
    //                                   ),
    //
    //                                   Container(
    //                                     width: deviceWidth(context,0.5),
    //                                     child: Column(
    //                                       crossAxisAlignment: CrossAxisAlignment.start,
    //                                       children: [
    //                                         Text('${songslist_data[index].label}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
    //                                             fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
    //                                         Text('${songslist_data[index].albumType}',style: TextStyle(color: HexColor("#909090")  ,fontFamily: 'Poppins',
    //                                             fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
    //                                         Text('2:45 minutes',style: TextStyle(color: HexColor("#DEDBDB")  ,fontFamily: 'Poppins',
    //                                             fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     width: deviceWidth(context,0.2),
    //                                     child: Row(
    //                                       crossAxisAlignment: CrossAxisAlignment.center,
    //                                       mainAxisAlignment: MainAxisAlignment.center,
    //                                       children: [
    //                                         songslist_data[index].songplay == true ?
    //                                         InkWell(
    //                                             onTap: (){
    //                                               setState(()  {
    //                                                 playposh = false;
    //                                                 if(index1 != null){
    //                                                   setState((){
    //                                                     songslist_data[index1].songplay = true;
    //                                                     index1 = index;
    //                                                   });
    //
    //                                                 }else{
    //                                                   setState((){
    //                                                     index1 = index;
    //                                                   });
    //                                                 }
    //                                                 setState((){
    //                                                   index1 = index;
    //                                                   songslist_data[index].songplay = false;
    //                                                 });
    //
    //                                                 print(index);
    //                                                 selectedIndex=index;
    //                                                 player.setUrl(song_Url+songslist_data[index].master1.toString()).then((play){
    //                                                   player.play(song_Url+songslist_data[index].master1.toString());
    //                                                 });
    //
    //                                               });
    //                                             },
    //                                             child: SvgPicture.asset('assets/icons/push.svg',height: 30,)):
    //                                         InkWell(
    //                                             onTap: (){
    //                                               setState(()  {
    //                                                 playposh = true;
    //                                                 songslist_data[index].songplay = true;
    //                                                 player.stop();
    //
    //                                               });
    //
    //                                             },
    //                                             child: SvgPicture.asset("assets/icons/play.svg",height: 30,)),
    //                                         sizedboxwidth(10.0),
    //                                         InkWell(
    //                                             onTap: () async {
    //                                              setState(() {
    //                                                playposh = true;
    //                                                songslist_data[index].songplay = true;
    //                                                player.stop();
    //                                                player.setUrl(song_Url+songslist_data[index].master1.toString()).then((play){
    //                                                  player.stop();
    //                                                });
    //
    //                                              });
    //                                              print(songslist_data[index].id.toString());
    //                                              print(song_Url+songslist_data[index].drums.toString());
    //                                              print(song_Url+songslist_data[index].bass.toString());
    //                                              print(song_Url+songslist_data[index].guitar.toString());
    //                                              print(song_Url+songslist_data[index].vocals.toString());
    //
    //
    //                                               Get.to(() => Mixing(
    //                                                 indexnumber: index,
    //                                                 songslist_data:songslist_data,
    //                                                 DRUMSsongs:songslist_data[index].drums.toString(),
    //                                                 BASSSsongs:songslist_data[index].bass.toString(),
    //                                                 GUITARSsongs:songslist_data[index].guitar.toString(),
    //                                                 VOCALSSsongs:songslist_data[index].vocals.toString(),
    //                                                 id : songslist_data[index].id.toString(),
    //                                                 category: null,
    //                                                 artist: null,
    //                                               ));
    //                                             },
    //                                             child: Image.asset('assets/new/btn.png',height: 30,)),
    //                                       ],
    //                                     ),
    //                                   ),
    //
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         );
    //                       }),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //
    //
    //       } else {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //     // future: postlist(),
    //   )
    //
    //
    //
    //
    //
    // );

    return Scaffold(
      backgroundColor: Colors.black,
        appBar:  AppBar(
            elevation: 0,
            backgroundColor: colorappblack,
            leading: IconButton(
                icon: SvgPicture.asset('assets/icons/Back-Navs.svg',width: 25,height:25,),
                onPressed: () {
                  player.stop();
                  Get.back();
                  Get.off(BottomBar());
                }),
            centerTitle: true,
            title: Text("All Songs".toString(),
              // widget.type=='1'? 'Pop Mix': widget.type=='2'?  'Artist'  :widget.type=='3'?  'Album' :widget.type=='4'?'Mood':"",

              style: textstyleHeading6(context)!.copyWith(color: colorWhite),
            ),
            bottom:  PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child:  Container(
                  color: HexColor("#D9D9D9"),
                  padding: const EdgeInsets.all(0.4),
                ))
        ),
      // body:  FutureBuilder(
      //   future: fechData(),
      //   builder: (BuildContext context, AsyncSnapshot<Artist_Song_Model> snapshot) {
      //     if(snapshot.hasData==false){
      //
      //       return Container(width: 100,height: 100,color: Colors.red,);
      //     }else{
      //       return  ListView.builder(
      //           physics: NeverScrollableScrollPhysics(),
      //           shrinkWrap: true,
      //           itemCount: snapshot.data!.data!.length,
      //           itemBuilder: (BuildContext context, int index){
      //             return InkWell(
      //               child: Card(
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(10.0),
      //                 ),
      //                 color: colorlightblack,
      //                 child: Container(
      //                   padding: EdgeInsets.all(5),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Container(
      //                         width: deviceWidth(context,0.15),
      //                         height: 55,
      //                         decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(20),
      //                             image:  DecorationImage(
      //                                 fit: BoxFit.fill,
      //                                 // image: AssetImage('assets/icons/image.png')
      //                                 image: NetworkImage('https://glistener.s3.amazonaws.com/${snapshot.data!.data?[index].coverImage}')
      //                             )
      //                         ),
      //                       ),
      //
      //                       Container(
      //                         width: deviceWidth(context,0.5),
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Text('${"${snapshot.data!.data?[index].label}"}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
      //                                 fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
      //                             // Text('${"snapshot.data!.data[0].a"}',style: TextStyle(color: HexColor("#909090")  ,fontFamily: 'Poppins',
      //                             //     fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
      //                             Text('2:45 minutes',style: TextStyle(color: HexColor("#DEDBDB")  ,fontFamily: 'Poppins',
      //                                 fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
      //                           ],
      //                         ),
      //                       ),
      //                       Container(
      //                         width: deviceWidth(context,0.2),
      //                         child: Row(
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: [
      //                             songslist_data[index].songplay == true ?
      //                             InkWell(
      //                                 onTap: (){
      //                                   setState(()  {
      //                                     playposh = false;
      //                                     if(index1 != null){
      //                                       setState((){
      //                                         songslist_data[index1].songplay = true;
      //                                         index1 = index;
      //                                       });
      //
      //                                     }else{
      //                                       setState((){
      //                                         index1 = index;
      //                                       });
      //                                     }
      //                                     setState((){
      //                                       index1 = index;
      //                                       songslist_data[index].songplay = false;
      //                                     });
      //
      //                                     print(index);
      //                                     selectedIndex=index;
      //                                     player.setUrl(song_Url+songslist_data[index].master1.toString()).then((play){
      //                                       player.play(song_Url+songslist_data[index].master1.toString());
      //                                     });
      //
      //                                   });
      //                                 },
      //                                 child: SvgPicture.asset('assets/icons/push.svg',height: 30,)):
      //                             InkWell(
      //                                 onTap: (){
      //                                   setState(()  {
      //                                     playposh = true;
      //                                     songslist_data[index].songplay = true;
      //                                     player.stop();
      //
      //                                   });
      //
      //
      //                                 },
      //                                 child: SvgPicture.asset("assets/icons/play.svg",height: 30,)),
      //                             sizedboxwidth(10.0),
      //                             InkWell(
      //                                 onTap: () async {
      //                                   setState(() {
      //                                     playposh = true;
      //                                     songslist_data[index].songplay = true;
      //                                     player.stop();
      //                                     player.setUrl(song_Url+songslist_data[index].master1.toString()).then((play){
      //                                       player.stop();
      //                                     });
      //
      //
      //                                   });
      //                                   print(songslist_data[index].id.toString());
      //                                   print(song_Url+songslist_data[index].drums.toString());
      //                                   print(song_Url+songslist_data[index].bass.toString());
      //                                   print(song_Url+songslist_data[index].guitar.toString());
      //                                   print(song_Url+songslist_data[index].vocals.toString());
      //
      //
      //                                   // Get.to(() => Mixing(
      //                                   //   indexnumber: index,
      //                                   //   songslist_data:songslist_data,
      //                                   //   DRUMSsongs:songslist_data[index].drums.toString(),
      //                                   //   BASSSsongs:songslist_data[index].bass.toString(),
      //                                   //   GUITARSsongs:songslist_data[index].guitar.toString(),
      //                                   //   VOCALSSsongs:songslist_data[index].vocals.toString(),
      //                                   //   id : songslist_data[index].id.toString(),
      //                                   //   category: null,
      //                                   //   artist: null, title: "pramid",
      //                                   // ));
      //                                 },
      //                                 child: Image.asset('assets/new/btn.png',height: 30,)),
      //                           ],
      //                         ),
      //                       ),
      //
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             );
      //           });
      //     }
      //
      //
      //   },
      //
      // )

        body: HomePage(),


    );
  }

}


