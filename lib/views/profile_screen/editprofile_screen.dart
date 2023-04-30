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
            customTextField(hint: passwordHint,title: password,isPass: true,controller: controller.passwordController),
                20.heightBox,
                controller.isLoading.value? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ):SizedBox(
                  width: context.screenWidth-60,
                    child: button(
                        color: redColor,
                        onPress: ()async{
                          controller.isLoading(true);
                      await controller.uploadProfileImage();
                      await controller.updateProfile(
                        imageUrl: controller.profileImageLink,
                        name: controller.nameController.text,
                        password: controller.passwordController.text,
                      );
                      VxToast.show(context, msg: "Updated");
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
