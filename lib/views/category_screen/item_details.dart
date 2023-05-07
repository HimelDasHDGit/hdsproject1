import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/consts/lists.dart';

import '../../controllers/product_controller.dart';
import '../../widgets_common/button.dart';
import '../chat_screen/chat_screen.dart';

class ItemDetails extends StatelessWidget {

  final String? title;
  final dynamic data;

  const ItemDetails({Key? key, required this.title, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    return WillPopScope(
      onWillPop: () async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: (){
                controller.resetValues();
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.share,)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_outline,)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    //scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        VxSwiper.builder(
                          autoPlay: true,
                            aspectRatio: 9/16,
                            height: 300,
                            viewportFraction: 1.0,
                            pauseAutoPlayOnTouch: const Duration(seconds: 15),
                            autoPlayAnimationDuration: const Duration(seconds: 2),
                            autoPlayCurve: Curves.linear,
                            itemCount: data['images'].length,
                            itemBuilder: (context, index){
                              return Image.network(data['images'][index],width: double.infinity,fit: BoxFit.cover,);
                            }
                        ),
                        10.heightBox,
                        title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                        10.heightBox,
                        VxRating(
                          isSelectable: false,
                          value: double.parse(data['rating']),
                          onRatingUpdate: (value){},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          size: 25,
                          count: 5,
                          maxRating: 5,
                        ),
                        10.heightBox,
                        "${data['price']}".numCurrency.text.fontFamily(bold).color(redColor).size(18).make(),
                        10.heightBox,
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    "Seller".text.white.fontFamily(semibold).make(),
                                    5.heightBox,
                                    "${data['seller']}".text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                                  ],
                                ),
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.message_rounded,color: darkFontGrey,),
                            ).onTap(() {
                              Get.to(()=> ChatScreen(),arguments: [data['seller'],data['vendor_id']]);
                            }),
                          ],
                        ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).
                        color(textfieldGrey).make(),
                        20.heightBox,
                        Obx(()=>Column(
                            children: [
                              //color
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Color".text.color(textfieldGrey).make(),
                                  ),
                                  Row(
                                    children: List.generate(
                                      data['colors'].length,
                                          (index) =>
                                             Stack(
                                               alignment: Alignment.center,
                                               children: [
                                                 VxBox().size(40, 40).roundedFull.color(Color(data['colors'][index]).withOpacity(1.0)).margin(const EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                                                   controller.changeColorIndex(index);
                                                 }),
                                                 Visibility(
                                                   visible: index == controller.colorIndex.value,
                                                     child: const Icon(Icons.done,color: Colors.white,),
                                                 ),
                                               ],
                                             ),
                                    ),
                                  ),
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                              //quantity
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Quantity".text.color(textfieldGrey).make(),
                                  ),
                                  Obx(() => Row(
                                    children: [
                                      IconButton(
                                          onPressed: (){
                                            controller.decreaseQuantity();
                                            controller.calculateTotalprice(int.parse(data['price']));
                                          },
                                          icon: const Icon(Icons.remove)
                                      ),
                                      controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                      IconButton(
                                          onPressed: (){
                                            controller.increaseQuantity(
                                              int.parse(data['quantity'])
                                            );
                                            controller.calculateTotalprice(int.parse(data['price']));
                                          },
                                          icon: const Icon(Icons.add)
                                      ),
                                      10.widthBox,
                                      "${data['quantity']}".text.color(textfieldGrey).make(),
                                    ],
                                  ),),

                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                              //Total
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: "Total".text.color(textfieldGrey).make(),
                                  ),
                                  "${controller.totalprice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),


                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                            ],
                          ).box.white.shadowSm.make(),
                        ),
                        //description
                        10.heightBox,
                        "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                        10.heightBox,
                        "${data['description']}".text.color(darkFontGrey).make(),

                        10.heightBox,
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                          itemDetailButtonList.length,
                            (index) => ListTile(
                            title: itemDetailButtonList[index].text.semiBold.make(),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                          ),
                        ),
                        20.heightBox,
                        productsYouLike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: List.generate(
                              6, (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                                10.heightBox,
                                "Laptop 32GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                                10.heightBox,
                                "৳60000".text.color(redColor).fontFamily(bold).size(16).make(),
                              ],
                            ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4))
                                .roundedSM.padding(const EdgeInsets.all(8)).make(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: button(
                color: redColor,
                onPress: (){
                  controller.addToCard(
                    color: data['colors'][controller.colorIndex.value],
                    title: data['name'],
                    img: data['images'][0],
                    sellername: data['seller'],
                    quantity: controller.quantity.value,
                    tprice: controller.totalprice.value,
                    context: context,
                  );
                  VxToast.show(context, msg: "Added to Cart");
                },
                textColor: whiteColor,
                title: "Add to cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

