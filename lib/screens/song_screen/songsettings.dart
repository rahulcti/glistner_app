import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../FlutterGuitarTab.dart';
import '../../common/appbar/appbarpage.dart';
import '../../common/commonwidgets/button.dart';
import '../../common/styles/const.dart';

class SongSettings extends StatefulWidget {

  const SongSettings({Key? key}) : super(key: key);

  @override
  State<SongSettings> createState() => _SongSettingsState();
}

class _SongSettingsState extends State<SongSettings> {
  int tempo = 0;
  int _value = 6;
  List chourdname = [
    'Click',
    'drums',
    'Bass',
    'guitar',
    'Keyboard',
    'vocals',
    'solo',
  ];

  String dropdownvalue2 = '0';
 var  items2 =
  [
    for(int i = 0 ; i<1000;i++)
      i.toString()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorscreenbackground,
      appBar: appbartitlebackbtn(context, 'Guitar Settings'),
      body: Container(
        width: deviceWidth(context),
        height: deviceheight(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: deviceheight(context,0.12),
                width: deviceWidth(context),
                padding: EdgeInsets.only(
                  top: deviceheight(context,0.02)
                ),
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                            height: 30,
                            width: 70,
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: colorWhite
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(

                                hint: Text(
                                  'Select ',
                                  style: TextStyle(color: colorWhite ,fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,fontSize: 12),
                                ),
                                icon: SvgPicture.asset('assets/icons/drop_up_down.svg'),
                                items: items2
                                    .map((item2) => DropdownMenuItem<String>(
                                  value: item2.toString(),
                                  child: Text(
                                    item2.toString(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: dropdownvalue2,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue2 = newValue!;
                                  });
                                },

                              ),
                            )),
                        Text('Repeats',style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                            fontWeight: FontWeight.w600,fontSize: 10,height: 1.5))
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        bottamshit();
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: colorWhite
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(tempo.toString(),style: TextStyle(color: colorblacktext  ,fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,fontSize: 12,height: 1.5)),
                                SvgPicture.asset('assets/icons/drop_up_down.svg')
                              ],
                            ),
                          ),
                          Text('Tempo',style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,fontSize: 10,height: 1.5))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: chourdname.length,
                  itemBuilder: (BuildContext context, int index){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(chourdname[index].toString(),style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,fontSize: 14,height: 2)),
                            sizedboxheight(8.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: deviceWidth(context,0.55),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: colorlightblack,
                                          border: Border.all(
                                            color: colorWhite,
                                            width: 1,
                                          )
                                      ),
                                      child: Slider(
                                          value: _value.toDouble(),
                                          min: 1.0,
                                          max: 20.0,
                                          divisions: 20,
                                          activeColor: colorscreenbackground,
                                          inactiveColor: colorscreenbackground,
                                          label: 'Set volume value',
                                          thumbColor: colorWhite,

                                          onChanged: (double newValue) {
                                            setState(() {
                                              _value = newValue.round();
                                            });
                                          },
                                          semanticFormatterCallback: (double newValue) {
                                            return '${newValue.round()} dollars';
                                          }
                                      ),
                                    ),
                                    Container(
                                      width: deviceWidth(context,0.55),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Track Volume',style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w400,fontSize: 10,height: 2)),
                                          Text('30%',style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w400,fontSize: 10,height: 2)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      child: ToggleSwitch(
                                        minWidth: 40.0,
                                        minHeight: 20.0,
                                        fontSize: 12.0,
                                        cornerRadius: 5.0,
                                        initialLabelIndex: 0,
                                        activeBgColor: [colorWhite],
                                        activeFgColor: colorbutton,
                                        inactiveBgColor: colorlightblack,
                                        inactiveFgColor: colorWhite,
                                        totalSwitches: 2,
                                        labels: const ['M', 'S'],
                                        onToggle: (index) {
                                          print('switched to: $index');
                                        },
                                      ),
                                    ),
                                    sizedboxheight(10.0),
                                    SvgPicture.asset('assets/icons/up logo.svg',color: colorbutton,),
                                    sizedboxheight(5.0),
                                    InkWell(
                                      onTap: (){
                                        showAlertDialog( context);
                                      },
                                      child: Text('CHORDS DIAGRAM',style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                                          fontWeight: FontWeight.w600,fontSize: 9,height: 1.5)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: HexColor("#666666"),),
                  ],
                );
              }),
              sizedboxheight(30.0),
              continueBtn(context),
              sizedboxheight(10.0),
            ],
          ),
        )
      ),
    );
  }
  Widget continueBtn(context) {
    return Container(
      alignment: Alignment.center,
      child: Button(
        buttonName: 'SAVE SETTINGS',
        btnstyle: textstylesubtitle2(context)!.copyWith(color: colorWhite ,fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(15.00),
        btnWidth: deviceWidth(context,0.8),
        btnHeight: 60,
        btnColor: colorbutton,
        onPressed: () {
        //  Get.to(() => Choose_Instrument());
        },
      ),
    );
  }
  String dropdownvalue = 'A';
  var items = [
    'A',
    'B',
    'C',
    'D',
    'E',
  ];
  String dropdownvalue1 = 'Moj';
  var items1 = [
    'Moj',
    'B',
    'C',
    'D',
    'E',
  ];

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: colorbutton,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),

      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutterGuitarTab(
              name:'C' ,
              size: 10,
              tab: 'x 3 2 0 1 0',
            ),
          ],
        ),
      ),
      actions: [
        Container(
          width: deviceWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 30,
                  width: 70,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: colorWhite
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(
                        'Select ',
                        style: TextStyle(color: colorWhite ,fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,fontSize: 12),
                      ),
                      icon: SvgPicture.asset('assets/icons/drop_up_down.svg'),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ))
                          .toList(),
                      value: dropdownvalue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },

                    ),
                  )),
              sizedboxwidth(20.0),
              Container(
                  height: 30,
                  width: 70,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: colorWhite
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(
                        'Select ',
                          style: TextStyle(color: colorWhite ,fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,fontSize: 12)
                      ),
                      icon: SvgPicture.asset('assets/icons/drop_up_down.svg'),
                      items: items1
                          .map((item1) => DropdownMenuItem<String>(
                        value: item1,
                        child: Text(
                          item1,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ))
                          .toList(),
                      value: dropdownvalue1,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue1 = newValue!;
                        });
                      },

                    ),
                  )),
            ],
          ),
        ),
      ],
    );

    showDialog(
      context: context,

      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Future bottamshit(){
    return  showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),

      elevation: 10,
      backgroundColor: colorbutton,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 100,
                  width: deviceWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  InkWell(
                  onTap: (){
                    setState((){
                      (context as Element).reassemble();
                      tempo = tempo-1;
                      (context as Element).reassemble();
                    });
                  },
                  child: Container(
                    width: 60,height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                        color: colorWhite
                    ),
                    child: Center(child: Text("- 1")),
                  ),
              ),
              Text(tempo.toString()),
              InkWell(
                  onTap: (){
                    setState((){
                      (context as Element).reassemble();
                      tempo = tempo+1;
                      (context as Element).reassemble();
                    });
                  },
                  child: Container(
                    width: 60,height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colorWhite
                    ),
                    child: Center(child: Text("+ 1")),
                  ),
              ),
            ],
          ),
                );});
          });

  }
}
