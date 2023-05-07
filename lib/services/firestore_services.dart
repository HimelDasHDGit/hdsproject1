import 'package:hdsproject1/consts/consts.dart';

//get users data
class FirestoreServices{
//get user
  static getUser(uid){
    return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();
  }
//get category
  static getProducts(category){
    return firestore.collection(productsCollection).where('category',isEqualTo: category).snapshots();
  }
//get cart
  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }
//delete cart item
  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }
//get all chat messages
  static getChatMessages(docId){
    return firestore.collection(chatsCollection)
        .doc(docId).collection(messagesCollection).
    orderBy('created_on',descending: false).snapshots();
  }

}