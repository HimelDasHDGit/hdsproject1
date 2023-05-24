import 'package:cloud_firestore/cloud_firestore.dart';
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
  var isFav = false.obs;

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

  addToCard({title, img, sellername, color, quantity, tprice, context, venderID}) async{
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'quantity': quantity,
      'price': tprice,
      'added_by': currentUser!.uid,
      'vender_id':venderID
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues(){
    totalprice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToWishlist(docId, context) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'wishlist': FieldValue.arrayUnion([
        currentUser!.uid
      ]),
    }, SetOptions(merge:true));
    isFav(true);
    VxToast.show(context, msg: 'Added to wishlist');
  }

  removeFromWishlist(docId ,context) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'wishlist': FieldValue.arrayRemove([
        currentUser!.uid
      ]),
    }, SetOptions(merge:true));
    isFav(false);
    VxToast.show(context, msg: 'Removed from wishlist');
  }

  checkIfFav(data) async{
    if (data['wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    }  else{
      isFav(false);
    }
  }

}