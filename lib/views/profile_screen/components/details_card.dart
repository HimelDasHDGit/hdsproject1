import 'package:hdsproject1/consts/consts.dart';

Widget detailsCard({width, String? count, String? title}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(15).make(),
      2.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  ).
  box.white.rounded.width(width).height(60).padding(EdgeInsets.all(4)).make();
}