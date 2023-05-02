import 'dart:io';
import 'package:get/get.dart';
import 'package:hdsproject1/consts/consts.dart';

import '../../controllers/profile_controller.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/button.dart';
import '../../widgets_common/custom_textfield.dart';

class EditprofileScreen extends StatelessWidget {
  final dynamic data;
   const EditprofileScreen({Key? key, this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    var controller =Get.find<ProfileController>();
    // controller.nameController.text = data['name'];
    // controller.passwordController.text = data['password'];


    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(()=>SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [


              data['imageUrl'] == "" && controller.profileImagePath.isEmpty?
              Image.asset(imgProfile2,width: 100,fit: BoxFit.cover,).
              box.roundedFull.clip(Clip.antiAlias).make():

              data['imageUrl'] != "" && controller.profileImagePath.isEmpty?
                  Image.network(data['imageUrl'],width: 100,height: 100,
                    fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():

              Image.file(
              File(controller.profileImagePath.value,), width: 100, height: 100,
                fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),


            10.heightBox,
            button(color: redColor,onPress: (){
              controller.changeImage(context);
            },textColor: whiteColor,title: "Change"),
            const Divider(),
            20.heightBox,
            customTextField(hint: nameHint,title: name,isPass: false,controller: controller.nameController),
            10.heightBox,
            customTextField(hint: passwordHint,title: oldpass,isPass: true,controller: controller.oldpasswordController),
            10.heightBox,
            customTextField(hint: passwordHint,title: newpass,isPass: true,controller: controller.newpasswordController),
                20.heightBox,
                controller.isLoading.value? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ):SizedBox(
                  width: context.screenWidth-60,
                    child: button(
                        color: redColor,
                        onPress: ()async{

                          controller.isLoading(true);
                          //if image is not selected
                          if (controller.profileImagePath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          }  else{
                            controller.profileImageLink = data['imageUrl'];
                          }
                          //if old pass matches database
                          if (data['password'] == controller.oldpasswordController.text) {

                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldpasswordController.text,
                              newpassword: controller.newpasswordController.text,
                            );

                            await controller.updateProfile(
                              imageUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newpasswordController.text,
                            );
                            VxToast.show(context, msg: "Updated");
                          } else {
                            VxToast.show(context, msg: "Wrong old password");
                            controller.isLoading(false);
                          }
                    },
                        textColor: whiteColor,title: "Save"),
                ),
              ],
            ).box.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50,left: 12,right: 12)).rounded.white.make(),
        ),
        ),
      ),
    );
  }
}
