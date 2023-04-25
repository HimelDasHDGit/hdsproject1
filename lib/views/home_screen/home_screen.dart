import 'package:hdsproject1/consts/consts.dart';

import '../../consts/lists.dart';
import '../../widgets_common/homebuttons.dart';
import 'components/featured_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      padding: EdgeInsets.all(12),
      child: SafeArea(
          child: Column(
            children: [
           Container(
            height: 60,
            alignment: Alignment.center,
            color: lightGrey,
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                disabledBorder: InputBorder.none,
                fillColor: whiteColor,
                hintText: searchAnything,
                hintStyle: TextStyle(
                  color: textfieldGrey,
                ),
                suffixIcon: Icon(Icons.search,),
              ),
            ),
          ),
           10.heightBox,
            Expanded(
              child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                      margin(EdgeInsets.symmetric(horizontal: 8,),)
                          .make();
                    },
                  ),
                  10.heightBox,
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
                  10.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: secondsliderlist.length,
                    itemBuilder: (context,index){
                      return Image.asset(secondsliderlist[index],fit: BoxFit.cover,).box
                          .rounded.clip(Clip.antiAlias).
                      margin(EdgeInsets.symmetric(horizontal: 8,),)
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
                    child: Row(
                      children: List.generate(3, (index) => Column(
                        children: [
                          featuredButton(),
                          10.heightBox,
                          featuredButton(),
                        ],
                      )).toList(),
                    ),
                  ),
                ],
              ),
          ),
            ),
        ],
      )),
    );
  }
}
