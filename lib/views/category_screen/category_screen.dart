import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/consts/lists.dart';
import 'package:hdsproject1/widgets_common/bg_widget.dart';

import 'category_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200,
                  crossAxisCount: 3,
              ),
              itemBuilder: (context,index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(categoryImages[index],height: 120,width: 200, fit: BoxFit.cover,),
                    10.heightBox,
                    Center(child: "${categoryList[index]}".text.fontFamily(semibold).align(TextAlign.center).color(darkFontGrey).make()),
                    10.heightBox,
                    Center(child: "৳6,00,000".text.color(redColor).fontFamily(bold).size(16).align(TextAlign.center).make()),
                  ],
                ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                  Get.to(()=> CategoryDetails(title: categoryList[index],));
                });
              },
          ),
        ),
      ),
    );
  }
}