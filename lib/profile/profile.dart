import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hdsproject1/home.dart';
import 'package:image_picker/image_picker.dart';
class Profile extends StatefulWidget {
   const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {

  // late File image;

  String profileImageUrl = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            home_button(),
            SizedBox(height: 5,),
            personal_history(),//HomeIcon
            const SizedBox(height: 10,),
            Stack(
              children: [
                FutureBuilder(
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white.withOpacity(.5),
                      child: Image.asset(
                          'assets/images/loginimage.png',
                        fit: BoxFit.cover,
                        height: 130,
                        width: 130,
                      ),
                    );
                  }
                ),
                Positioned(
                  bottom: 8,
                  right: 20,
                  child: GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context){
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.green.shade500,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8.0),
                                    topLeft:Radius.circular(8.0),
                                ),
                              ),
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                        onPressed: ()async{
                                          // _getFromGallery();
                                          ImagePicker imagePicker = ImagePicker();
                                          XFile? file = await imagePicker.pickImage(
                                              source: ImageSource.gallery
                                          );

                                          if (file==null) return;

                                          Reference  referenceRoot = FirebaseStorage.instance.ref();
                                          Reference referenceProfileImages = referenceRoot.child('profileImages');
                                          Reference referenceProfileImageToBeUploaded = referenceProfileImages.child(file.name);

                                          try{

                                            await referenceProfileImageToBeUploaded.putFile(File(file.path));
                                            profileImageUrl=await referenceProfileImageToBeUploaded.getDownloadURL();

                                          }catch(error){}
                                          Navigator.of(context).pop();

                                        },
                                        icon: const Icon(Icons.image,size: 35,color: Colors.white,)
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                        onPressed: ()async{
                                          // _getFromCamera();

                                          ImagePicker imagePicker = ImagePicker();
                                          XFile? file = await imagePicker.pickImage(
                                              source: ImageSource.camera
                                          );

                                          if (file==null) return;

                                          Reference  referenceRoot = FirebaseStorage.instance.ref();
                                          Reference referenceProfileImages = referenceRoot.child('profileImages');
                                          Reference referenceProfileImageToBeUploaded = referenceProfileImages.child(file.name);

                                          try{

                                            await referenceProfileImageToBeUploaded.putFile(File(file.path));
                                            profileImageUrl=await referenceProfileImageToBeUploaded.getDownloadURL();

                                          }catch(error){}
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(Icons.camera,size: 35,color: Colors.white,)
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        backgroundColor: Colors.transparent,
                      );
                    },
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.white.withOpacity(.8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 50.0,right: 50),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                cursorColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 50.0,right: 50),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                cursorColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 50.0,right: 50),
              child: TextFormField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),

                    ),
                  hintText: 'Address',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                cursorColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: (){},
                child: Text("Update"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class home_button extends StatelessWidget {
  const home_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 300,),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.green.shade300,
          child: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const Home()));
            },
            icon:  Icon(
              Icons.home,
              color: Colors.white.withOpacity(.9),
              size: 30,
              shadows: const [
                BoxShadow(
                  offset: Offset.zero,
                  blurRadius: 5,
                  spreadRadius: 5
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
class personal_history extends StatelessWidget {
  const personal_history({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 300,),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.green.shade300,
          child: IconButton(
            onPressed: (){},
            icon:  Icon(
              Icons.history,
              color: Colors.white.withOpacity(.9),
              size: 30,
              shadows: const [
                BoxShadow(
                    offset: Offset.zero,
                    blurRadius: 5,
                    spreadRadius: 5
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


