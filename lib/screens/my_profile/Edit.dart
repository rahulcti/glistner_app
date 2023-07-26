import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glistener/common/styles/const.dart';
import 'package:glistener/screens/my_profile/my_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/formtextfield/validations_field.dart';


import 'package:http/http.dart'as http;

import '../../common/appbar/appbarpage.dart';
import '../../common/commonwidgets/button.dart';
import '../../common/formtextfield/mytextfield.dart';
import '../../modal/MyProfile.dart';


class Edit extends StatefulWidget {


  const Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {


  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  var firstname,lastname,mobile,email;



  TextEditingController txt_firstname = TextEditingController();
  TextEditingController txt_lastname = TextEditingController();
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_mobile = TextEditingController();
  String?   user_id = "";
  var status,message,data;


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? myimage;


  Future? _future;
  String? _validatemobile = null;

  _imgFromGallery() async {
    final XFile? image = (await _picker.pickImage(source: ImageSource.gallery,imageQuality: 85)) ;
    if(image != null)
    {
      setState(()  {
        _image = File(image.path);
        print(_image.toString());
        testCompressFile(_image!);
      });
    }
  }

  _imgFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera,imageQuality: 85);
    if(photo != null){
      setState(()  {
        _image = File(photo.path);
        print(_image.toString());
        testCompressFile(_image!);
      });



    }
  }


  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    print('??????????????');
    print(file.lengthSync());
    print(result!.length);
    return result;
  }

  @override
  void initState() {
    super.initState();
    _future=myprofile();
    setState(() {
    });
  }


  @override
  void dispose() {
    _connectivitySubscription?.cancel();
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
  _willPopCallback() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => MyProfile()));
  }
  void uploadFileToServerInfluencer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id=prefs.getString('user_id');
      print('user_id=============='+user_id!);
    });
    print("CLICKED 123 ==");

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (_connectionStatus != null) {
      // Internet Present Case
      showLoaderDialog(context);
    } else {
      Fluttertoast.showToast(
          msg: "Please check your Internet connection!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }


    var request =  http.MultipartRequest("POST", Uri.parse(BASE_URL+editProfileapi));




    request.fields['firstname'] = txt_firstname.text.toString();
    request.fields['lastname'] = txt_lastname.text.toString();
    request.fields['phone'] = txt_mobile.text.toString();
    request.fields['email'] = txt_email.text.toString();
    request.fields['user_id'] = user_id.toString();




    if(_image==null){
      request.fields['file'] = "";
    }else{
      // request.fields['file'] = _image!.path.toString();
      //request.files.add(await http.MultipartFile.fromPath('profile_image', _image!.path));
      request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
    }
    print("??????????????${request.fields.toString()}");
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) async {
        try {
          Navigator.pop(context);

          print("response.statusCod");
          print(onValue.body);
          _future=myprofile();

         //  SharedPreferences prefs = await SharedPreferences.getInstance();
         //  // user_id=prefs.getString('user_id');
         // var pp= prefs.setString("profileimg","${BASE_URL_img_upload}${myimage}");

          // print("dddddddddddddddddddddddddddddd${pp}");


          _willPopCallback();
          Fluttertoast.showToast(
              msg: "update user successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0

          );


        } catch (e) {

          Fluttertoast.showToast(
              msg: "Something went wrong....",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: const Color(0xffC83760),
              textColor: Colors.white,
              fontSize: 16.0);
          // handle exeption
        }
      });
    });
  }

  // void uploadFileToServerInfluencer() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     user_id=prefs.getString('user_id');
  //     print('user_id=============='+user_id!);
  //   });
  //   print("CLICKED 123 ==");
  //
  //   initConnectivity();
  //   _connectivitySubscription =
  //       _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  //   if (_connectionStatus != null) {
  //     // Internet Present Case
  //     showLoaderDialog(context);
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Please check your Internet connection!!!!",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  //
  //
  //   var request =  http.MultipartRequest("POST", Uri.parse(BASE_URL+editProfileapi));
  //
  //
  //
  //
  //   request.fields['firstname'] = txt_firstname.text.toString();
  //   request.fields['lastname'] = txt_lastname.text.toString();
  //   request.fields['phone'] = txt_mobile.text.toString();
  //   request.fields['email'] = txt_email.text.toString();
  //   request.fields['user_id'] = user_id.toString();
  //
  //
  //
  //
  //   if(_image==null){
  //     request.fields['file'] = "";
  //   }else{
  //     // request.fields['file'] = _image!.path.toString();
  //     //request.files.add(await http.MultipartFile.fromPath('profile_image', _image!.path));
  //     request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
  //   }
  //   print("??????????????${request.fields.toString()}");
  //   request.send().then((response) {
  //     http.Response.fromStream(response).then((onValue) {
  //       try {
  //         Navigator.pop(context);
  //
  //         print("response.statusCod");
  //         print(onValue.body);
  //         // _future=myprofile();
  //
  //         Fluttertoast.showToast(
  //             msg: "Your Profile is Successfully Updated....!!!",
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             backgroundColor: Colors.black,
  //             textColor: Colors.white,
  //             fontSize: 16.0
  //
  //         );
  //
  //
  //       } catch (e) {
  //
  //         Fluttertoast.showToast(
  //             msg: "Something went wrong....",
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             backgroundColor: const Color(0xffC83760),
  //             textColor: Colors.white,
  //             fontSize: 16.0);
  //         // handle exeption
  //       }
  //     });
  //   });
  // }


  Future<MyProfile_Model> myprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      user_id=prefs.getString('user_id');
      print('user_id=============='+user_id!);
    });
    print("CLICKED 123 ==");
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (_connectionStatus != null) {
      // Internet Present Case
    } else {
      Fluttertoast.showToast(
          msg: "Please check your Internet connection!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    var response = await http.post(Uri.parse(BASE_URL+userProfileapi), body: toMap());
    data=response.body;
    print(data);
    status = (MyProfile_Model.fromJson(json.decode(response.body)).status);
    message = (MyProfile_Model.fromJson(json.decode(response.body)).message);

    if (status == 200) {
      // alllist.clear();
      // alllist.addAll(userInfo.fromJson(json.decode(response.body)).userinfo!);
      setState(() {
        setState((){
          firstname = MyProfile_Model.fromJson(json.decode(response.body)).data?.firstname;
          lastname = MyProfile_Model.fromJson(json.decode(response.body)).data?.lastname;
          mobile = MyProfile_Model.fromJson(json.decode(response.body)).data?.phone;
          email = MyProfile_Model.fromJson(json.decode(response.body)).data?.email;


          txt_firstname.text=firstname.toString();
          txt_lastname.text=lastname.toString();
          txt_mobile.text=mobile.toString();
          txt_email.text=email.toString();
          myimage= MyProfile_Model.fromJson(json.decode(response.body)).data?.image;
          print("your img is here"+myimage!);

          // email="";

        });
        // print(alllist.toString());
        // Navigator.pop(context);

        // txt_name.text = alllist[0].firstName!;
        // txt_mobile.text = alllist[0].mobile!;
        // txt_email.text = alllist[0].email!;
        // intrest.text = alllist[0].interest!;
        // txt_country.text = alllist[0].country!;
        // txt_examdate.text = alllist[0].examDate!;
        // txt_examinterest.text = alllist[0].examInterest!;
        // txt_profession.text = alllist[0].aspiredProfession!;
        // txt_region.text = alllist[0].region!;
        // txt_school.text = alllist[0].school!;
        // txt_university.text = alllist[0].university!;
        // txt_purpose.text = alllist[0].purposeExam!;
        //
        // txt_subjectinterest.text = alllist[0].subjectInterest!;
        // txt_school.text = alllist[0].school!;
        // // dropdownvalue = alllist[0].ageGroup!;
        // txt_examinterest.text = alllist[0].examInterest!;
        // txt_interest.text = alllist[0].examInterest!;
        // txt_region.text = alllist[0].region!;
        // txt_agegroup.text = alllist[0].ageGroup!;
        //
        // // request.fields['interest'] = txt_interest.text.toString();
        // myimage=alllist[0].image;

        print("txt_mobile.text"+txt_mobile.text.toString());


      });

    } else {
      print('else==============');
      Fluttertoast.showToast(
          msg: "message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return MyProfile_Model.fromJson(json.decode(response.body));
  }



  Map toMap() {
    var map = new Map<String, dynamic>();
    map["user_id"] = user_id.toString();
    print("email ====");
    // print(txt_email.text.toString());
    return map;
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return
        Scaffold(
          backgroundColor: colorappblack,

          appBar: appbartitlebackbtn(context, 'Edit Profile'),
          body: Container(
            height: deviceheight(context),
            width: deviceWidth(context),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: colorlightblack,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          sizedboxheight(deviceheight(context,0.05)),

                          GestureDetector(onTap: () {

                            _showPicker(context);
                          },
                            child: _image==null?
                            Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.topCenter,
                            // margin: EdgeInsets.only(top: 60),
                            child:
                            myimage == "null" || myimage == null?
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.blueGrey,

                                  // backgroundImage:AssetImage("assets/icons/image.png"),

                                  // child: Image.network("${BASE_URL}profile/${myimage}",width: 150,height: 150,
                                  // )
                                ),
                                CircleAvatar(
                                    radius: 60,
                                    // backgroundImage:NetworkImage("${BASE_URL}assets/uploads/${myimage}"),
                                    // backgroundColor: Colors.black.withOpacity(0.45),
                                    child: Center(child: Image.asset("assets/shadowimg.png",width: 25.5,height: 25.5,))

                                  // child: Image.network("${BASE_URL}profile/${myimage}",width: 150,height: 150,
                                  // )
                                ),
                              ],
                              // child: Image.asset("assets/person.png",width: 150,height: 150,)
                            )
                                :
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor:Colors.blueGrey,
                                  // backgroundImage:NetworkImage("${BASE_URL}assets/uploads/${myimage}"),
                                  backgroundImage:NetworkImage("${BASE_URL_img_upload}${myimage}"),

                                  // child: Image.network("${BASE_URL}profile/${myimage}",width: 150,height: 150,
                                  // )
                                ),
                                CircleAvatar(
                                    radius: 60,
                                    // backgroundImage:NetworkImage("${BASE_URL}profile/${myimage}"),
                                    backgroundColor: Colors.black.withOpacity(0.45),
                                    child: Center(child: Image.asset("assets/shadowimg.png",width: 25.5,height: 25.5,))

                                  // child: Image.network("${BASE_URL}profile/${myimage}",width: 150,height: 150,
                                  // )
                                ),

                              ],
                            ),



                          ):
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.topCenter,
                            // margin: EdgeInsets.only(top: 60),

                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor:Colors.blueGrey,
                                  backgroundImage:FileImage(_image!),

                                  // child: Image.network("${BASE_URL}profile/${myimage}",width: 150,height: 150,
                                  // )
                                ),
                                CircleAvatar(
                                    radius: 60,

                                    // backgroundImage:NetworkImage("${BASE_URL}profile/${myimage}"),
                                    backgroundColor: Colors.black.withOpacity(0.45),
                                    child: Center(child: Image.asset("assets/shadowimg.png",width: 25.5,height: 25.5,))

                                  // child: Image.network("${BASE_URL}profile/${myimage}",width: 150,height: 150,
                                  // )
                                ),
                              ],
                            ),



                            // child: Image.file(_image!,width: 150,height: 150,),





                          ),),
                          // CircleAvatar(
                          //   radius: 70,
                          //   backgroundColor: colorgrey,
                          //   backgroundImage: AssetImage('assets/icons/image.png'),
                          //   child: CircleAvatar(
                          //     radius: 70,
                          //     backgroundColor: Colors.black38,
                          //     child: SvgPicture.asset('assets/icons/photo.svg'),
                          //
                          //   ),
                          // ),
                          sizedboxheight(40.0),
                          Form(
                              key: formKey,
                              child: Column(
                            children: [
                              firstname1(),
                              sizedboxheight(20.0),
                              lastname1(),
                              sizedboxheight(20.0),
                              email1(),
                              sizedboxheight(20.0),
                              mobile_number1(),
                            ],
                          ))
                       
                        ],
                      ),
                    ),
                  ),


                  sizedboxheight(50.0),
                  updateBtn(context),
                ],
              ),
            ),
          ),

        );


  }

  Widget updateBtn(context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Button(
        buttonName: 'UPDATE PROFILE',
        btnstyle: textstylesubtitle2(context)!.copyWith(color: colorWhite ,fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),
        btnWidth: deviceWidth(context),
        btnHeight: 60,
        btnColor: colorbutton,
        onPressed: () {
          //Get.to(() => Reset_Pass());

          if(formKey.currentState!.validate()){
            uploadFileToServerInfluencer();

          }

            // else{
            //   Fluttertoast.showToast(
            //       msg: "Please Match Password",
            //       toastLength: Toast.LENGTH_SHORT,
            //       gravity: ToastGravity.BOTTOM,
            //       backgroundColor: Colors.black,
            //       textColor: Colors.white,
            //       fontSize: 16.0);
            // }


        },
      ),
    );
  }



  Widget firstname1() {
    return AllInputDesign(
      controller: txt_firstname,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'First Name',
      // controller: txt_firstname,
      textInputAction: TextInputAction.next,
      prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          child: SvgPicture.asset(
            'assets/icons/profile.svg',
            height: 0,
            width: 0,
          )
        // child: Icon(Icons.person_outline_rounded,size: 25,color: colorgrey,),
      ),
      keyBoardType: TextInputType.text,
      validatorFieldValue: 'name',
      validator: validateName,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'name is Required.';
      //   }
      // },
    );
  }
  Widget lastname1() {
    return AllInputDesign(
      controller: txt_lastname,

      // inputHeaderName: 'User Name',
      // key: Key("email1"),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'Last Name',
      //controller: txt_lastname,
      textInputAction: TextInputAction.next,

      prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          child: SvgPicture.asset(
            'assets/icons/profile.svg',
            height: 0,
            width: 0,
          )

        // child: Icon(Icons.person_outline_rounded,size: 25,color: colorgrey,),
      ),
      keyBoardType: TextInputType.text,
      validatorFieldValue: 'lastname',
      validator: validateName,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'lastname is Required.';
      //   }
      // },
    );
  }
  Widget email1() {
    return AllInputDesign(
      controller: txt_email,

      // inputHeaderName: 'User Name',
      // key: Key("email1"),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'Email',
      //controller: txt_email,
      autofillHints: [AutofillHints.email],
      textInputAction: TextInputAction.next,

      prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          child: SvgPicture.asset(
            'assets/icons/mail.svg',
            height: 0,
            width: 0,
          )

        // child: Icon(Icons.person_outline_rounded,size: 25,color: colorgrey,),
      ),
      keyBoardType: TextInputType.emailAddress,
      validatorFieldValue: 'email',
      validator: validateEmailField,

      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Email is Required.';
      //   }
      // },
    );
  }
  Widget mobile_number1() {
    return AllInputDesign(
      controller: txt_mobile,

      // inputHeaderName: 'User Name',
      // key: Key("email1"),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: 'Phone',
      // controller: txt_phone,
      textInputAction: TextInputAction.done,

      prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          child: SvgPicture.asset(
            'assets/icons/phon.svg',
            height: 0,
            width: 0,
          )

        // child: Icon(Icons.person_outline_rounded,size: 25,color: colorgrey,),
      ),
      keyBoardType: TextInputType.number,
      validatorFieldValue: 'phone',
      validator: validateMobile,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'phone is Required.';
      //   }
      // },
    );
  }
}







