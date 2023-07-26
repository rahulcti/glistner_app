

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glistener/common/styles/const.dart';
import 'package:glistener/modal/Artist_model.dart';

import 'choose_instrument.dart';

class GridItem extends StatefulWidget {
  final Key? key;
  final Artist? item;
  final ValueChanged<bool>? isSelected;

  GridItem({this.item,  this.isSelected,  this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected!(isSelected);
        });
      },
      child: Container(
        height: 300,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // height: 200,
                  child: CircleAvatar(
                    radius:deviceheight(context,0.044),
                    backgroundColor: colorgrey,
                    backgroundImage: NetworkImage("http://44.197.223.72/assets/artist/"+widget.item!.image.toString()),
                    // child: Image.asset(
                    //   widget.item!.imageUrl,
                    //   //color: Colors.grey.withOpacity(isSelected ? 0.9 : 0),
                    // ),
                  ),
                ),

                Container(
                  height: 30,
                  child: Text(widget.item!.artistName.toString(),style: TextStyle(
                      fontSize: 10,color: colorWhite,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400
                  )),
                )
              ],
            ),
            isSelected? DottedBorder(
              dashPattern:  [5,5,5,5],
              color: colorWhite,
              borderType: BorderType.Circle,
              child: CircleAvatar(
                radius:deviceheight(context,0.042),
                backgroundColor: colorgrey,
                backgroundImage: NetworkImage("http://44.197.223.72/assets/artist/"+widget.item!.image.toString()),
                // child: Image.asset(
                //   widget.item!.imageUrl,
                //   //color: Colors.grey.withOpacity(isSelected ? 0.9 : 0),
                // ),
              ),
            ):Container(),
            Positioned(
                right: 25,
                child:  isSelected? CircleAvatar(radius: 10,backgroundColor: colorWhite,
                    child: SvgPicture.asset('assets/new/satricon.svg',fit: BoxFit.fill,)):Container())

          ],
        ),
      ),
    );
  }
}