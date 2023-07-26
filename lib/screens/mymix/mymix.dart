import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../common/styles/const.dart';


enum Menu { itemOne, itemTwo, itemThree, itemFour }

class MyMix extends StatefulWidget {
  const MyMix({Key? key}) : super(key: key);

  @override
  State<MyMix> createState() => _MyMixState();
}

class _MyMixState extends State<MyMix> {
  bool playposh = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      // body: Container(
      //   padding: EdgeInsets.all(10),
      //   child: ListView.builder(
      //     itemCount: 20,
      //       itemBuilder: (BuildContext context, int index){
      //     return Card(
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10.0),
      //       ),
      //       color: colorlightblack,
      //       child: Container(
      //         padding: EdgeInsets.only(top: 8,bottom: 8),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             sizedboxwidth(0.0),
      //             Container(
      //              width: deviceWidth(context,0.15),
      //               height: 50,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(20),
      //                 image: const DecorationImage(
      //                   image: AssetImage('assets/icons/image.png')
      //                 )
      //               ),
      //             ),
      //
      //             Container(
      //               width: deviceWidth(context,0.5),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text('My Mix one',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
      //               fontWeight: FontWeight.w500,fontSize: 12,height: 1.5)),
      //                   Text('Robert Will | Harry’s House',style: TextStyle(color: HexColor("#909090")  ,fontFamily: 'Poppins',
      //                       fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
      //                   Text('2:45 minutes',style: TextStyle(color: HexColor("#DEDBDB")  ,fontFamily: 'Poppins',
      //                       fontWeight: FontWeight.w400,fontSize: 8,height: 1.5)),
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               width: deviceWidth(context,0.23),
      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                  InkWell(
      //                      onTap: (){
      //                        setState(() {
      //                          playposh = !playposh;
      //                        });
      //                      },
      //                      child: SvgPicture.asset(playposh?'assets/icons/push.svg':"assets/icons/play.svg",height: 25,)),
      //
      //                   popMenus(
      //                     context: context,
      //                     options: [
      //                       {
      //                         "menu": "Delete",
      //                         "menu_id": 1,
      //
      //                       },
      //                       {
      //                         "menu": "Download",
      //                         "menu_id": 2,
      //                       },
      //                     ],
      //                   ),
      //                  // InkWell(
      //                  //    onTap: (){
      //                  //      setState(() {
      //                  //
      //                  //      });
      //                  //    },
      //                  //     child: SvgPicture.asset('assets/icons/more-vertical 5.svg',height: 20,)),
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     );
      //   }),
      // ),
    );
  }
  Widget popMenus({
    List<Map<String, dynamic>>? options,
    BuildContext? context,
  })
  {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: HexColor("#525252"),
      icon: SvgPicture.asset('assets/icons/more-vertical 5.svg',),
      offset: Offset(0, 40,),
      itemBuilder: (BuildContext bc) {
        return options!.map(
              (selectedOption) => PopupMenuItem(
            height: 15.0,
            value: selectedOption,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {

                  },
                  child: Text(
                    selectedOption['menu'] ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: colorWhite,
                      fontFamily: 'Poppins',
                      fontSize: 10
                    ),
                  ),
                ),
                (options.length == (options.indexOf(selectedOption) + 1))? SizedBox(
                  width: 0.0,
                  height: 0.0,
                ) :Divider(thickness: 0.5,color: colorWhite,),

                (options.length == (options.indexOf(selectedOption) + 1))
                    ? SizedBox(
                  width: 0.0,
                  height: 0.0,
                )
                    : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 1.0,
                  ),
                ),

              ],
            ),

          ),
        )
            .toList();
      },
      onSelected: (value) async {},
    );
  }
}