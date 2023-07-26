import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glistener/screens/home/popmixscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/appbar/appbarpage.dart';
import '../../common/styles/const.dart';
import '../../modal/Home_Model.dart';
import 'package:http/http.dart'as http;


class GenreScreen extends StatefulWidget {
  var type;
  GenreScreen({Key? key, this.type}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState(type:type);

}

class _GenreScreenState extends State<GenreScreen> {
  var type;
  _GenreScreenState(
      { Key? key,
        this.type
      });


  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  String?   image_file,user_id = "";
  var status,message,tokanget,data,song_name,artist_genre_id,artist_artist_id,artist_album_id,artist_modd_id;

  List<Genre> genredata=[];
  List<Artist> artistdata=[];
  List<Albums> albumsdata=[];
  List<Yourmood> yourmooddata=[];


  @override
  void initState() {
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
    showLoaderDialog(context);

    data=response.body;

    print(Home_Model.fromJson(json.decode(response.body)).status);
    print(Home_Model.fromJson(json.decode(response.body)).success);
    print(Home_Model.fromJson(json.decode(response.body)).message);

    status = (Home_Model.fromJson(json.decode(response.body)).status);
    message = (Home_Model.fromJson(json.decode(response.body)).message);

    setState((){

      genredata=Home_Model.fromJson(json.decode(response.body)).genre!;
      artistdata=Home_Model.fromJson(json.decode(response.body)).artist!;
      albumsdata=Home_Model.fromJson(json.decode(response.body)).albums!;
      yourmooddata=Home_Model.fromJson(json.decode(response.body)).yourmood!;
      // song_name = Home_Model.fromJson(json.decode(response.body)).genre[0].genreType;
      // image = Home_Model.fromJson(json.decode(response.body)).genre[0].image;


    });
    Navigator.pop(context);


    if(status==200){



    }else{
      Navigator.pop(context);

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

    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,

      appBar: appbartitlebackbtn(context,"Genre"),

      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                child: GridView.count(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 5,
                    childAspectRatio: (1 / 1),
                    children: List.generate(genredata.length, (index) {
                      return
                        GestureDetector(onTap: () {
                          artist_genre_id=genredata[index].id.toString();

                          print("artist_genre_id");
                          print(artist_genre_id);
                          print("artist_genre_id");

                          Get.to(() => PopMixScreen(type:'1',genre_id:artist_genre_id,name:genredata[index].genreType));
                        },
                            child:Container(

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 130,width: 130,
                            decoration: BoxDecoration(
                                image:  DecorationImage(
                                  // image: AssetImage('assets/icons/image.png',)
                                    image: NetworkImage("${BASE_URL_img_home}genre/"+genredata[index].image!)

                                ),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:Container(
                              height: 130,width: 130,
                              decoration: BoxDecoration(
                                  color: colorblack.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Text('${genredata[index].genreType}'
                                    ,style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,fontSize: 12,height: 1.5),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
                    }
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}