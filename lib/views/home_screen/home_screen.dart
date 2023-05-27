import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/services/firestore_services.dart';
import 'package:hdsproject1/views/category_screen/item_details.dart';
import 'package:hdsproject1/widgets_common/loading_indicator.dart';

import '../../consts/lists.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/homebuttons.dart';
import 'components/featured_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Container(
        color: Colors.transparent,
        width: context.screenWidth,
        height: context.screenHeight,
        padding: const EdgeInsets.all(12),
        child: SafeArea(
            child: Column(
              children: [
             Container(
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: lightGrey,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    disabledBorder: InputBorder.none,
                    fillColor: Colors.transparent,
                    hintText: searchAnything,
                    hintStyle: TextStyle(
                      color: textfieldGrey,
                    ),
                    suffixIcon: Icon(Icons.search,color: redColor,),
                  ),
                ),
              ),
            ),
             10.heightBox,
              Expanded(
                child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderlist.length,
                      itemBuilder: (context,index){
                        return Image.asset(sliderlist[index],fit: BoxFit.cover,).box
                            .rounded.clip(Clip.antiAlias).
                        margin(const EdgeInsets.symmetric(horizontal: 8,),)
                            .make();
                      },
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2, (index) => homeButtons(
                        height: context.screenHeight * .15,
                        width: context.screenWidth/2.5,
                        icon: index == 0? icTodaysDeal : icFlashDeal,
                        title: index == 0? todayDeal:flashSale,
                        onPress: (){},
                      ),
                      ),
                    ),
                    20.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondsliderlist.length,
                      itemBuilder: (context,index){
                        return Image.asset(secondsliderlist[index],fit: BoxFit.cover,).box
                            .rounded.clip(Clip.antiAlias).
                        margin(const EdgeInsets.symmetric(horizontal: 8,),)
                            .make();
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3, (index) => homeButtons(
                        height: context.screenHeight * .15,
                        width: context.screenWidth/3.5,
                        icon: index == 0? icTopCategories :index ==  1? icBrands : icTopSeller,
                        title: index == 0? topCategories:index ==  1? brand : topSellers,
                        onPress: (){},
                      ),
                      ),
                    ),
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featureCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make(),
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(3, (index) => Column(
                          children: [
                            featuredButton(icon: featuredImages1[index],title: featuredTitle1[index]),
                            10.heightBox,
                            featuredButton(icon: featuredImages2[index],title: featuredTitle2[index]),
                          ],
                        )).toList(),
                      ),
                    ),
                    20.heightBox,
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: redColor,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white.fontFamily(bold).size(18).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: StreamBuilder(
                              stream: null,
                              builder: (context, snapshot) {
                                return Row(
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
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondsliderlist.length,
                      itemBuilder: (context,index){
                        return Image.asset(secondsliderlist[index],fit: BoxFit.cover,).box
                            .rounded.clip(Clip.antiAlias).
                        margin(const EdgeInsets.symmetric(horizontal: 8,),)
                            .make();
                      },
                    ),
                    20.heightBox,
                    StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
                      if (!snapshot.hasData) {
                        return loadingIndicator();
                      }  else{

                        var allProductsData = snapshot.data!.docs;

                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: allProductsData.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 300,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8
                          ),
                          itemBuilder: (context, index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(allProductsData[index]['images'][0],width: 200,height:200, fit: BoxFit.cover,),
                                const Spacer(),
                                "${allProductsData[index]['name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                10.heightBox,
                                "${allProductsData[index]['price']}".text.color(redColor).fontFamily(bold).size(16).make(),
                              ],
                            ).box.white.roundedSM.
                            margin(const EdgeInsets.symmetric(horizontal: 4)).
                            padding(const EdgeInsets.all(12)).make().onTap(() {
                              Get.to(()=> ItemDetails(title: "${allProductsData[index]['name']}",data: allProductsData[index],));
                            });
                          },
                        );
                      }
                    }),
                  ],
                ),
            ),
              ),
          ],
        )),
      ),
    );
  }
}
