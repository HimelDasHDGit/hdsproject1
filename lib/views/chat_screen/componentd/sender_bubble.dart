import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {

  var t = data['created_on'] == null? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: lightGreen,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
    child: Column(
      children: [
        "${data['msg']}".text.white.size(16).make(),
        10.heightBox,
        time.text.color(whiteColor.withOpacity(0.5)).size(5).make(),
      ],
    ),
  );
}