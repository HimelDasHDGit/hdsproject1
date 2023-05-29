import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';

import '../../category_screen/category_details.dart';

Widget featuredButton({String? title,icon}){
  return SizedBox(
    width: 250,
    child: Row(
      children: [
        Image.asset(icon,width: 60,height: 30,fit: BoxFit.fill,),
        10.widthBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
    ).box.width(200).margin(EdgeInsets.symmetric(
      horizontal: 4,
    )).white.padding(EdgeInsets.all(4)).outerShadowSm.roundedSM.make().onTap(() {
      Get.to(()=> CategoryDetails(title: title,));
    }),
  );
}