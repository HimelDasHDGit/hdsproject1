import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hdsproject1/consts/colors.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/consts/images.dart';
import 'package:hdsproject1/widgets_common/app_logo_widget.dart';

import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  changeScreen(){

    Future.delayed(Duration(seconds: 3),(){Get.to(()=> LoginScreen());});

  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
                child: Image.asset(icSplashBg,width: 300,),
            ),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(30).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}