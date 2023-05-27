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
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on',descending: false)
        .snapshots();
  }
//get all orders
  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }
//get wishlist
  static getWishList(){
    return firestore.collection(productsCollection).where('wishlist',arrayContains: currentUser!.uid).snapshots();
  }
//get all messages
static getAllMessages(){
  return firestore
      .collection(chatsCollection)
      .where('fromId',isEqualTo: currentUser!.uid)
      .snapshots();
}
//get counts
static getCounts()async {
    var res = await Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(productsCollection).where('wishlist',arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      })
    ]);
    return res;

}
//get all products
static allProducts(){
  return firestore.collection(productsCollection).snapshots();
}


}