import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hdsproject1/consts/consts.dart';

import '../../services/firestore_services.dart';
import '../../widgets_common/loading_indicator.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Your Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllMessages(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator(),);
            } else if(snapshot.data!.docs.isEmpty){
              return 'No mesages yet!'.text.color(darkFontGrey).makeCentered();
            }else{
              return Container();
            }
          }
      ),
    );
  }
}
