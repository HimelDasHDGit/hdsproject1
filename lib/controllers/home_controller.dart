import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hdsproject1/consts/firebase_const.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var username = '';

  getUsername()  async{
    var n = await firestore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().
    then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    }
    );

    username = n;
    print(username.toString());

  }

}