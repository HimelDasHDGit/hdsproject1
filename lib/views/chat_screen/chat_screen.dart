import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/widgets_common/loading_indicator.dart';

import '../../controllers/chats_controller.dart';
import '../../services/firestore_services.dart';
import 'componentd/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(()=> controller.isloading.value? Center(
              child: loadingIndicator(),
            ): Expanded(
                  child: StreamBuilder(
                    stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndicator(),
                        );
                      }  else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: "Send a message...".text.color(darkFontGrey).make(),
                        );
                      } else{
                        return ListView(
                          physics: const BouncingScrollPhysics(),
                          children: snapshot.data!.docs.mapIndexed((currentValue, index) {

                            var data = snapshot.data!.docs[index];

                            return Align(
                              alignment: data['uid'] == currentUser!.uid? Alignment.centerRight:Alignment.centerLeft,
                                child: senderBubble(data),
                            );

                          }).toList(),
                        );
                      }
                    },
                  ),
              ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller.messagecontroller,
                  decoration: const InputDecoration(
                    hintText: "Type a message.",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: lightGreen,
                      ),
                    )
                  ),
                )),
                5.widthBox,
                ElevatedButton(
                    onPressed: (){
                  controller.sendMsg(controller.messagecontroller.text);
                  controller.messagecontroller.clear();
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                    side: BorderSide(
                      color: lightGreen,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                    child: "Send".text.color(lightGreen).make(),
                ).box.roundedSM.height(80).make(),
              ],
            ).box.height(80).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 8)).make(),
          ],
        ),
      ),
    );
  }
}
