import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hdsproject1/consts/consts.dart';

import '../../widgets_common/bg_widget.dart';
import 'item_details.dart';

class CategoryDetails extends StatelessWidget {

  final String title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) => "Construction Tools".
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
                    itemCount: 6,
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
                          Image.asset(imgP5,width: 200,height: 150, fit: BoxFit.cover,),
                          "Laptop 32GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                          10.heightBox,
                          "৳60000".text.color(redColor).fontFamily(bold).size(16).make(),
                        ],
                      ).box.white.roundedSM.
                      outerShadowSm.margin(const EdgeInsets.symmetric(horizontal: 4,vertical: 4)).
                      padding(const EdgeInsets.all(12)).make().onTap(() {
                        Get.to(()=> ItemDetails(
                          title: "Title",
                        ));
                      });
                    }
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
