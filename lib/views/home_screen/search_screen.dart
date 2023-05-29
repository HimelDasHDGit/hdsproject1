import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hdsproject1/consts/consts.dart';
import 'package:hdsproject1/services/firestore_services.dart';
import 'package:hdsproject1/widgets_common/bg_widget.dart';
import 'package:hdsproject1/widgets_common/loading_indicator.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.make(),
        ),
        body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshopt){
            if (!snapshopt.hasData) {
              return Center(child: loadingIndicator(),);
            }  else if(snapshopt.data!.docs.isEmpty) {
              return "No products found".text.color(darkFontGrey).makeCentered();
            } else{

              var data = snapshopt.data!.docs;

              return Container();

            }
          },
        ),
      )
    );
  }
}
