// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:glistener/screens/home/Album.dart';
// import 'package:glistener/screens/home/popmixscreen.dart';
// import 'package:glistener/screens/library/library.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../common/styles/const.dart';
// import '../../modal/Home_Model.dart';
// import 'package:http/http.dart'as http;
//
// import 'Artist.dart';
// import 'Genre.dart';
// import 'Mood.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final List<String> imgList = ['1','2','3','4' ];
//
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   StreamSubscription<ConnectivityResult>? _connectivitySubscription;
//
//   String?   image_file,user_id = "";
//   var status,message,tokanget,data,song_name,artist_genre_id,artist_artist_id,artist_album_id,artist_modd_id;
//
//
//
//    List<Genre> genredata=[];
//    List<Artist> artistdata=[];
//    List<Albums> albumsdata=[];
//    List<Yourmood> yourmooddata=[];
//
//   @override
//   void initState() {
//     super.initState();
//
//     setState(() {
//
//       homepageapi();
//     });
//   }
//   @override
//   void dispose() {
//     _connectivitySubscription?.cancel();
//     setState(() {
//
//     });
//     super.dispose();
//   }
//
//   Future<void> initConnectivity() async {
//     late ConnectivityResult result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       return;
//     }
//
//     if (!mounted) {
//       return Future.value(null);
//     }
//
//     return _updateConnectionStatus(result);
//   }
//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     setState(() {
//       _connectionStatus = result;
//     });
//   }
//
//
//   showLoaderDialog(BuildContext context) {
//     AlertDialog alert = AlertDialog(
//       content:  Row(
//         children: [
//           CircularProgressIndicator(),
//           Container(
//               margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
//         ],
//       ),
//     );
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
//
//   Future<Home_Model> homepageapi() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     user_id=prefs.getString('user_id');
//     tokanget=prefs.getString('login_user_token');
//
//     var response = await http.post(Uri.parse(BASE_URL+homePageapi),headers: {'Authorization': 'Bearer $tokanget',}, body: toMap());
//     showLoaderDialog(context);
//
//     data=response.body;
//
//     print(Home_Model.fromJson(json.decode(response.body)).status);
//     print(Home_Model.fromJson(json.decode(response.body)).success);
//     print(Home_Model.fromJson(json.decode(response.body)).message);
//
//     status = (Home_Model.fromJson(json.decode(response.body)).status);
//     message = (Home_Model.fromJson(json.decode(response.body)).message);
//
//     setState((){
//
//       genredata=Home_Model.fromJson(json.decode(response.body)).genre!;
//       artistdata=Home_Model.fromJson(json.decode(response.body)).artist!;
//       albumsdata=Home_Model.fromJson(json.decode(response.body)).albums!;
//       yourmooddata=Home_Model.fromJson(json.decode(response.body)).yourmood!;
//       // song_name = Home_Model.fromJson(json.decode(response.body)).genre[0].genreType;
//       // image = Home_Model.fromJson(json.decode(response.body)).genre[0].image;
//
//     });
//     Navigator.pop(context);
//
//
//     if(status==200){
//
//
//     }else{
//       Navigator.pop(context);
//
//       Fluttertoast.showToast(
//           msg: message,
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor:Colors.black,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     }
//     return Home_Model.fromJson(json.decode(response.body));
//   }
//   Map toMap() {
//     var map =  Map<String, dynamic>();
//
//     map["user_id"] = user_id.toString();
//
//     return map;
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorappblack,
//       body: Container(
//         padding: EdgeInsets.all(15),
//         child: SingleChildScrollView(
//           child: Column(
//
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Continue mixing',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w700,fontSize: 16,height: 2)),
//               sizedboxheight(10.0),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10)
//                 ),
//                 height: deviceheight(context,0.22),
//                 width: deviceWidth(context),
//                 child: CarouselSlider(
//                   options: CarouselOptions(
//                     autoPlay: true,
//                     aspectRatio: 2.0,
//                     enlargeCenterPage: true,
//                   ),
//                   items: imgList.map((item) => Container(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                       color: Colors.accents[Random().nextInt(Colors.accents.length)].withOpacity(0.8),
//                     ),
//                     padding: EdgeInsets.all(10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: deviceWidth(context,0.5),
//                               child: Text('Friends Forever- My Mix',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w700,fontSize: 14,height: 1.5),
//                               maxLines: 1,
//                               ),
//                             ),
//                           SvgPicture.asset('assets/icons/Vector.svg')
//                           ],
//                         ),
//                         Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'
//                             ,style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
//                             fontWeight: FontWeight.w400,fontSize: 10),
//                         maxLines: 3,),
//                        sizedboxheight(5.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: deviceWidth(context,0.5),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SvgPicture.asset('assets/icons/timer.svg'),
//                                   sizedboxwidth(8.0),
//                                   Text('1:35 minutes',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w700,fontSize: 14,height: 2),maxLines: 1,),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: deviceWidth(context,0.1),
//                               height: deviceheight(context,0.05),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: colorWhite,
//                               ),
//                               child: SvgPicture.asset('assets/icons/cearcl back.svg',
//                                 fit: BoxFit.none,
//                                 width: 40,height: 40,
//                                 color: Colors.accents[Random().nextInt(Colors.accents.length)].withOpacity(0.5),
//                              ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//         ),
//       ))
//         .toList(),
//                 ),
//               ),
//
//               sizedboxheight(10.0),
//               hedingrow('Genre'),
//               sizedboxheight(10.0),
//               genrelist(),
//               sizedboxheight(10.0),
//               hedingrow('Artists For You'),
//               sizedboxheight(10.0),
//               artisteforyoulist(),
//               sizedboxheight(10.0),
//               hedingrow('Top Albums'),
//               sizedboxheight(10.0),
//               topalbumslist(),
//               sizedboxheight(10.0),
//               hedingrow('Your Mood'),
//               sizedboxheight(10.0),
//               moddlist(),
//               sizedboxheight(100.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget hedingrow(titel){
//     return   Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(titel,style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//             fontWeight: FontWeight.w700,fontSize: 16,height: 2)),
//         InkWell(
//           onTap: () {
//
//             if(titel == "Genre"){
//               Get.to(() => GenreScreen(type: 1));
//
//             }else
//               if(titel == "Artists For You"){
//                 Get.to(() => ArtistScreen());
//
//
//             }else if (titel == "Top Albums"){
//                 Get.to(() => AlbumScreen());
//
//               }else if (titel == "Your Mood"){
//                 Get.to(() => MoodScreen());
//
//               }
//             print("objecttttttt");
//
//           },
//           child: Text('See All',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//               fontWeight: FontWeight.w500,fontSize: 16,height: 2)),
//         ),
//       ],
//     );
//   }
//   Widget genrelist(){
//     return  Container(
//       height: 130,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: genredata.length,
//           itemBuilder: (BuildContext context , int index){
//             return InkWell(
//               onTap: (){
//                 artist_genre_id=genredata[index].id.toString();
//
//                 print("artist_genre_id");
//                 print(artist_genre_id);
//                 print("artist_genre_id");
//
//                 Get.to(() => PopMixScreen(type:'1',genre_id:artist_genre_id,name:genredata[index].genreType));
//               },
//               child: Container(
//                 width: 120,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 100,width: 100,
//                         decoration: BoxDecoration(
//
//                           image:  DecorationImage(
//                             fit: BoxFit.fill,
//                               // image: AssetImage('assets/icons/image.png',)
//                               image: NetworkImage("${BASE_URL_img_home}genre/"+genredata[index].image! )
//                           ),
//                         ),
//                         child:Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                             height: 95,
//                               child: Padding(
//                                 padding:  EdgeInsets.only(left: 5,right: 5),
//                                 child: Center(
//                                   child: Text('${genredata[index].genreType}'
//                                     ,style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.w600,fontSize: 12,height: 1.5),
//                                     textAlign: TextAlign.center,
//                                     maxLines: 2,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 5,
//                               color: Colors.accents[Random().nextInt(Colors.accents.length)],
//                             )
//                           ],
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
//
//   Widget artisteforyoulist(){
//     return  Container(
//       height: 150,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: artistdata.length,
//           itemBuilder: (BuildContext context , int index){
//             return Column(
//               children: [
//                 InkWell(
//                   onTap: (){
//                     artist_artist_id=artistdata[index].id.toString();
//                     print("artist_artist_id");
//                     print(artist_artist_id);
//                     print("artist_artist_id");
//
//                     Get.to(() => PopMixScreen(type:'2',artist_id: artistdata[index].id.toString(),name:artistdata[index].artistName));
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(right: 10,bottom: 10),
//                     height: 100,width: 100,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       image:  DecorationImage(
//                           fit: BoxFit.fill,
//
//                           image: NetworkImage("${BASE_URL_img_home}artist/"+artistdata[index].image!)
//
//             ),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: (){
//                     artist_artist_id=artistdata[index].id.toString();
//                     print("artist_artist_id");
//                     print(artist_artist_id);
//                     print("artist_artist_id");
//
//                     Get.to(() => PopMixScreen(type:'2',artist_id: artistdata[index].id.toString(),name:artistdata[index].artistName));                  },
//                   child: Text('${artistdata[index].artistName}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w500,fontSize: 12)),
//                 ),
//               ],
//             );
//           }),
//     );
//   }
//
//   Widget topalbumslist(){
//     return  Container(
//       height: 130,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: albumsdata.length,
//           itemBuilder: (BuildContext context , int index){
//             return InkWell(
//               onTap: () {
//                 artist_album_id=albumsdata[index].id.toString();
//
//                 print("artist_album_id");
//                 print(artist_album_id);
//                 print("artist_album_id");
//
//                 Get.to(() => PopMixScreen(type:'3',album_id:artist_album_id,name:albumsdata[index].albumType));              },
//               child: Container(
//                 width: 120,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Stack(
//                     children: [
//                       Container(
//                         height: 100,width: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           image:  DecorationImage(
//                               fit: BoxFit.fill,
//
//                               // image: AssetImage('assets/icons/image.png',)
//                               image: NetworkImage('${BASE_URL_img_home}albums/${albumsdata[index].image!}')
//                           ),
//                         ),
//
//                       ),
//                       Container(
//                         height: 100,width: 100,
//                        color: colorblack.withOpacity(0.3),
//                         child:Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Center(
//                             child: Text('${albumsdata[index].albumType}'
//                               ,style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w600,fontSize: 12,height: 1.5),
//                               textAlign: TextAlign.center,
//                               maxLines: 2,
//                             ),
//                           ),
//                         ),
//                       )
//
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
//   Widget moddlist(){
//     return  Container(
//       height: 130,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: yourmooddata.length,
//           itemBuilder: (BuildContext context , int index){
//             return InkWell(
//               onTap: () {
//
//                 artist_modd_id=yourmooddata[index].id.toString();
//
//                 print("artist_modd_id");
//                 print(artist_modd_id);
//                 print("artist_modd_id");
//
//                 Get.to(() => PopMixScreen(type:'4',artist_modd_id:artist_modd_id,name:yourmooddata[index].moodType));
//
//
//               },
//               child: Container(
//                 width: 120,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Stack(
//                     children: [
//                       Container(
//                         height: 100,width: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           image:  DecorationImage(
//                               fit: BoxFit.fill,
//
//                               // image: AssetImage('assets/icons/image.png',)
//                               image: NetworkImage('${BASE_URL_img_home}mood/${yourmooddata[index].image!}')
//                           ),
//                         ),
//
//                       ),
//                       Container(
//                         height: 100,width: 100,
//                         color: colorblack.withOpacity(0.3),
//                         child:Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Center(
//                             child: Text('${yourmooddata[index].moodType}'
//                               ,style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w600,fontSize: 12,height: 1.5),
//                               textAlign: TextAlign.center,
//                               maxLines: 2,
//                             ),
//                           ),
//                         ),
//                       )
//
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
//
// }
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

