import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/consts/lists.dart';
import 'package:hdsproject1/widgets_common/bg_widget.dart';
import 'package:hdsproject1/widgets_common/button.dart';
import '../../widgets_common/app_logo_widget.dart';
import '../../widgets_common/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  customTextField(hint: emailHint, title: email,),
                  customTextField(hint: passwordHint, title: password,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: (){},
                        child: forgetPass.text.make(),
                    ),
                  ),
                  5.heightBox,
                  button(color: redColor,title: login,textColor: whiteColor,onPress: (){}).
                  box.
                  width(context.screenWidth -50).
                  make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  button(color: lightGolden,title: signup, textColor: redColor,onPress: (){}).
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
                          child: Image.asset(socialIconList[index],width: 30,),
                          radius: 25,
                        ),
                      ),
                  ),
                  ),
                ],
              )
                  .box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
            ],
          ),
        ),
      ),
    );
  }
}
