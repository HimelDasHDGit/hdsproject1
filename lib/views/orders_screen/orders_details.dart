import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/views/orders_screen/components/order_status.dart';
import 'package:intl/intl.dart'as intl;
import 'components/order_place_details.dart';

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order details".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                orderStatus(color:  Vx.green300, icon: Icons.done_outline, title: "Order placed", showDone: data['order_placed'],),
                orderStatus(color: Vx.green500, icon: Icons.thumb_up_outlined, title: "Order confirmed", showDone: data['order_confirmed'],),
                orderStatus(color: Vx.green700, icon: Icons.delivery_dining, title: "On delivery", showDone: data['on_delivery'],),
                orderStatus(color: Vx.green900, icon: Icons.done_all_rounded, title: "Order delivered", showDone: data['order_delivered'],),
                const Divider(color: redColor, thickness: 1,indent: 10,endIndent: 10,),
                10.heightBox,
                Column(
                  children: [
                    orderPlaceddetails(title1: "Order code",title2: "Shipping method",d1: data['order_code'],d2: data['shipping_method'],),
                    orderPlaceddetails(title1: "Order date",title2: "Payment method",d1: intl.DateFormat().add_yMMMMEEEEd().format(data['order_date'].toDate()),d2: data['payment_method'],),
                    orderPlaceddetails(title1: "Payment status",title2: "Delivery status",d1: "Unpaid",d2: "Order placed",),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Shipping Address".text.fontFamily(semibold).make(),
                              "${data['order_by_name']}".text.color(redColor).fontFamily(semibold).make(),
                              "${data['order_by_email']}".text.color(redColor).fontFamily(semibold).make(),
                              "${data['order_by_phone']}".text.color(redColor).fontFamily(semibold).make(),
                              "${data['order_by_address']}".text.color(redColor).fontFamily(semibold).make(),
                              "${data['order_by_po']}".text.color(redColor).fontFamily(semibold).make(),
                              "${data['order_by_city']}".text.color(redColor).fontFamily(semibold).make(),
                              "${data['order_by_state']}".text.color(redColor).fontFamily(semibold).make(),
                            ],
                          ),
                          SizedBox(
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount".text.fontFamily(semibold).make(),
                                "${data['total_amount']}".numCurrency.text.color(Colors.red).fontFamily(bold).make(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).box.outerShadow.white.make(),
                const Divider(color: redColor, thickness: 1,indent: 10,endIndent: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