//
// class PopMixScreen extends StatefulWidget {
//   final String? type;
//   var artist_id;
//   var genre_id;
//   var album_id;
//   var artist_modd_id;
//   var name;
//   PopMixScreen({Key? key, this.type,this.artist_id,this.genre_id,this.album_id,this.artist_modd_id,this.name}) : super(key: key);
//
//   @override
//   State<PopMixScreen> createState() => _PopMixScreenState(artist_id:artist_id,type:type,genre_id:genre_id,
//       album_id:album_id,artist_modd_id:artist_modd_id,name:name);
// }
//
// class _PopMixScreenState extends State<PopMixScreen> {
//   bool playposh = true;
//   var artist_id;
//   var genre_id;
//   var album_id;
//   var artist_modd_id;
//   var type;
//   var name;
//   _PopMixScreenState(
//       { Key? key,
//         this.artist_id,
//         this.type,
//         this.genre_id,
//         this.album_id,
//         this.artist_modd_id,
//         this.name,
//       });
//
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   StreamSubscription<ConnectivityResult>? _connectivitySubscription;
//
//   String?   image_file,user_id = "";
//   var status,message,tokanget,data,song_name;
//   List<Data> songslist_data=[];
//   Future? _future;
//   int? selectedIndex;
//   final player  = AudioPlayer();
//   var song;
//   var song_Url="https://glistener.s3.amazonaws.com/";
//
//   @override
//   void initState() {
//     fechData();
//     // setState(() {
//     //   super.initState();
//     //   if(type=='1'){
//     //
//     //     _future=get_genre_song_api();
//     //     print("type");
//     //     print(type);
//     //     print("type");
//     //     print("genre_id");
//     //     print(genre_id.toString());
//     //     print("genre_id");
//     //
//     //   }else if(type=='2'){
//     //     _future=get_artist_song_api();
//     //     print("type");
//     //     print(type);
//     //     print("type");
//     //     print("artist_id");
//     //     print(artist_id.toString());
//     //     print("artist_id");
//     //
//     //   }else if(type=='3'){
//     //     _future=get_album_song_api();
//     //     print("type");
//     //     print(type);
//     //     print("type");
//     //     print("album_id");
//     //     print(album_id.toString());
//     //     print("album_id");
//     //   }else if(type=='4'){
//     //     _future=get_mood_song_api();
//     //     print("type");
//     //     print(type);
//     //     print("type");
//     //     print("artist_modd_id");
//     //     print(artist_modd_id.toString());
//     //     print("artist_modd_id");
//     //   }
//     // });
//
//   }
//
//   @override
//   void dispose() {
//     _connectivitySubscription?.cancel();
//     setState(() {
//
//     });
//     super.dispose();
//   }
//
//   // Future<void> initConnectivity() async {
//   //   late ConnectivityResult result;
//   //   try {
//   //     result = await _connectivity.checkConnectivity();
//   //   } on PlatformException catch (e) {
//   //     return;
//   //   }
//   //
//   //   if (!mounted) {
//   //     return Future.value(null);
//   //   }
//   //
//   //   return _updateConnectionStatus(result);
//   // }
//   // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//   //   setState(() {
//   //     _connectionStatus = result;
//   //   });
//   // }
//   //
//   // showLoaderDialog(BuildContext context) {
//   //   AlertDialog alert = AlertDialog(
//   //     content:  Row(
//   //       children: [
//   //         CircularProgressIndicator(),
//   //         Container(
//   //             margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
//   //       ],
//   //     ),
//   //   );
//   //   showDialog(
//   //     barrierDismissible: false,
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return alert;
//   //     },
//   //   );
//   // }
//
//   // Future<Artist_Song_Model> get_genre_song_api() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   tokanget=prefs.getString('login_user_token');
//   //
//   //   var response = await http.post(Uri.parse(BASE_URL+getSongsOfGenreapi),headers: {'Authorization': 'Bearer $tokanget',}, body: toMap1());
//   //   showLoaderDialog(context);
//   //
//   //   data=response.body;
//   //   print('????????????????????');
//   //   print(json.decode(response.body));
//   //   print('???????????????????');
//   //
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).status);
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).success);
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).message);
//   //
//   //   status = (Artist_Song_Model.fromJson(json.decode(response.body)).status);
//   //   message = (Artist_Song_Model.fromJson(json.decode(response.body)).message);
//   //
//   //   setState((){
//   //
//   //     songslist_data = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
//   //     print("POPMIXSCREEN");
//   //     print(songslist_data);
//   //     print("POPMIXSCREEN");
//   //
//   //   });
//   //   Navigator.pop(context);
//   //
//   //   if(status==200){
//   //
//   //
//   //
//   //   }else{
//   //     Navigator.pop(context);
//   //
//   //     Fluttertoast.showToast(
//   //         msg: message,
//   //         toastLength: Toast.LENGTH_SHORT,
//   //         gravity: ToastGravity.BOTTOM,
//   //         backgroundColor:Colors.black,
//   //         textColor: Colors.white,
//   //         fontSize: 16.0);
//   //   }
//   //   return Artist_Song_Model.fromJson(json.decode(response.body));
//   // }
//   //
//   // Future<Artist_Song_Model> get_album_song_api() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   tokanget=prefs.getString('login_user_token');
//   //
//   //   var response = await http.post(Uri.parse(BASE_URL+getSongsOfAlbumapi),headers: {'Authorization': 'Bearer $tokanget',}, body: toMap2());
//   //   showLoaderDialog(context);
//   //
//   //   data=response.body;
//   //   print('????????????????????');
//   //   print(json.decode(response.body));
//   //   print('???????????????????');
//   //
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).status);
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).success);
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).message);
//   //
//   //   status = (Artist_Song_Model.fromJson(json.decode(response.body)).status);
//   //   message = (Artist_Song_Model.fromJson(json.decode(response.body)).message);
//   //
//   //   setState((){
//   //     songslist_data = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
//   //
//   //   });
//   //   Navigator.pop(context);
//   //
//   //   if(status==200){
//   //
//   //     // Fluttertoast.showToast(
//   //     //     msg: message,
//   //     //     toastLength: Toast.LENGTH_SHORT,
//   //     //     gravity: ToastGravity.BOTTOM,
//   //     //     backgroundColor:Colors.black,
//   //     //     textColor: Colors.white,
//   //     //     fontSize: 16.0);
//   //
//   //   }else{
//   //     Navigator.pop(context);
//   //
//   //     Fluttertoast.showToast(
//   //         msg: message,
//   //         toastLength: Toast.LENGTH_SHORT,
//   //         gravity: ToastGravity.BOTTOM,
//   //         backgroundColor:Colors.black,
//   //         textColor: Colors.white,
//   //         fontSize: 16.0);
//   //   }
//   //   return Artist_Song_Model.fromJson(json.decode(response.body));
//   // }
//   //
//   // Future<Artist_Song_Model> get_artist_song_api() async {
//   //
//   //
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   tokanget=prefs.getString('login_user_token');
//   //
//   //   var response = await http.post(Uri.parse(BASE_URL+getSongsOfArtistapi),headers: {'Authorization': 'Bearer $tokanget',}, body: toMap());
//   //   showLoaderDialog(context);
//   //
//   //   data=response.body;
//   //   print('????????????????????');
//   //   print(json.decode(response.body));
//   //   print('???????????????????');
//   //
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).status);
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).success);
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).message);
//   //
//   //   status = (Artist_Song_Model.fromJson(json.decode(response.body)).status);
//   //   message = (Artist_Song_Model.fromJson(json.decode(response.body)).message);
//   //
//   //   setState((){
//   //     songslist_data = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
//   //   });
//   //   Navigator.pop(context);
//   //
//   //   if(status==200){
//   //     //
//   //     // Fluttertoast.showToast(
//   //     //     msg: message,
//   //     //     toastLength: Toast.LENGTH_SHORT,
//   //     //     gravity: ToastGravity.BOTTOM,
//   //     //     backgroundColor:Colors.black,
//   //     //     textColor: Colors.white,
//   //     //     fontSize: 16.0);
//   //
//   //   }else{
//   //     Navigator.pop(context);
//   //
//   //     Fluttertoast.showToast(
//   //         msg: message,
//   //         toastLength: Toast.LENGTH_SHORT,
//   //         gravity: ToastGravity.BOTTOM,
//   //         backgroundColor:Colors.black,
//   //         textColor: Colors.white,
//   //         fontSize: 16.0);
//   //   }
//   //   return Artist_Song_Model.fromJson(json.decode(response.body));
//   // }
//   //
//   // Future<Artist_Song_Model> get_mood_song_api() async {
//   //
//   //
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   tokanget=prefs.getString('login_user_token');
//   //
//   //   var response = await http.post(Uri.parse(BASE_URL+getSongsOfMoodapi),headers: {'Authorization': 'Bearer $tokanget',}, body: toMap3());
//   //   showLoaderDialog(context);
//   //
//   //   data=response.body;
//   //
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).status);
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).success);
//   //   print(Artist_Song_Model.fromJson(json.decode(response.body)).message);
//   //
//   //   status = (Artist_Song_Model.fromJson(json.decode(response.body)).status);
//   //   message = (Artist_Song_Model.fromJson(json.decode(response.body)).message);
//   //
//   //   setState((){
//   //     songslist_data = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
//   //
//   //   });
//   //   Navigator.pop(context);
//   //
//   //   if(status==200){
//   //
//   //     // Fluttertoast.showToast(
//   //     //     msg: message,
//   //     //     toastLength: Toast.LENGTH_SHORT,
//   //     //     gravity: ToastGravity.BOTTOM,
//   //     //     backgroundColor:Colors.black,
//   //     //     textColor: Colors.white,
//   //     //     fontSize: 16.0);
//   //
//   //   }else{
//   //     Navigator.pop(context);
//   //
//   //     Fluttertoast.showToast(
//   //         msg: message,
//   //         toastLength: Toast.LENGTH_SHORT,
//   //         gravity: ToastGravity.BOTTOM,
//   //         backgroundColor:Colors.black,
//   //         textColor: Colors.white,
//   //         fontSize: 16.0);
//   //   }
//   //   return Artist_Song_Model.fromJson(json.decode(response.body));
//   // }
//   //
//   //
//   // Map toMap() {
//   //   var map = new Map<String, dynamic>();
//   //
//   //
//   //   map["id"] = artist_id.toString();
//   //
//   //   return map;
//   // }
//   // Map toMap1() {
//   //   var map =  Map<String, dynamic>();
//   //
//   //
//   //   map["genre_id"] = genre_id.toString();
//   //
//   //   return map;
//   // }
//   //
//   // Map toMap2() {
//   //   var map =  Map<String, dynamic>();
//   //
//   //
//   //   map["album_id"] = album_id.toString();
//   //
//   //   return map;
//   // }
//   //
//   // Map toMap3() {
//   //   var map =  Map<String, dynamic>();
//   //
//   //
//   //   map["your_mood_id"] = artist_modd_id.toString();
//   //
//   //   return map;
//   // }
//   // var index1 = null;
//
// // Future<void> downlod(imgurl,banner) async {
// //   print('aman');
// //   Map<Permission, PermissionStatus> statuses = await [
// //   Permission.storage,
// //   //add more permission to request here.
// //   ].request();
// //   if(statuses[Permission.storage]!.isGranted){
// //     print('aman1');
// //     var dir = await DownloadsPathProvider.downloadsDirectory;
// //     if(dir != null){
// //       print('aman2');
// //       String savename = "$banner.mp3";
// //       String savePath = dir.path + "/$savename";
// //       print(savePath);
// //       print('aman3');
// //
// //       //output:  /storage/emulated/0/Download/banner.png
// //
// //       try {
// //         await Dio().download(
// //             imgurl,
// //             savePath,
// //             onReceiveProgress: (received, total) {
// //               if (total != -1) {
// //                 print((received / total * 100).toStringAsFixed(0) + "%");
// //                 //you can build progressbar feature too
// //               }
// //             });
// //         print("Image is saved to download folder.");
// //       } on DioError catch (e) {
// //         print(e.message);
// //       }
// //     }
// //   }else{
// //     print("No permission to read and write.");
// //   }
// //
// // }
//
//    List mysongList;
//
//   Future<Artist_Song_Model> fechData() async {
//     print("tesgtdfshggfhhdf");
//
//     Artist_Song_Model bm;
//     String url = "http://44.197.223.72:4000/getAllSongs/10/0";
//     http.Response response = await http.get(Uri.parse(url),
//     );
//
//     Map<String, dynamic> jsonresponse = jsonDecode(response.body);
//     songslist_data = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
//
//     mysongList= (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
//     print(mysongList);
//     print("sdfghgfdsdfghgfdsdfghfdsdfghgfdsdfgh" + jsonresponse.toString());
//     bm = Artist_Song_Model.fromJson(jsonresponse);
//     print("tesgtdfshggasdfghfhhdf22222" + jsonresponse.toString());
//
//     return bm;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   backgroundColor: colorappblack,
//     //   appBar:  AppBar(
//     //       elevation: 0,
//     //       backgroundColor: colorappblack,
//     //       leading: IconButton(
//     //           icon: SvgPicture.asset('assets/icons/Back-Navs.svg',width: 25,height:25,),
//     //           onPressed: () {
//     //             player.stop();
//     //             Get.back();
//     //             Get.off(BottomBar());
//     //           }),
//     //       centerTitle: true,
//     //       title: Text(name.toString(),
//     //         // widget.type=='1'? 'Pop Mix': widget.type=='2'?  'Artist'  :widget.type=='3'?  'Album' :widget.type=='4'?'Mood':"",
//     //
//     //         style: textstyleHeading6(context)!.copyWith(color: colorWhite),
//     //       ),
//     //       bottom:  PreferredSize(
//     //           preferredSize: const Size.fromHeight(1.0),
//     //           child:  Container(
//     //             color: HexColor("#D9D9D9"),
//     //             padding: const EdgeInsets.all(0.4),
//     //           ))
//     //   ),
//     //   // appbartitlebackbtn(context, widget.type=='1'? 'Pop Mix': widget.type=='2'?  'Artist'  :widget.type=='3'?  'Album' :widget.type=='4'?'Mood':""
//     //
//     //
//     //   body: FutureBuilder(
//     //     future: _future,
//     //     builder: (context, snapshot) {
//     //       if (snapshot.hasData) {
//     //         return songslist_data.isEmpty
//     //             ?  const Center(child: Text('No Data Found Here',style: TextStyle(
//     //           color: Colors.white
//     //         ),))
//     //             :    Container(
//     //           padding: EdgeInsets.all(10),
//     //           width: deviceWidth(context),
//     //           height: deviceheight(context),
//     //           child: SingleChildScrollView(
//     //             physics: ScrollPhysics(),
//     //             child: Column(
//     //               crossAxisAlignment: CrossAxisAlignment.center,
//     //               children: [
//     //                 widget.type=='1'?  Align(
//     //                   alignment: Alignment.centerLeft,
//     //                   child: Text('Let’s try some pop mix',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//     //                       fontWeight: FontWeight.w700,fontSize: 20,height: 2)),
//     //                 ):Container(),
//     //                 widget.type=='1'?   Align(
//     //                   alignment: Alignment.centerLeft,
//     //                   child: Text('${songslist_data.length} songs',style: TextStyle(color: colorhintcolor  ,fontFamily: 'Mulish',
//     //                       fontWeight: FontWeight.w400,fontSize: 14,height: 2)),
//     //                 ):Container(),
//     //
//     //                 widget.type=='2'?   Container(
//     //                   width: 80,
//     //                   height: 80,
//     //                   decoration: BoxDecoration(
//     //                       borderRadius: BorderRadius.circular(50),
//     //                       image: const DecorationImage(
//     //                           image: AssetImage('assets/icons/image.png')
//     //                       )
//     //                   ),
//     //                 ):Container(),
//     //                 widget.type=='2'?  Text('${songslist_data[0].artistName}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//     //                     fontWeight: FontWeight.w700,fontSize: 18,height: 2)):Container(),
//     //                 widget.type=='2'?   Text('${songslist_data.length} songs',style: TextStyle(color: colorhintcolor  ,fontFamily: 'Mulish',
//     //                     fontWeight: FontWeight.w400,fontSize: 12,height: 2)):Container(),
//     //                 sizedboxheight(10.0),
//     //                 Container(
//     //
//     //                   child: ListView.builder(
//     //                       physics: NeverScrollableScrollPhysics(),
//     //                       shrinkWrap: true,
//     //                       itemCount: songslist_data.length,
//     //                       itemBuilder: (BuildContext context, int index){
//     //                         return InkWell(
//     //                           // onTap: (){
//     //                           //   Get.to(() => Mixing(
//     //                           //       indexnumber: index,
//     //                           //       songslist_data:songslist_data,
//     //                           //       DRUMSsongs:songslist_data[index].drums.toString(),
//     //                           //       BASSSsongs:songslist_data[index].bass.toString(),
//     //                           //       GUITARSsongs:songslist_data[index].guitar.toString(),
//     //                           //       VOCALSSsongs:songslist_data[index].vocals.toString(),
//     //                           //   ));
//     //                           // },
//     //                           child: Card(
//     //                             shape: RoundedRectangleBorder(
//     //                               borderRadius: BorderRadius.circular(10.0),
//     //                             ),
//     //                             color: colorlightblack,
//     //                             child: Container(
//     //                               padding: EdgeInsets.all(5),
//     //                               child: Row(
//     //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                                 children: [
//     //                                   Container(
//     //                                     width: deviceWidth(context,0.15),
//     //                                     height: 55,
//     //                                     decoration: BoxDecoration(
//     //                                         borderRadius: BorderRadius.circular(20),
//     //                                         image:  DecorationImage(
//     //                                             fit: BoxFit.fill,
//     //                                             // image: AssetImage('assets/icons/image.png')
//     //                                             image: NetworkImage('https://glistener.s3.amazonaws.com/${songslist_data[index].coverImage}')
//     //                                         )
//     //                                     ),
//     //                                   ),
//     //
//     //                                   Container(
//     //                                     width: deviceWidth(context,0.5),
//     //                                     child: Column(
//     //                                       crossAxisAlignment: CrossAxisAlignment.start,
//     //                                       children: [
//     //                                         Text('${songslist_data[index].label}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//     //                                             fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
//     //                                         Text('${songslist_data[index].albumType}',style: TextStyle(color: HexColor("#909090")  ,fontFamily: 'Poppins',
//     //                                             fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
//     //                                         Text('2:45 minutes',style: TextStyle(color: HexColor("#DEDBDB")  ,fontFamily: 'Poppins',
//     //                                             fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
//     //                                       ],
//     //                                     ),
//     //                                   ),
//     //                                   Container(
//     //                                     width: deviceWidth(context,0.2),
//     //                                     child: Row(
//     //                                       crossAxisAlignment: CrossAxisAlignment.center,
//     //                                       mainAxisAlignment: MainAxisAlignment.center,
//     //                                       children: [
//     //                                         songslist_data[index].songplay == true ?
//     //                                         InkWell(
//     //                                             onTap: (){
//     //                                               setState(()  {
//     //                                                 playposh = false;
//     //                                                 if(index1 != null){
//     //                                                   setState((){
//     //                                                     songslist_data[index1].songplay = true;
//     //                                                     index1 = index;
//     //                                                   });
//     //
//     //                                                 }else{
//     //                                                   setState((){
//     //                                                     index1 = index;
//     //                                                   });
//     //                                                 }
//     //                                                 setState((){
//     //                                                   index1 = index;
//     //                                                   songslist_data[index].songplay = false;
//     //                                                 });
//     //
//     //                                                 print(index);
//     //                                                 selectedIndex=index;
//     //                                                 player.setUrl(song_Url+songslist_data[index].master1.toString()).then((play){
//     //                                                   player.play(song_Url+songslist_data[index].master1.toString());
//     //                                                 });
//     //
//     //                                               });
//     //                                             },
//     //                                             child: SvgPicture.asset('assets/icons/push.svg',height: 30,)):
//     //                                         InkWell(
//     //                                             onTap: (){
//     //                                               setState(()  {
//     //                                                 playposh = true;
//     //                                                 songslist_data[index].songplay = true;
//     //                                                 player.stop();
//     //
//     //                                               });
//     //
//     //                                             },
//     //                                             child: SvgPicture.asset("assets/icons/play.svg",height: 30,)),
//     //                                         sizedboxwidth(10.0),
//     //                                         InkWell(
//     //                                             onTap: () async {
//     //                                              setState(() {
//     //                                                playposh = true;
//     //                                                songslist_data[index].songplay = true;
//     //                                                player.stop();
//     //                                                player.setUrl(song_Url+songslist_data[index].master1.toString()).then((play){
//     //                                                  player.stop();
//     //                                                });
//     //
//     //                                              });
//     //                                              print(songslist_data[index].id.toString());
//     //                                              print(song_Url+songslist_data[index].drums.toString());
//     //                                              print(song_Url+songslist_data[index].bass.toString());
//     //                                              print(song_Url+songslist_data[index].guitar.toString());
//     //                                              print(song_Url+songslist_data[index].vocals.toString());
//     //
//     //
//     //                                               Get.to(() => Mixing(
//     //                                                 indexnumber: index,
//     //                                                 songslist_data:songslist_data,
//     //                                                 DRUMSsongs:songslist_data[index].drums.toString(),
//     //                                                 BASSSsongs:songslist_data[index].bass.toString(),
//     //                                                 GUITARSsongs:songslist_data[index].guitar.toString(),
//     //                                                 VOCALSSsongs:songslist_data[index].vocals.toString(),
//     //                                                 id : songslist_data[index].id.toString(),
//     //                                                 category: null,
//     //                                                 artist: null,
//     //                                               ));
//     //                                             },
//     //                                             child: Image.asset('assets/new/btn.png',height: 30,)),
//     //                                       ],
//     //                                     ),
//     //                                   ),
//     //
//     //                                 ],
//     //                               ),
//     //                             ),
//     //                           ),
//     //                         );
//     //                       }),
//     //                 ),
//     //               ],
//     //             ),
//     //           ),
//     //         );
//     //
//     //
//     //       } else {
//     //         return const Center(
//     //           child: CircularProgressIndicator(),
//     //         );
//     //       }
//     //     },
//     //     // future: postlist(),
//     //   )
//     //
//     //
//     //
//     //
//     //
//     // );
//
//     return Scaffold(
//         backgroundColor: colorappblack,
//         // appBar:  AppBar(
//         //     elevation: 0,
//         //     backgroundColor: colorappblack,
//         //     leading: IconButton(
//         //         icon: SvgPicture.asset('assets/icons/Back-Navs.svg',width: 25,height:25,),
//         //         onPressed: () {
//         //           player.stop();
//         //           Get.back();
//         //           Get.off(BottomBar());
//         //         }),
//         //     centerTitle: true,
//         //     title: Text("All Songs".toString(),
//         //       // widget.type=='1'? 'Pop Mix': widget.type=='2'?  'Artist'  :widget.type=='3'?  'Album' :widget.type=='4'?'Mood':"",
//         //
//         //       style: textstyleHeading6(context)!.copyWith(color: colorWhite),
//         //     ),
//         //     bottom:  PreferredSize(
//         //         preferredSize: const Size.fromHeight(1.0),
//         //         child:  Container(
//         //           color: HexColor("#D9D9D9"),
//         //           padding: const EdgeInsets.all(0.4),
//         //         ))
//         // ),
//         body:  FutureBuilder(
//           future: fechData(),
//           builder: (BuildContext context, AsyncSnapshot<Artist_Song_Model> snapshot) {
//             if(snapshot.hasData==false){
//
//               return Center(child: CircularProgressIndicator(color: Colors.white,));
//             }else{
//               return    Container(
//                 child: ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: snapshot.data!.data!.length,
//                     itemBuilder: (BuildContext context, int index){
//                       return InkWell(
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           color: colorlightblack,
//                           child: Container(
//                             padding: EdgeInsets.all(5),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   width: deviceWidth(context,0.15),
//                                   height: 55,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       image:  DecorationImage(
//                                           fit: BoxFit.fill,
//                                           // image: AssetImage('assets/icons/image.png')
//                                           image: NetworkImage('https://glistener.s3.amazonaws.com/${snapshot.data!.data?[index].coverImage}')
//                                       )
//                                   ),
//                                 ),
//
//                                 Container(
//                                   width: deviceWidth(context,0.5),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text('${"${snapshot.data!.data?[index].label}"}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
//                                           fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
//                                       Text('${"snapshot.data!.data[0].a"}',style: TextStyle(color: HexColor("#909090")  ,fontFamily: 'Poppins',
//                                           fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
//                                       Text('2:45 minutes',style: TextStyle(color: HexColor("#DEDBDB")  ,fontFamily: 'Poppins',
//                                           fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   width: deviceWidth(context,0.2),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       songslist_data[index].songplay == true ?
//                                       InkWell(
//                                           onTap: (){
//                                             setState(()  {
//                                               playposh = false;
//                                               if(index1 != null){
//                                                 setState((){
//                                                   songslist_data[index1].songplay = true;
//                                                   index1 = index;
//                                                 });
//
//                                               }else{
//                                                 setState((){
//                                                   index1 = index;
//                                                 });
//                                               }
//                                               setState((){
//                                                 index1 = index;
//                                                 songslist_data[index].songplay = false;
//                                               });
//
//                                               print(index);
//                                               selectedIndex=index;
//                                               player.setUrl(song_Url+songslist_data[index].master1.toString()).then((play){
//                                                 player.play(song_Url+songslist_data[index].master1.toString());
//                                                 print("pramod12345678===================================");
//                                                 print(song_Url+songslist_data[index].master1.toString());
//                                               });
//
//                                             });
//                                           },
//                                           child: SvgPicture.asset('assets/icons/push.svg',height: 30,)):
//                                       InkWell(
//                                           onTap: (){
//                                             setState(()  {
//                                               playposh = true;
//                                               songslist_data[index].songplay = true;
//                                               player.stop();
//
//                                             });
//
//                                           },
//                                           child: SvgPicture.asset("assets/icons/play.svg",height: 30,)),
//                                       sizedboxwidth(10.0),
//                                       InkWell(
//                                           onTap: () async {
//                                             setState(() {
//                                               playposh = true;
//                                               songslist_data[index].songplay = true;
//                                               player.stop();
//                                               player.setUrl(song_Url+songslist_data[index].master1.toString()).then((play){
//                                                 player.stop();
//                                               });
//
//                                             });
//                                             print(songslist_data[index].id.toString());
//                                             print(song_Url+songslist_data[index].drums.toString());
//                                             print(song_Url+songslist_data[index].bass.toString());
//                                             print(song_Url+songslist_data[index].guitar.toString());
//                                             print(song_Url+songslist_data[index].vocals.toString());
//
//
//                                             Get.to(() => Mixing(
//                                               indexnumber: index,
//                                               songslist_data:songslist_data,
//                                               DRUMSsongs:songslist_data[index].drums.toString(),
//                                               BASSSsongs:songslist_data[index].bass.toString(),
//                                               GUITARSsongs:songslist_data[index].guitar.toString(),
//                                               VOCALSSsongs:songslist_data[index].vocals.toString(),
//                                               id : songslist_data[index].id.toString(),
//                                               category: null,
//                                               artist: null, title: "${snapshot.data!.data?[index].label}",
//                                             ));
//                                           },
//                                           child: Image.asset('assets/new/btn.png',height: 30,)),
//                                     ],
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               );
//             }
//
//
//           },
//
//         )
//
//
//     );
//   }
//
// }
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final player  = AudioPlayer();
  var song_Url="https://glistener.s3.amazonaws.com/";
  bool chaluu =true;
  List<bool> chalu =[];
  List ? mysongList;

  Future<Artist_Song_Model> fechData() async {
    print("tesgtdfshggfhhdf");

    Artist_Song_Model bm;
    String url = "http://44.197.223.72:4000/getAllSongs/";
    http.Response response = await http.get(Uri.parse(url),
    );

    Map<String, dynamic> jsonresponse = jsonDecode(response.body);
    mysongList = (Artist_Song_Model.fromJson(json.decode(response.body)).data!);

    mysongList= (Artist_Song_Model.fromJson(json.decode(response.body)).data!);
    print(mysongList);
    print("sdfghgfdsdfghgfdsdfghfdsdfghgfdsdfgh" + jsonresponse.toString());
    bm = Artist_Song_Model.fromJson(jsonresponse);
    print("tesgtdfshggasdfghfhhdf22222" + jsonresponse.toString());

    return bm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorappblack,
        // appBar:  AppBar(
        //     elevation: 0,
        //     backgroundColor: colorappblack,
        //     leading: IconButton(
        //         icon: SvgPicture.asset('assets/icons/Back-Navs.svg',width: 25,height:25,),
        //         onPressed: () {
        //           player.stop();
        //           Get.back();
        //           Get.off(BottomBar());
        //         }),
        //     centerTitle: true,
        //     title: Text("All Songs".toString(),
        //       // widget.type=='1'? 'Pop Mix': widget.type=='2'?  'Artist'  :widget.type=='3'?  'Album' :widget.type=='4'?'Mood':"",
        //
        //       style: textstyleHeading6(context)!.copyWith(color: colorWhite),
        //     ),
        //     bottom:  PreferredSize(
        //         preferredSize: const Size.fromHeight(1.0),
        //         child:  Container(
        //           color: HexColor("#D9D9D9"),
        //           padding: const EdgeInsets.all(0.4),
        //         ))
        // ),
        body:  FutureBuilder(
          future: fechData(),
          builder: (BuildContext context, AsyncSnapshot<Artist_Song_Model> snapshot) {
            print("pramod");


            if(snapshot.hasData==false){

              return Center(child: CircularProgressIndicator(color: Colors.white,));
            }else{
              for(int i=0 ; i< snapshot.data!.data!.length ; i++){
                chalu.add(true);
              }


              return    Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: colorlightblack,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: deviceWidth(context,0.15),
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image:  DecorationImage(
                                          fit: BoxFit.fill,
                                          // image: AssetImage('assets/icons/image.png')
                                          image: NetworkImage('https://glistener.s3.amazonaws.com/${snapshot.data!.data?[index].coverImage}')
                                      )
                                  ),
                                ),

                                Container(
                                  width: deviceWidth(context,0.5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${"${snapshot.data!.data?[index].label}"}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
                                      // Text('${"snapshot.data!.data[0].a"}',style: TextStyle(color: HexColor("#909090")  ,fontFamily: 'Poppins',
                                      //     fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
                                      SizedBox(height : 5),
                                      Text('2:45 minutes',style: TextStyle(color: HexColor("#DEDBDB")  ,fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: deviceWidth(context,0.2),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // songslist_data[index].songplay == true ?true

                                    chalu[index] ?  InkWell(
                                          onTap: (){
                                            for(int i=0 ; i<chalu.length ; i++){
                                              chalu[i]=true;
                                            }
                                               chalu[index]=false;
                                            print("playsong is true ${chalu[index]}}");
                                            print("playsong is arry ${chalu.toString()}}");
                                            player.stop();
                                              player.setUrl(song_Url+mysongList![index].master1.toString()).then((play){
                                              player.play(song_Url+mysongList![index].master1.toString());
                                              print("playsong is ${song_Url+mysongList![index].master1.toString()}");
                                              print(index);
                                              setState(() {

                                              });

                                          },);},
                                          child: SvgPicture.asset('assets/icons/push.svg',height: 30,)):
                                      InkWell(
                                          onTap: (){
                                            // player.setUrl(song_Url+mysongList![index].master1.toString()).then((play){
                                            //   player.stop();
                                            // });
                                            player.stop();

                                              chalu[index]=true;

                                            print("playsong is true ${chalu[index]}}");
                                            print("playsong is arry ${chalu.toString()}}");
                                            setState(() {

                                            });
                                          },

                                          child: SvgPicture.asset("assets/icons/play.svg",height: 30,)),

                                      sizedboxwidth(10.0),
                                      InkWell(
                                          onTap: () async {
                                            setState(() {
                                              player.stop();
                                              });


                                            // print(songslist_data[index].id.toString());
                                            // print(song_Url+songslist_data[index].drums.toString());
                                            // print(song_Url+songslist_data[index].bass.toString());
                                            // print(song_Url+songslist_data[index].guitar.toString());
                                            // print(song_Url+songslist_data[index].vocals.toString());


                                            Get.to(() => Mixing(
                                              title: "${snapshot.data!.data?[index].label}",
                                              id : snapshot.data!.data?[index].id.toString(),
                                            ));
                                          },
                                          child: Image.asset('assets/new/btn.png',height: 30,)),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }


          },

        )
    );
  }
}
