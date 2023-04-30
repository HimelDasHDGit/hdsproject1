import 'package:get/get.dart';
import 'package:hdsproject1/widgets_common/app_logo_widget.dart';

import '../../consts/consts.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/button.dart';
import '../../widgets_common/custom_textfield.dart';
import '../home_screen/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool? isChek = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.06).heightBox,
              applogoWidget(),
              10.heightBox,
              "Welcome to $appname Hut ".text.fontFamily(bold).white.size(18).make(),
              10.heightBox,
              Obx(()=> Column(
                  children: [
                    customTextField(hint: nameHint, title: name,controller: nameController,isPass: false),
                    customTextField(hint: emailHint, title: email,controller: emailController,isPass: false),
                    customTextField(hint: passwordHint, title: password,controller: passwordController,isPass: true),
                    customTextField(hint: passwordHint, title: retypePassword,controller: retypePasswordController,isPass: true),
                    5.heightBox,
                    Row(
                      children: [
                        Checkbox(
                          activeColor: redColor,
                            value: isChek,
                            onChanged: (newValue){
                            setState(() {
                              isChek = newValue;
                            });
                            }
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "I ageree with the ",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                ),
                              ),
                              TextSpan(
                                text: " & ",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: privecyPolicy,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                    5.heightBox,
                    controller.isLoading.value? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ):button(color: isChek == true? redColor:lightGrey,title: signup,
                        textColor: whiteColor,
                        onPress: ()async{
                      if (isChek != false) {
                        controller.isLoading(true);
                        try{
                          await controller.signupMethod(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text,
                          ).then((value) {
                            return controller.storeUserData(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }).then((value)  {
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(()=>Home());
                          });
                        }catch(e){
                          auth.signOut();
                          VxToast.show(context, msg: loggedout.toString());
                          controller.isLoading(false);
                        }
                      }
                        }).
                    box.
                    width(context.screenWidth -50).
                    make(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        alreadyHaveAcc.text.color(fontGrey).make(),
                        login.text.color(redColor).make().onTap(() {
                          Get.back();
                        }),
                      ],
                    ),
                  ],
                )
                    .box.white.rounded.padding(const EdgeInsets.all(16)).
                width(context.screenWidth - 70).shadowSm.make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
