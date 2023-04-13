import 'package:hdsproject1/consts/consts.dart';

Widget bgWidget({Widget? child}){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
            imgBackground,
        ),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}