import 'package:hdsproject1/consts/consts.dart';

Widget orderStatus({icon,color,title,showDone}){
  return ListTile(
    leading: Icon(icon,color: color,).box.border(color: color).padding(EdgeInsets.all(3)).roundedFull.make(),
    title: const Divider(endIndent: 5,indent: 5,thickness: 2,color: Colors.green,),
    trailing: SizedBox(
      height: 100,
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone?Icon(icon,color: redColor,):Container(),
        ],
      ),
    ),
  );
}