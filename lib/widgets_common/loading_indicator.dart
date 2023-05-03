import 'package:hdsproject1/consts/consts.dart';

Widget loadingIndicator(){
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}