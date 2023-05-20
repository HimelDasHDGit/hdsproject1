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
              return Container();
            }
          }
      ),
    );
  }
}
