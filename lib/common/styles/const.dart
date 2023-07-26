// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';





String BASE_URL='http://44.197.223.72:4000/';
String BASE_URL_img_upload='http://44.197.223.72/assets/uploads/';
String BASE_URL_img_home='http://44.197.223.72/assets/';
String loginapi='login';
String signupapi='signup';
String verifyArtistapi='verifyArtist';
String forgetPasswordapi='forgetPassword';
String resetPasswordapi='resetPassword';
String userProfileapi='userProfile';
String editProfileapi='editProfile';
String allartist='allArtist';
String addFavouriteArtistapi='addFavouriteArtist';
String homePageapi='homePage';
String getSongsOfArtistapi='getSongsOfArtist';
String getSongsOfGenreapi='getSongsOfGenre';
String getSongsOfAlbumapi='getSongsOfAlbum';
String getSongsOfMoodapi='getSongsOfMood';



Color colorWhite = Colors.white;


Color colorblack = Colors.black;
Color colorappblack = HexColor("#1C1C1C");
Color colorlightblack = HexColor("#313131");
Color colorintroblack = HexColor("#F5F5F5");
Color colorhintcolor = HexColor("#A1A1A1");
Color colortexthit = HexColor("#BDBDBD");


Color colororeng = HexColor("#FA7238");
Color colornormaltextcolor = HexColor("#B0B0B0");
Color colorsmaoletext = HexColor("#909090");
Color divider = HexColor("#979797");
Color colorscreenbackground = HexColor("#282626");
Color colorblacktext = HexColor("#333333");
Color colortextgrea = HexColor("#8B8B8B");
Color colorbutton = HexColor("#FFC000");
Color colorgrey = Colors.grey;



const double fontsizeheading20 = 20.0;
const double fontsizeheading22 = 22.0;
const double fontsize22 = 22.0;
const double fontsize18 = 18.0;
const double fontsize16 = 16.0;
const double fontsize15 = 15.0;
const double fontsize14 = 14.0;
const double fontsize16fontsize16 = 14.0;
const double fontsize11 = 11.0;

const double padding20 = 20.0;
const double padding15 = 15.0;
const double padding10 = 10.0;
const double padding8 = 8.0;
const double padding5 = 5.0;

FontWeight fontWeight600 = FontWeight.w600;
FontWeight fontWeight700 = FontWeight.w700;
FontWeight fontWeight900 = FontWeight.bold;
FontWeight fontWeight400 = FontWeight.w400;
FontWeight fontWeight500 = FontWeight.w500;
FontWeight fontWeightnormal = FontWeight.normal;


TextStyle? textnormail(context){
  return TextStyle(
    fontSize: 18,color: Colors.white,

  );
}
TextStyle? textwidget(context){
  return TextStyle(
    fontSize: 18,color: HexColor("#1C1C1C"),

  );
}
TextStyle? textbold(context){
  return TextStyle(
      fontSize: 11,color: Colors.black87,
      fontWeight: FontWeight.bold,
  );
}
TextStyle? textheding(context){
  return TextStyle(
    fontSize: 14,color: Colors.black87,
    fontWeight: FontWeight.bold,

  );
}
TextStyle? textstyleHeading1(context) {
  return Theme.of(context).textTheme.headline1;
}

TextStyle? textstyleHeading2(context) {
  return Theme.of(context).textTheme.headline2;
}

TextStyle? textstyleHeading3(context) {
  return Theme.of(context).textTheme.headline3;
}

TextStyle? textstyleHeading6(context) {
  return Theme.of(context).textTheme.headline6;
}

TextStyle? textstylesubtitle2(context) {
  return Theme.of(context).textTheme.subtitle2;
}

TextStyle? textstylesubtitle1(context) {
  return Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.normal);
}

double deviceWidth(context, [double size = 1.0]) {
  return MediaQuery.of(context).size.width * size;
}

double deviceheight(context, [double size = 1.0]) {
  return MediaQuery.of(context).size.height * size;
}

BoxBorder borderCustom() {
  return Border.all(color: colorgrey.withOpacity(0.2));
}

BoxBorder borderCustomlight() {
  return Border.all(color: colorgrey.withOpacity(0.05));
}

Widget sizedboxheight([height = 20.0]) {
  return SizedBox(
    height: height,
  );
}

Widget sizedboxwidth([width = 20.0]) {
  return SizedBox(
    width: width,
  );
}

Widget dividerVertical() {
  return Container(
    width: 1,
    height: double.maxFinite,
    color: Colors.black12,
  );
}

Widget dividerHorizontal(context, width, height) {
  return Center(
    child: Container(
      // width: double.maxFinite,
      width: deviceWidth(context, width),
      decoration: BoxDecoration(
          color: colorgrey, borderRadius: borderRadiuscircular(20.0)),
      height: height,
    ),
  );
}

Widget dividerHorizontalblack(context) {
  return Center(
    child: Container(
      height: 1,
      color: Colors.black26,
    ),
  );
}

Decoration decorationtoprounded() {
  return BoxDecoration(
    color: colorWhite,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    ),
  );
}

BorderRadius borderRadiuscircular(radius) {
  return BorderRadius.circular(radius);
}

boxShadowcontainer() {
  return [
    BoxShadow(
      color: Colors.grey.withOpacity(0.07),
      spreadRadius: 3,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
  ];
}

mediaText(context) {
  return MediaQuery.of(context).copyWith(textScaleFactor: 0.9);
}
