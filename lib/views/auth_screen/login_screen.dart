import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/consts/lists.dart';
import 'package:hdsproject1/views/auth_screen/signup_screen.dart';
import 'package:hdsproject1/widgets_common/bg_widget.dart';
import 'package:hdsproject1/widgets_common/button.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets_common/app_logo_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  final  controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Login to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(()=> Column(
                  children: [
                    customTextField(hint: emailHint, title: email,isPass: false,controller: controller.emailController),
                    customTextField(hint: passwordHint, title: password,isPass: true,controller: controller.passwordController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: (){},
                          child: forgetPass.text.make(),
                      ),
                    ),
                    5.heightBox,
                    controller.isLoading.value? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ):button(color: redColor,title: login,textColor: whiteColor,
                        onPress: ()async{
                      controller.isLoading(true);
                      await controller.loginMethod(context: context).then((value){
                        if (value !=null) {
                          VxToast.show(context, msg: loggedin);
                          Get.offAll(()=> const Home());
                        }else{
                          controller.isLoading(false);
                        }
                      });
                    }).
                    box.
                    width(context.screenWidth -50).
                    make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    button(color: lightGolden,title: signup, textColor: redColor,onPress: (){
                      Get.to(()=> const SignUpScreen());
                    }).
                    box.
                    width(context.screenWidth -50).
                    make(),
                    10.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) =>
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(socialIconList[index],width: 30,),
                          ),
                        ),
                    ),
                    ),
                  ],
                )
                    .box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
