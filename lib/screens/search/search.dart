import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/formtextfield/mytextfield.dart';
import '../../common/styles/const.dart';
import '../../modal/Home_Model.dart';
import 'package:http/http.dart'as http;

import '../home/popmixscreen.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Artist> artistdata=[];
  List<Albums> albumsdata=[];
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  String?   image_file,user_id = "",  search="";
  var status,message,tokanget,data,song_name,artist_genre_id,artist_artist_id,artist_album_id,artist_modd_id;


  @override
  void initState() {
    super.initState();

    setState(() {

      homepageapi();
    });
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
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
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


  Future<Home_Model> homepageapi() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id=prefs.getString('user_id');
    tokanget=prefs.getString('login_user_token');

    var response = await http.post(Uri.parse(BASE_URL+homePageapi),headers: {'Authorization': 'Bearer $tokanget',}, body: toMap());
    // showLoaderDialog(context);

    data=response.body;

    print(Home_Model.fromJson(json.decode(response.body)).status);
    print(Home_Model.fromJson(json.decode(response.body)).success);
    print(Home_Model.fromJson(json.decode(response.body)).message);

    status = (Home_Model.fromJson(json.decode(response.body)).status);
    message = (Home_Model.fromJson(json.decode(response.body)).message);

    setState((){

      artistdata=Home_Model.fromJson(json.decode(response.body)).artist!;
      albumsdata=Home_Model.fromJson(json.decode(response.body)).albums!;
      // song_name = Home_Model.fromJson(json.decode(response.body)).genre[0].genreType;
      // image = Home_Model.fromJson(json.decode(response.body)).genre[0].image;


    });
    // Navigator.pop(context);


    if(status==200){



    }else{
      // Navigator.pop(context);

      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor:Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return Home_Model.fromJson(json.decode(response.body));
  }
  Map toMap() {
    var map = new Map<String, dynamic>();


    map["user_id"] = user_id.toString();
    map["search"] = search.toString();
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      body: Container(
      padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchbar(),
              sizedboxheight(10.0),
              Padding(
                padding: EdgeInsets.only(top: 10,bottom: 10,right: 5),
                child: Text("Albums",style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,fontSize: 16),),
              ),
              Container(
                height: deviceheight(context,0.17),
                width: deviceWidth(context),
                child: albumsdata.length==0?Container(
                  child:  Center(
                    child: Text('No Data Found',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,fontSize: 16)),
                  ),
                ): ListView.builder(
                  scrollDirection:  Axis.horizontal,
                  itemCount: albumsdata.length,
                    itemBuilder: (BuildContext context , int index){
                  return GestureDetector(onTap: () {
                    artist_album_id=albumsdata[index].id.toString();

                    print("artist_album_id");
                    print(artist_album_id);
                    print("artist_album_id");

                    Get.to(() => PopMixScreen(type:'3',album_id:artist_album_id,name:albumsdata[index].albumType));
                  },
                    child: Container(
                   margin: EdgeInsets.only(top: 5,bottom: 5,right: 5),
                    height: deviceheight(context,0.1),
                    width: deviceWidth(context,0.3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image:  DecorationImage(
                        // image: AssetImage('assets/icons/image.png',)
                          image: NetworkImage('${BASE_URL_img_home}albums/${albumsdata[index].image!}')
                      ),
                    ),
                    child:Container(
                        height: deviceheight(context,0.18),
                        width: deviceWidth(context,0.4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                       color: colorblack.withOpacity(0.4)
                        ),
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Text('${albumsdata[index].albumType!}'
                            ,style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,fontSize: 12,height: 1.5),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                  ));
                }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10,bottom: 10,right: 5),
                child: Text("Artists For You",style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,fontSize: 16),),
              ),
              Container(
                height: deviceheight(context,0.22),
                width: deviceWidth(context),
                child:artistdata.length==0?Container(
                  child:  Center(
                    child: Text('No Data Found',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,fontSize: 16)),
                  ),
                ): ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: artistdata.length,
                    itemBuilder: (BuildContext context , int index){
                      return
                      //   Padding(
                      //   padding: const EdgeInsets.only(top: 8,bottom: 8,right: 8),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       CircleAvatar(
                      //         radius:  deviceheight(context,0.07),
                      //         backgroundImage: AssetImage('assets/icons/image.png',),
                      //       ),
                      //       Text('Harry’s House'
                      //         ,style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                      //             fontWeight: FontWeight.w500,fontSize: 12,height: 1.5),
                      //         textAlign: TextAlign.center,
                      //         maxLines: 2,
                      //       )
                      //     ],
                      //   ),
                      // );
                        Column(
                          children: [
                            InkWell(
                              onTap: (){
                                artist_artist_id=artistdata[index].id.toString();
                                print("artist_artist_id");
                                print(artist_artist_id);
                                print("artist_artist_id");

                                Get.to(() => PopMixScreen(type:'2',artist_id: artistdata[index].id.toString(),name:artistdata[index].artistName));
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10,bottom: 10),
                                height: 100,width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image:  DecorationImage(
                                      image: NetworkImage("${BASE_URL_img_home}artist/"+artistdata[index].image!)

                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                artist_artist_id=artistdata[index].id.toString();
                                print("artist_artist_id");
                                print(artist_artist_id);
                                print("artist_artist_id");

                                Get.to(() => PopMixScreen(type:'2',artist_id: artistdata[index].id.toString(),name:artistdata[index].artistName));                              },
                              child: Text('${artistdata[index].artistName}',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,fontSize: 12)),
                            ),
                          ],
                        );
                    }),
              ),
              sizedboxheight(100.0),
            ],
          ),
        ),
      ),
    );
  }
  Widget searchbar() {
    return  TextField(
      onChanged: (value) {
        setState(() {
          search=value;
          print("EXAM_VALUE"+search.toString());
          homepageapi();
        }); },
      autofocus: false,
      style: TextStyle(
          color: colorWhite,
          // fontFamily: 'Nunito',
          fontWeight: FontWeight.w500,
          fontSize:  14),
      decoration: InputDecoration(
        filled: true,
        fillColor: colorscreenbackground,
        hintText: 'Search',
        hintStyle: TextStyle(
          color:  colorgrey,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        contentPadding:
        const EdgeInsets.only(left: 14.0, bottom: 12.0, top: 0.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.7),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.7),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.7),
        ),

        suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 20, top: 15, bottom: 15),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              height: 0,
              width: 0,
            )
        ),
      ),
    );
  }
}