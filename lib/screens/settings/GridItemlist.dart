

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glistener/common/styles/const.dart';

import 'artist_selection.dart';


class GridItem extends StatefulWidget {
  final Key? key;
  final Item? item;
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
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: deviceheight(context,0.056),
                backgroundColor: colorgrey,
                backgroundImage: AssetImage(widget.item!.imageUrl),
                // child: Image.asset(
                //   widget.item!.imageUrl,
                //   //color: Colors.grey.withOpacity(isSelected ? 0.9 : 0),
                // ),
              ),

              Text(widget.item!.rank.toString(),style: TextStyle(
                  fontSize: 10,color: colorWhite,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400
              ))
            ],
          ),
          isSelected? DottedBorder(
            dashPattern:  [5,5,5,5],
            color: colorWhite,
            borderType: BorderType.Circle,
            child: CircleAvatar(
              radius:   deviceheight(context,0.053),
              backgroundColor: colorgrey,
              backgroundImage: AssetImage(widget.item!.imageUrl),
              // child: Image.asset(
              //   widget.item!.imageUrl,
              //   //color: Colors.grey.withOpacity(isSelected ? 0.9 : 0),
              // ),
            ),
          ):Container(),
          Positioned(
              right: 25,
              child:  isSelected? CircleAvatar(radius: 10,backgroundColor: colorWhite,
            child: SvgPicture.asset('assets/new/satricon.svg',fit: BoxFit.fill,),):Container())

        ],
      ),
    );
  }
}