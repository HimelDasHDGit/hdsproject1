import 'package:hdsproject1/consts/consts.dart';

Widget homeButtons({height,width,icon,String? title,onPress,}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image.asset(icon,width: 25,),
    10.heightBox,
    title!.text.fontFamily(semibold).color(darkFontGrey).make(),
  ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}