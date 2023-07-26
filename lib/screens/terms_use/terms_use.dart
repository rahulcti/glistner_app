import 'package:flutter/material.dart';

import '../../common/appbar/appbarpage.dart';
import '../../common/styles/const.dart';

class TermsUse extends StatelessWidget {
  const TermsUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorappblack,
      appBar: appbartitlebackbtn(context, 'Terms Of Use'),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Some Title',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,fontSize: 16,height: 1.5)),
              sizedboxheight(10.0),
              Text('Lorem Ipsum is simply dummy text of the printing and typesetting '
                  'industry. Lorem Ipsum has been the industry\'s '
                  'standard dummy text ever since the 1500s, when '
                  'an unknown printer took a galley of type and scrambled'
                  ' it to make a type specimen book. It has survived not'
                  ' only five centuries, but also the leap into electronic\n'
                  'Typesetting, remaining essentially unchanged. It was '
                  'popularised in the 1960s with the release of Letraset '
                  'sheets containing including versions of Lorem Ipsum.'
                  ' Typesetting, remaining essentially unchanged. It was '
                  'popularised in the 1960s with the release of Letraset '
                  'sheets containing including versions of Lorem Ipsum.'
                  ,style: TextStyle(color: colorsmaoletext  ,fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,fontSize: 12,height: 1.5)),

              sizedboxheight(10.0),
              Text('Some Title',style: TextStyle(color: colorWhite  ,fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,fontSize: 16,height: 1.5)),
              sizedboxheight(10.0),
              Text('Lorem Ipsum is simply dummy text of the printing and typesetting '
                  'industry. Lorem Ipsum has been the industry\'s '
                  'standard dummy text ever since the 1500s, when '
                  'an unknown printer took a galley of type and scrambled'
                  ' it to make a type specimen book. It has survived not'
                  ' only five centuries, but also the leap into electronic\n'
                  'Typesetting, remaining essentially unchanged. It was '
                  'popularised in the 1960s with the release of Letraset '
                  'sheets containing including versions of Lorem Ipsum.'
                  ' Typesetting, remaining essentially unchanged. It was '
                  'popularised in the 1960s with the release of Letraset '
                  'sheets containing including versions of Lorem Ipsum.'
                  ,style: TextStyle(color: colorsmaoletext  ,fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,fontSize: 12,height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }
}
