import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/consts/lists.dart';

import '../../widgets_common/button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
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
                          aspectRatio: 16/9,
                          height: 350,
                          itemCount: 3,
                          itemBuilder: (context, index){
                            return Image.asset(imgP3,width: double.infinity,fit: BoxFit.cover,);
                          }
                      ),
                      10.heightBox,
                      title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,
                      VxRating(
                        onRatingUpdate: (value){},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        size: 25,
                        count: 5,
                        stepInt: true,
                      ),
                      10.heightBox,
                      "৳৬০০০০".text.fontFamily(bold).color(redColor).size(18).make(),
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
                                  "In House Brand".text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                                ],
                              ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.message_rounded,color: darkFontGrey,),
                          ),
                        ],
                      ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).
                      color(textfieldGrey).make(),
                      20.heightBox,
                      Column(
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
                                  3, (index) => VxBox().size(40, 40).roundedFull.color(Vx.randomPrimaryColor)
                                    .margin(const EdgeInsets.symmetric(horizontal: 4)).make(),
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
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: (){},
                                      icon: const Icon(Icons.remove)
                                  ),
                                  "0".text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                  IconButton(
                                      onPressed: (){},
                                      icon: const Icon(Icons.add)
                                  ),
                                  10.widthBox,
                                  "(0 Available)".text.color(textfieldGrey).make(),
                                ],
                              ),


                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          //Total
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total".text.color(textfieldGrey).make(),
                              ),
                              "৳৮০০০০".text.color(redColor).size(16).fontFamily(bold).make(),


                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                      //description
                      10.heightBox,
                      "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,
                      "This is an random item and description here. "
                          "Actual description will appear in shortly...".text.color(darkFontGrey).make(),

                      10.heightBox,
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                        itemDetailButtonList.length,
                          (index) => ListTile(
                          title: "${itemDetailButtonList[index]}".text.semiBold.make(),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                        ),
                      ),
                      20.heightBox,
                      productsYouLike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
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
                          ).box.white.margin(EdgeInsets.symmetric(horizontal: 4))
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
              onPress: (){},
              textColor: whiteColor,
              title: "Add to cart",
            ),
          ),
        ],
      ),
    );
  }
}

