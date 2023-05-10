import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/controllers/home_controller.dart';

class CartController extends GetxController{

  var totalP = 0.obs;

  //text controllers
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController poController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];

  calculate(data){
    totalP.value = 0;
    for(var i = 0; i < data.length; i++){
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index){
    paymentIndex.value = index;
  }

  placeMyOrder({required paymentMethod, required totalAmount})async {

    await getProductDetails();

    await firestore.collection(ordersCollection).doc().set(
      {
        'order_code' : "4545454",
        'order_by' : currentUser!.uid,
        'order_by_name' : Get.find<HomeController>().username,
        'order_by_email' : currentUser!.email,
        'order_by_address' : addressController.text,
        'order_by_state' : stateController.text,
        'order_by_city' : cityController.text,
        'order_by_phone' : phoneController.text,
        'order_by_po' : poController.text,
        'shipping_metrhod' : "Home Delivery",
        'payment_method' : paymentMethod,
        'order_placed' : true,
        'order_confirmed' : false,
        'order_delivered' : false,
        'on_delivery' : false,
        'total_amount' : totalAmount,
        'orders' : FieldValue.arrayUnion(products)
      }
    );
  }

  getProductDetails(){
    products.clear();
    for(var i = 0; i < productSnapshot.length; i++){
      products.add({
        'color' : productSnapshot[i]['color'],
        'img' : productSnapshot[i]['img'],
        'qty' : productSnapshot[i]['qty'],
        'title' : productSnapshot[i]['title'],
      });
    }
  }

}