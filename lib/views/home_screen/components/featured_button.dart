import 'package:hdsproject1/consts/consts.dart';

Widget featuredButton({String? title,icon}){
  return Row(
    children: [
      Image.asset(icon,width: 60,height: 30,fit: BoxFit.fill,),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.width(200).margin(EdgeInsets.symmetric(
    horizontal: 4,
  )).white.padding(EdgeInsets.all(4)).outerShadowSm.roundedSM.make();
}