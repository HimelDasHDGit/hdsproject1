import 'package:hdsproject1/consts/consts.dart';

//get users data
class FirestoreServices{

  static getUser(uid){
    return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();
  }

  static getProducts(category){
    return firestore.collection(productsCollection).where('category',isEqualTo: category).snapshots();
  }

}