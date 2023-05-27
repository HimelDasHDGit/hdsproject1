import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/views/chat_screen/chat_screen.dart';

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
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index){
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: redColor,
                                child: Icon(Icons.person,color: whiteColor,),
                              ),
                              onTap: (){
                                Get.to(()=> const ChatScreen(),arguments: [data[index]['friend_Name'],data[index]['toId']]);
                              },
                              title: "${data[index]['friend_Name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                              subtitle: "${data[index]['last_msg']}".text.make(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }
}
