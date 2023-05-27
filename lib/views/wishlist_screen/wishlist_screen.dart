import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/services/firestore_services.dart';
import 'package:hdsproject1/widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Your Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishList(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator(),);
            } else if(snapshot.data!.docs.isEmpty){
              return 'No wishlit to show!'.text.color(darkFontGrey).makeCentered();
            }else{
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context,int index){
                        return ListTile(
                          leading: Image.network("${data[index]['images'][0]}",fit: BoxFit.cover,).box.size(100,100).make(),
                          title: "${data[index]['name']}".text.fontFamily(semibold).size(16).make(),
                          subtitle: "${data[index]['price']}".numCurrency.text.fontFamily(semibold).color(redColor).make(),
                          trailing: const Icon(Icons.favorite,color: redColor,).onTap(() {
                            firestore.collection(productsCollection).doc(data[index].id).set({
                              'wishlist':FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                          }),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }
      ),
    );
  }
}
