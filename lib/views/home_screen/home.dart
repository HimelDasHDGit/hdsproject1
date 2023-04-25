import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hdsproject1/consts/consts.dart';

import '../../controllers/home_controller.dart';
import '../cart_screen/cart_screen.dart';
import '../category_screen/category_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'home_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
        icon: Image.asset(icHome,width: 26,),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCategories,width: 26,),
        label: categories,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCart,width: 26,),
        label: cart,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icProfile,width: 26,),
        label: account,
      ),
    ];

    var navBody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(()=> Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
        currentIndex: controller.currentNavIndex.value,
        items: navbarItem,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: redColor,
        selectedLabelStyle: const TextStyle(fontFamily: semibold),
        backgroundColor: whiteColor,
        onTap: (value){
          controller.currentNavIndex.value = value;
        },
      ),),
    );
  }
}
