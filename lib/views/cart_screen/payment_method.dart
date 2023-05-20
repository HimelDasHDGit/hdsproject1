import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/consts/lists.dart';
import '../../controllers/cart_controller.dart';
import '../../widgets_common/button.dart';
import '../../widgets_common/loading_indicator.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Obx(()=>
        Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value? Center(
            child: loadingIndicator(),
          ):button(
            onPress: (){
              controller.placeMyOrder(

                paymentMethod: paymentMethodsList[controller.paymentIndex.value],
                totalAmount: controller.totalP.value,

              );
            },
            title: "Place My Order",
            textColor: darkFontGrey,
            color: redColor,
          ),
        ),
        appBar: AppBar(
          title: "Payment Methods".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(()=>Column(
              children: List.generate(paymentMethodsImg.length, (index) {
                return GestureDetector(
                  onTap: (){
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: controller.paymentIndex.value == index ? redColor:Colors.transparent,
                        width: 4,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                  children: [
                      Image.asset(
                        paymentMethodsImg[index],
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                        isAntiAlias: true,
                        colorBlendMode: controller.paymentIndex.value == index? BlendMode.darken:BlendMode.color,
                        color: controller.paymentIndex.value == index? Colors.black.withOpacity(.3):Colors.transparent,
                      ),
                    controller.paymentIndex.value == index? Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        activeColor: redColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          value: true, onChanged: (value){

                      }),
                    ):Container(),
                    Positioned(
                      bottom: 5,
                        right: 10,
                        child: paymentMethodsList[index].text.white.fontFamily(semibold).size(16).make()),
                  ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
