import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/appbar/appbarpage.dart';
import '../../common/commonwidgets/button.dart';
import '../../common/styles/const.dart';
import 'GridItemlist.dart';


class SelectionArtist extends StatefulWidget {
  const SelectionArtist({Key? key}) : super(key: key);

  @override
  State<SelectionArtist> createState() => _SelectionArtistState();
}

class _SelectionArtistState extends State<SelectionArtist> {

  List<Item>? itemList;
  List<Item>? selectedList;

  @override
  void initState() {
    loadList();
    super.initState();
  }

  loadList() {
    itemList = [];
    selectedList = [];
    itemList!.add(Item("assets/icons/image.png", 1));
    itemList!.add(Item("assets/icons/image.png", 2));
    itemList!.add(Item("assets/icons/image.png", 3));
    itemList!.add(Item("assets/icons/image.png", 4));
    itemList!.add(Item("assets/icons/image.png", 5));
    itemList!.add(Item("assets/icons/image.png", 6));
    itemList!.add(Item("assets/icons/image.png", 7));
    itemList!.add(Item("assets/icons/image.png", 8));
    itemList!.add(Item("assets/icons/image.png", 9));
    itemList!.add(Item("assets/icons/image.png", 10));
    itemList!.add(Item("assets/icons/image.png", 11));
    itemList!.add(Item("assets/icons/image.png", 12));
    itemList!.add(Item("assets/icons/image.png", 13));
    itemList!.add(Item("assets/icons/image.png", 14));
    itemList!.add(Item("assets/icons/image.png", 15));
    itemList!.add(Item("assets/icons/image.png", 1));
    itemList!.add(Item("assets/icons/image.png", 2));
    itemList!.add(Item("assets/icons/image.png", 3));
    itemList!.add(Item("assets/icons/image.png", 4));
    itemList!.add(Item("assets/icons/image.png", 5));
    itemList!.add(Item("assets/icons/image.png", 6));
    itemList!.add(Item("assets/icons/image.png", 7));
    itemList!.add(Item("assets/icons/image.png", 8));
    itemList!.add(Item("assets/icons/image.png", 9));
    itemList!.add(Item("assets/icons/image.png", 10));
    itemList!.add(Item("assets/icons/image.png", 11));
    itemList!.add(Item("assets/icons/image.png", 12));
    itemList!.add(Item("assets/icons/image.png", 13));
    itemList!.add(Item("assets/icons/image.png", 14));
    itemList!.add(Item("assets/icons/image.png", 15));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      appBar: appbartitlebackbtn(context, 'Artist Selection'),
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

                    GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: itemList!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return GridItem(
                              item: itemList![index],
                              isSelected: (bool value) {
                                setState(() {
                                  if (value) {
                                    selectedList!.add(itemList![index]);
                                  } else {
                                    selectedList!.remove(itemList![index]);
                                  }
                                });
                                print("$index : $value");
                              },
                              key: Key(itemList![index].rank.toString()));
                        })

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
        buttonName: 'UPDATE',
        btnstyle: textstylesubtitle2(context)!.copyWith(color: colorWhite ,fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),
        btnWidth: deviceWidth(context,0.85),
        btnHeight: 60,
        btnColor: selectedList!.isEmpty?colorgrey: colorbutton,
        onPressed: () {
          if(selectedList!.isNotEmpty){
           // Get.to(() => BottomBar());
          }else{
            Fluttertoast.showToast(
                msg: "Please Select Artists",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: colorblack,
                textColor: Colors.white,
                fontSize: 16.0);
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