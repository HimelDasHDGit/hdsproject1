import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/services/firestore_services.dart';
import 'package:hdsproject1/widgets_common/bg_widget.dart';
import 'package:hdsproject1/widgets_common/loading_indicator.dart';

import '../category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key, this.title}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.make(),
        ),
        body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshopt){

            if (!snapshopt.hasData) {
              return Center(child: loadingIndicator(),);
            }  else if(snapshopt.data!.docs.isEmpty && snapshopt.data != title) {
              return "No products found".text.color(darkFontGrey).makeCentered();
            } else{

              var data = snapshopt.data!.docs;
              var filtered = data.where((element) => element['name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 300
                  ),
                  children: filtered.mapIndexed((currentValue, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(filtered[index]['images'][0],width: 200,height:200, fit: BoxFit.cover,),
                      const Spacer(),
                      "${filtered[index]['name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                      10.heightBox,
                      "${filtered[index]['price']}".text.color(redColor).fontFamily(bold).size(16).make(),
                    ],
                  ).box.white.roundedSM.
                  margin(const EdgeInsets.symmetric(horizontal: 4)).
                  padding(const EdgeInsets.all(10)).make().onTap(() {
                    Get.to(()=> ItemDetails(title: "${filtered[index]['name']}",data: filtered[index],));
                  })).toList(),
                ),
              );

            }
          },
        ),
      )
    );
  }
}
