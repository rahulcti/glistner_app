import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/appbar/appbarpage.dart';
import '../../common/styles/const.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsState();
}

class _NotificationsState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      appBar: appbartitlebackbtn(context, 'Notifications'),
      body: Container(
        width: deviceWidth(context),
        height: deviceheight(context),
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 8,
            itemBuilder: (BuildContext context, int index)
            {
              return Container(
                width: deviceWidth(context,1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedboxheight(10.0),
                    Container(
                      width: deviceWidth(context,1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/new/notificationlistlogo.png',width: deviceWidth(context,0.1),),
                          Container(
                            width: deviceWidth(context,0.7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hey, you were doing great continue mixing',
                                    style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,fontSize: 12,height: 2),
                                  maxLines: 1,
                                ),
                                Text('About 3 hours ago',
                                  style: TextStyle(color: colorWhite  ,fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w400,fontSize: 10,height: 2),
                                  maxLines: 1,
                                )
                              ],
                            ),
                          ),
                          SvgPicture.asset('assets/icons/more-vertical 5.svg')
                        ],
                      ),
                    ),
                    sizedboxheight(10.0),
                    Divider(
                      color: colorWhite,
                      height: 1,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
