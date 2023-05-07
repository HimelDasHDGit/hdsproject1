import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/models/category_model.dart';

class ProductController extends GetxController {

  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalprice = 0.obs;

  var subcat = [];

  getSubCategories(title)async{
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory){
      subcat.add(e);
    }
  }

  changeColorIndex(index){
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity){
    if (quantity.value<totalQuantity) {
      quantity.value++;
    }  
  }

  decreaseQuantity(){
    if (quantity.value>0) {
      quantity.value--; 
    }
  }

  calculateTotalprice(price){
    totalprice.value = price * quantity.value;
  }

  addToCard({title, img, sellername, color, quantity, tprice, context}) async{
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': quantity,
      'tprice': tprice,
      'added_by': currentUser!.uid,
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues(){
    totalprice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

}