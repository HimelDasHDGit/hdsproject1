import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/consts/lists.dart';
import 'package:hdsproject1/services/firestore_services.dart';
import 'package:hdsproject1/views/auth_screen/login_screen.dart';
import 'package:hdsproject1/views/chat_screen/message_screen.dart';
import 'package:hdsproject1/views/orders_screen/orders_screen.dart';
import 'package:hdsproject1/views/wishlist_screen/wishlist_screen.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets_common/bg_widget.dart';
import 'components/details_card.dart';
import 'editprofile_screen.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),
              );
            } else{

              var data = snapshot.data!.docs[0];


             return SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                        child: const Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.edit,color: whiteColor),
                        ).onTap(() {

                          controller.nameController.text = data['name'];

                          Get.to(()=>  EditprofileScreen(
                            data: data,
                          ));

                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [

                            data['imageUrl'] == ""?
                            Image.asset(imgProfile2,width: 100,fit: BoxFit.cover,).
                            box.roundedFull.clip(Clip.antiAlias).make():

                            Image.network(data['imageUrl'],width: 100,height: 100,fit: BoxFit.cover,).
                            box.roundedFull.clip(Clip.antiAlias).make(),


                            10.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}".text.fontFamily(semibold).white.make(),
                                "${data['email']}".text.white.make(),
                              ],
                            )),
                            5.widthBox,
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: whiteColor,
                                ),
                              ),
                              onPressed: ()async{
                                await Get.put(AuthController()).signout(context);
                                Get.offAll(()=> LoginScreen());
                              }, child: logout.text.fontFamily(semibold).white.make(),
                            ),
                          ],
                        ),
                      ),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCard(count: data['cart_count'],title: "Your cart",width: context.screenWidth/3.5),
                          detailsCard(count: data['oredr_count'],title: "Your wishlist",width: context.screenWidth/3.5),
                          detailsCard(count: data['wishlist_count'],title: "Your orders",width: context.screenWidth/3.5),
                        ],
                      ),
                      10.heightBox,
                      ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index){
                          return ListTile(
                            onTap: (){
                              switch(index) {
                                case 0:
                                  Get.to(()=> OrdersScreen());
                                  break;
                                case 1: Get.to(()=> WishlistScreen());
                                break;
                                case 2: Get.to(()=>MessagesScreen());
                                break;
                              }

                            },
                            title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                            leading: Image.asset(profileButtonIcon[index],width: 22,),
                          );
                        },
                        separatorBuilder: (context, index){
                          return const Divider(color: lightGrey,thickness: 2,);
                        },
                        itemCount: profileButtonsList.length,
                      ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make(),
                    ],
                  ),
                ),
              );
            }
            },
        ),
      ),
    );
  }
}