import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/services/firestore_services.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets_common/button.dart';
import '../../widgets_common/loading_indicator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          }  else if (snapshot.data!.docs.isEmpty){
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          } else{

            var data = snapshot.data!.docs;
            controller.calculate(data);

            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                          itemBuilder: (BuildContext context, int index){
                            return ListTile(
                              leading: Image.network("${data[index]['img']}"),
                              title: "${data[index]['title']} -${data[index]['qty']}x".text.fontFamily(semibold).size(16).make(),
                              subtitle: "${data[index]['tprice']}".numCurrency.text.fontFamily(semibold).color(redColor).make(),
                              trailing: Icon(Icons.delete,color: redColor,).onTap(() {
                                FirestoreServices.deleteDocument(data[index].id);
                              }),
                            );
                          }
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price".text.fontFamily(semibold).color(darkFontGrey).make(),
                      Obx(()=> "${controller.totalP.value}".numCurrency.text.fontFamily(semibold).color(redColor).make()),
                    ],
                  ).box.padding(EdgeInsets.all(12)).width(context.screenWidth - 60,).color(lightGolden).roundedSM.make(),
                  10.heightBox,
                  SizedBox(
                    width: context.screenWidth - 60,
                    child: button(
                      color: redColor,
                      onPress: (){},
                      textColor: whiteColor,
                      title: 'Proceed to Shipping',
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