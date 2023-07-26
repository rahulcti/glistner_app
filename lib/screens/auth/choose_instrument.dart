import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glistener/common/styles/const.dart';
import 'package:glistener/screens/auth/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/appbar/appbarpage.dart';
import '../../common/commonwidgets/button.dart';
import '../../modal/Artist_model.dart';
import '../../modal/Favourite_Artist.dart';
import '../../modal/verify_Model.dart';
import '../bottombar/bottombar.dart';
import 'GridItem.dart';
import 'package:http/http.dart'as http;

class Choose_Instrument extends StatefulWidget {
  const Choose_Instrument({Key? key}) : super(key: key);

  @override
  State<Choose_Instrument> createState() => _Choose_InstrumentState();
}

class _Choose_InstrumentState extends State<Choose_Instrument> {
  Future? future;
  String? id_;
  // List<Item>? itemList;
  List<String>? selectedList = [];
  // ProgressDialog? progressDialog;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  var status,message,tokanget;
  List<Artist> artistList =[];
  String? user_id;
  var artist_id,isselected;
  Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
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


  Future<Verify_Model> Verify() async {

    print("CLICKED 123 ==");
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (_connectionStatus != null) {
      // Internet Present Case
      showLoaderDialog(context);
    }else{
      Fluttertoast.showToast(
          msg: "Please check your Internet connection!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    // No-Internet Case
    var response = await http.post(Uri.parse(BASE_URL+verifyArtistapi), body: toMap2());
    print(Verify_Model.fromJson(json.decode(response.body)).success);
    print(Verify_Model.fromJson(json.decode(response.body)).message);
    print(Verify_Model.fromJson(json.decode(response.body)).status);
    status = (Verify_Model.fromJson(json.decode(response.body)).status);
    message = (Verify_Model.fromJson(json.decode(response.body)).message);

    if(status==200){
      // Navigator.pop(context);

      // user = (Signup_Model.fromJson(json.decode(response.body)).userinfo![0].firstName.toString());
      isselected = (Verify_Model.fromJson(json.decode(response.body)).isSelected);

      // print(isselected);



      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('isselected',isselected.toString());

      String? pratik= prefs.getString('isselected');



      //
      // print("dddddeeep;;qqqqqqqqqqqqqqq${aa}");

      // userlast = (Verify_Model.fromJson(json.decode(response.body)).userinfo?.lastname.toString());
      // user_id = (Verify_Model.fromJson(json.decode(response.body)).userinfo![0].id.toString());
      // user_id = (Verify_Model.fromJson(json.decode(response.body)).userinfo!.id.toString());
      // emailad = (Verify_Model.fromJson(json.decode(response.body)).userinfo!.email.toString());
      // image = (Verify_Model.fromJson(json.decode(response.body)).userinfo!.image.toString());

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      //
      // prefs.setString('userfirst',userfirst);
      // prefs.setString('userlast',userlast);
      // prefs.setString('user_id',user_id.toString());
      // prefs.setString('email',emailad.toString());
      // prefs.setString('pics',image.toString());
      // prefs.setString('first',"1");
      // print(emailad);
      //
      // prefs.setString('login_status',"true");
      // prefs.setString('type',"0");


// setState(() {
//   myprofile();
//
// });

      // if(Verify_Model.fromJson(json.decode(response.body)).isSelected == 1){
      //   // Get.off(() => BottomBar());
      //   // var welcome_value=prefs.getString('Welcome_value');
      //   Get.off(() => BottomBar());
      //
      //
      //   // isselected=="1" ?
      //   // Get.off(() => BottomBar()) :
      //   // Get.off(() => Welcome());
      //
      //
      //   // Navigator.of(context).pushReplacement(
      //   //     MaterialPageRoute<Null>(
      //   //         builder: (BuildContext context) {
      //   //           return BottomBar();
      //   //         }));
      // }else{
      //   Get.off(() => Welcome());
      //
      // }

    }else{
      // Navigator.pop(context);

      print('else==============');
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return Verify_Model.fromJson(json.decode(response.body));
  }
  Map toMap2() {
    var map = new Map<String, dynamic>();

    map["user_id"] = user_id.toString();

    // map["email"] = txt_email.text.toString();
    // map["password"] = txt_password.text.toString();


    // print("email ====");
    // print(txt_email.text.toString());
    // print("password ====");
    // print(txt_password.text.toString());

    return map;
  }




  Map toMap1() {
    var map = new Map<String, dynamic>();

    map["user_id"] = user_id.toString();



    print(map.toString());

    return map;
  }

  Future<Artist_model> addartist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokanget = prefs.getString('login_user_token');
    user_id = prefs.getString('user_id');
    tokanget = tokanget.replaceAll('"', '');
    // tokanget = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoxfSwiaWF0IjoxNjYyOTc4MTIxfQ.UkcOwRRiVCja2dYLQyIPMOL05qOPsv-VWx5fU0gbUVg";
    print("CLICKED 123Artist_model =="+tokanget);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (_connectionStatus != null) {
      print("CLICKED _connectionStatus ==");

      // Internet Present Case
      showLoaderDialog(context);
    }else{
      print("CLICKED _connectionStatuselse ==");

      Fluttertoast.showToast(
          msg: "Please check your Internet connection!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    print(BASE_URL+allartist);

    // No-Internet Case
    var response = await http.post(Uri.parse(BASE_URL+allartist), body: toMap1(), headers: {'Authorization': 'Bearer $tokanget',});
    print(response.body);

    // print(Artist_model.fromJson(json.decode(response.body)).success);
    print(Artist_model.fromJson(json.decode(response.body)).message);
    print(Artist_model.fromJson(json.decode(response.body)).status);
    status = (Artist_model.fromJson(json.decode(response.body)).status);
    message = (Artist_model.fromJson(json.decode(response.body)).message);

    if(status==200){
      Navigator.pop(context);
      setState(() {
        // artistList!.clear();
        artistList.addAll(Artist_model.fromJson(json.decode(response.body)).artist!);
      });
      print("artistList");
      print(artistList.length);
      print("artistList");
      // Fluttertoast.showToast(
      //     msg: "message1111111",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

    }else{
      Navigator.pop(context);
      print('else==============');
      // Fluttertoast.showToast(
      //     msg: "message222222222222",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
    return Artist_model.fromJson(json.decode(response.body));
  }
  Future<Fevourite_Artist> favourite_artist() async {


    for(int i =0;i<selectedList!.length;i++){
      if(i==0){

        id_=selectedList![i].toString()+",";
      }else{
        id_=id_!+selectedList![i].toString()+",";

      }


    }
    print("id_.toString()");
    print(id_.toString().substring(0,id_.toString().length-1));
    print("id_.toString()");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // tokanget = prefs.getString('login_user_token');
    // tokanget = tokanget.replaceAll('"', '');
    // tokanget = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoxfSwiaWF0IjoxNjYyOTc4MTIxfQ.UkcOwRRiVCja2dYLQyIPMOL05qOPsv-VWx5fU0gbUVg";
    // print("CLICKED 123Artist_model =="+tokanget);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (_connectionStatus != null) {
      print("CLICKED _connectionStatus ==");

      // Internet Present Case
      showLoaderDialog(context);
    }else{
      print("CLICKED _connectionStatuselse ==");

      Fluttertoast.showToast(
          msg: "Please check your Internet connection!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    print(BASE_URL+allartist);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('user_id');
    // No-Internet Case
    var response = await http.post(Uri.parse(BASE_URL+addFavouriteArtistapi),body: toMap(),headers: {'Authorization': 'Bearer $tokanget',},);
    print(response.body);

    // print(Artist_model.fromJson(json.decode(response.body)).success);
    print(Fevourite_Artist.fromJson(json.decode(response.body)).message);
    print(Fevourite_Artist.fromJson(json.decode(response.body)).status);
    status = (Fevourite_Artist.fromJson(json.decode(response.body)).status);
    message = (Fevourite_Artist.fromJson(json.decode(response.body)).message);

    // var iddd=Fevourite_Artist.fromJson(json.decode(response.body)).favartist[0].artistId;

    if(status==200){
      Navigator.pop(context);

      Get.off(BottomBar());
      // setState(() {
      //   artistList!.clear();
      //   artistList!.addAll(Artist_model.fromJson(json.decode(response.body)).artist!);
      // });
      print("artistList");
      print(artistList!.length);
      print("artistList");
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);

    }else{
      Navigator.pop(context);
      print('else==============');
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return Fevourite_Artist.fromJson(json.decode(response.body));
  }
  Map toMap() {
    var map = new Map<String, dynamic>();

    map["user_id"] = user_id.toString();
    // map["artist_id"] = artist_id.toString();
    map["artist_id"] = id_.toString().substring(0,id_.toString().length-1).toString();



    print("user_id ====");
    print(user_id.toString());
    print("artist_id ====");
    print(id_.toString().substring(0,id_.toString().length-1).toString());

    return map;
  }

  Future<Artist_model> artist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokanget = prefs.getString('login_user_token');
    print("CLICKED 123Artist_model =="+tokanget);

    tokanget = tokanget.replaceAll('"', '');
    // tokanget = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoxfSwiaWF0IjoxNjYyOTc4MTIxfQ.UkcOwRRiVCja2dYLQyIPMOL05qOPsv-VWx5fU0gbUVg";
    print("CLICKED 123Artist_model =="+tokanget);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (_connectionStatus != null) {
      print("CLICKED _connectionStatus ==");

      // Internet Present Case
      showLoaderDialog(context);
    }else{
      print("CLICKED _connectionStatuselse ==");

      Fluttertoast.showToast(
          msg: "Please check your Internet connection!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    print(BASE_URL+allartist);

    // No-Internet Case
    var response = await http.post(Uri.parse(BASE_URL+allartist),headers: {'Authorization': 'Bearer $tokanget',},body: toMap1());
    print(response.body);

    // print(Artist_model.fromJson(json.decode(response.body)).success);
    print(Artist_model.fromJson(json.decode(response.body)).message);
    print(Artist_model.fromJson(json.decode(response.body)).status);
    status = (Artist_model.fromJson(json.decode(response.body)).status);
    message = (Artist_model.fromJson(json.decode(response.body)).message);

    if(status==200){
      Navigator.pop(context);
      setState(() {
        artistList.clear();
        artistList.addAll(Artist_model.fromJson(json.decode(response.body)).artist!);
        artist_id=Artist_model.fromJson(json.decode(response.body)).artist![0].id.toString();
      });
      print("artistList");
      print(artistList.length);
      print("artistList");
      // Fluttertoast.showToast(
      //     msg: message,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

    }else{
      Navigator.pop(context);
      print('else==============');
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return Artist_model.fromJson(json.decode(response.body));
  }
  @override
  void initState() {
    super.initState();
    future = artist();
    // Verify();
    // artist();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colorappblack,
      body: Container(
        width: deviceWidth(context),
        height: deviceheight(context),
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [

            Container(
              width: deviceWidth(context),
              height: deviceheight(context),
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    sizedboxheight(deviceheight(context,0.05)),
                    Text('Select Your Favourite Artists',  style: TextStyle(
                        fontSize: 22,color: colorWhite,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700
                    )
                    ),
                    Text('Select at least 3 artists',  style: TextStyle(
                        fontSize: 14,color: colorhintcolor,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400
                    )
                    ),
                    FutureBuilder(
                      future: future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return artistList!.isEmpty
                              ? const Center(
                            child: Text('No Data'),
                          )
                              :    Container(
                            width: deviceheight(context),
                            height: deviceheight(context),
                            child: GridView.builder(

                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: artistList!.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15),
                                itemBuilder: (context, index) {
                                  return GridItem(
                                      item: artistList![index],
                                      isSelected: (bool value) {
                                        setState(() {
                                          if (value) {
                                            selectedList!.add(artistList![index].id.toString());
                                          } else {
                                            selectedList!.remove(artistList![index].id.toString());
                                          }
                                        });
                                        print("$index : $value");
                                        print(" $selectedList");
                                      },
                                      key: Key(artistList![index].artistName.toString()));
                                }),
                          );


                        } else {
                          return const Center(
                            // child: CircularProgressIndicator(),
                            child: Text("no data"),
                          );
                        }
                      },
                      // future: postlist(),
                    )



                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 1,
                child: continueBtn(context)),
          ],
        ),
      ),
    );
  }

  Widget continueBtn(context) {
    return Container(
      alignment: Alignment.center,
      child: Button(
        buttonName: 'CONTINUE',
        btnstyle: textstylesubtitle2(context)!.copyWith(color: colorWhite ,fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),
        btnWidth: deviceWidth(context,0.85),
        btnHeight: 60,
        btnColor: selectedList!.isEmpty || selectedList!.length <3 ?colorgrey: colorbutton,
        onPressed: () {
          if(selectedList!.isEmpty || selectedList!.length < 3){
            Fluttertoast.showToast(
                msg: "Please Select Mininum 3 Artists",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: colorblack,
                textColor: Colors.white,
                fontSize: 16.0);

          }else{
            favourite_artist();
            // Get.to(() => BottomBar());
          }
        },
      ),
    );
  }


}
class Item {
  String imageUrl;
  int rank;

  Item(this.imageUrl, this.rank);
}