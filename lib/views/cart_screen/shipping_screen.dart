import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/views/cart_screen/payment_method.dart';
import 'package:hdsproject1/widgets_common/custom_textfield.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets_common/button.dart';

class ShippingScreen extends StatelessWidget {
   ShippingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: button(
          onPress: (){
            if (controller.addressController.text.length>10 || controller.phoneController.text.length.isEqual(10) || controller.poController.text.length.isEqual(4)) {
              Get.to(()=> PaymentMethods());
            }  else{
              VxToast.show(context, msg: "Please fill the form correctly");
            }
          },
          title: "Continue",
          textColor: darkFontGrey,
          color: redColor,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              customTextField(title: "Address",hint: "At least 10 charectors",controller: controller.addressController,isPass: false),
              customTextField(title: "City",hint: "City",controller: controller.cityController,isPass: false),
              customTextField(title: "State",hint: "State",controller: controller.stateController,isPass: false),
              customTextField(title: "Post Office",hint: "0000",controller: controller.poController,isPass: false),
              customTextField(title: "Phone",hint: "01234567890",controller: controller.phoneController,isPass: false),
            ],
          ),
        ),
      ),
    );
  }
}
