import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/services/firestore_services.dart';
import 'package:hdsproject1/widgets_common/app_logo_widget.dart';

import '../../controllers/product_controller.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/loading_indicator.dart';
import 'item_details.dart';

class CategoryDetails extends StatefulWidget {

  final String title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title){
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategories(title);
    }  else{
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.put<ProductController>(ProductController());
  dynamic productMethod;

  @override
  Widget build(BuildContext context) {




    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: widget.title.text.fontFamily(bold).white.make(),
          actions: [
            SizedBox(
              height: 30,
              width: 55,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: applogoWidget(),
              )
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50,left: 12,right: 12,bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      controller.subcat.length,
                          (index) => "${controller.subcat[index]}".
                      text.align(TextAlign.start).size(12).fontFamily(bold).color(darkFontGrey).makeCentered().
                      box.white.rounded.size(100,80).margin(const EdgeInsets.all(8)).padding(EdgeInsets.all(8)).make().onTap(() {
                        switchCategory("${controller.subcat[index]}");
                        setState(() {});
                          })),
                ),
              ),
              20.widthBox,
              StreamBuilder(
                stream: productMethod,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){

                  if (!snapshot.hasData) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  }  else if(snapshot.data!.docs.isEmpty){
                    return Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: "No Products Found".text.fontFamily(bold).color(darkFontGrey).make(),
                    );
                  } else{

                    var data = snapshot.data!.docs;

                    return Expanded(child: Container(
                      color: Colors.transparent,
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 300,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (context,index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(data[index]['images'][0],width: 250,height: 150, fit: BoxFit.cover,),
                                10.heightBox,
                                "${data[index]['name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                10.heightBox,
                                "${data[index]['price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                              ],
                            ).box.white.roundedSM.
                            outerShadowSm.margin(const EdgeInsets.symmetric(horizontal: 4,vertical: 4)).
                            padding(const EdgeInsets.all(12)).make().onTap(() {
                              controller.checkIfFav(data[index]);
                              Get.to(()=>  ItemDetails(
                                title: "${data[index]['name']}",
                                data: data[index],
                              ));
                            });
                          }
                      ),
                    ));

                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
