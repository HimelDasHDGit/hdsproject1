import 'package:flutter/services.dart';
import 'package:hdsproject1/consts/consts.dart';

import 'button.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit?".text.size(18).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            button(color: redColor,title: 'Yes',onPress: (){
              SystemNavigator.pop();
            },textColor: whiteColor),
            button(color: redColor,title: 'No',onPress: (){
              Navigator.pop(context);
            },textColor: whiteColor),
          ],
        ),
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}