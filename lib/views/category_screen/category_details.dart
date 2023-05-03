import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/services/firestore_services.dart';

import '../../controllers/product_controller.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/loading_indicator.dart';
import 'item_details.dart';

class CategoryDetails extends StatelessWidget {

  final String title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title) ,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            }  else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "No Products Found".text.color(darkFontGrey).make(),
              );
            } else{

              var data = snapshot.data!.docs;

              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            controller.subcat.length,
                                (index) => "${controller.subcat[index]}".
                            text.size(12).fontFamily(semibold).color(darkFontGrey).makeCentered().
                            box.white.rounded.size(120, 60).margin(const EdgeInsets.symmetric(horizontal: 4)).make()),
                      ),
                    ),
                    20.heightBox,
                    Expanded(child: Container(
                      color: lightGrey,
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (context,index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(data[index]['images'][1],width: 200,height: 150, fit: BoxFit.cover,),
                                10.heightBox,
                                "${data[index]['name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                10.heightBox,
                                "${data[index]['price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                              ],
                            ).box.white.roundedSM.
                            outerShadowSm.margin(const EdgeInsets.symmetric(horizontal: 4,vertical: 4)).
                            padding(const EdgeInsets.all(12)).make().onTap(() {
                              Get.to(()=>  ItemDetails(
                                title: "${data[index]['name']}",
                                data: data[index],
                              ));
                            });
                          }
                      ),
                    )),
                  ],
                ),
              );

            }
          },
        ),
      ),
    );
  }
}
