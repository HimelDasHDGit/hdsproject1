import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    var uId= FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 40,),
            const home_button(),
            const SizedBox(height: 5,),
            const personal_history(),//HomeIcon
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
            Card(
              margin: const EdgeInsets.only(left: 10,right: 10),
              color: Colors.green,
              child: Column(
                children: [
                  Text(
                      FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('user info').snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
                     if (snapshot.hasData) {
                       return SizedBox(
                         height: 150,
                         width: 250,
                         child: ListView.builder(
                           itemCount: snapshot.data!.docs.length,
                           itemBuilder: (context, index){
                             return Card(
                                 color: Colors.green,
                               margin: const EdgeInsets.only(left: 5,right: 5,top: 5),
                                 child: Padding(
                                   padding: const EdgeInsets.only(
                                     left: 10,right: 5,
                                   ),
                                   child: Column(
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           const Text(
                                             'Name:',
                                             style: TextStyle(
                                               color: Colors.white,
                                                 fontSize: 20,
                                                 fontWeight: FontWeight.w300
                                             ),
                                           ),
                                           Text(
                                               snapshot.data!.docs[index]['name'],
                                             style: const TextStyle(
                                               color: Colors.white,
                                               fontSize: 20,
                                               fontWeight: FontWeight.w300,
                                               overflow: TextOverflow.fade
                                             ),
                                           ),
                                         ],
                                       ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           const Text(
                                             'Email:',
                                             style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 20,
                                                 fontWeight: FontWeight.w300
                                             ),
                                           ),
                                           Text(
                                             snapshot.data!.docs[index]['email'],
                                             style: const TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 20,
                                                 fontWeight: FontWeight.w300
                                             ),
                                           ),
                                         ],
                                       ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           const Text(
                                             'Address:',
                                             style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 20,
                                                 fontWeight: FontWeight.w300
                                             ),
                                           ),
                                           Expanded(
                                             child: Text(
                                               snapshot.data!.docs[index]['address'],
                                               style: const TextStyle(
                                                   color: Colors.white,
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.w300
                                               ),
                                               maxLines: 1,
                                               textDirection: TextDirection.ltr,
                                               textAlign: TextAlign.justify,
                                               overflow: TextOverflow.ellipsis,
                                             ),
                                           ),
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),
                             );
                           },
                         ),
                       );
                     }  else{
                       return Container(height: 0,);
                     }
                      }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Card(
              color: Colors.green,
              margin: const EdgeInsets.only(left: 50,right: 50),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Edit Profile:'),
                IconButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return Dialog(
                              backgroundColor: Colors.green,
                              child: Form(
                                key: _formKey,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  children: [
                                    StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection('user info').snapshots(),
                                        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
                                          if (snapshot.hasData) {
                                            return SizedBox(
                                              height: 100,
                                              child: ListView.builder(
                                                itemCount: snapshot.data!.docs.length,
                                                itemBuilder: (context, index){
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        snapshot.data!.docs[index]['name'],
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w300,
                                                            overflow: TextOverflow.fade
                                                        ),
                                                      ),
                                                      const Text(
                                                          "'s profile",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w300,
                                                            overflow: TextOverflow.fade,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 80,),
                                                      IconButton(
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                          },
                                                          icon: Icon(
                                                            Icons.cancel_outlined,
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
                                                    ],
                                                  );
                                                },
                                              ),
                                            );
                                          }  else{
                                            return Container(height: 0,);
                                          }
                                        }
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              hintText: 'Name',
                                              hintStyle: const TextStyle(color: Colors.white),
                                            ),
                                            cursorColor: Colors.white,
                                            controller: _nameController,
                                            validator: (value){
                                              if (value!.isEmpty) {
                                                return "Can't be empty";
                                              }  else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              hintText: 'Email',
                                              hintStyle: const TextStyle(color: Colors.white),
                                            ),
                                            cursorColor: Colors.white,
                                            controller: _emailController,
                                            keyboardType: TextInputType.emailAddress,
                                            validator: (value){
                                              if (value!.isEmpty) {
                                                return "Can't be empty";
                                              }
                                              //else if (int.fromEnvironment(value)>11){return "Invalid email";}
                                              else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),

                                              ),
                                              hintText: 'Address',
                                              hintStyle: const TextStyle(color: Colors.white),
                                            ),
                                            cursorColor: Colors.white,
                                            controller: _addressController,
                                            validator: (value){
                                              if (value!.isEmpty) {
                                                return "Can't be empty";
                                              }
                                              else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        ElevatedButton(
                                          onPressed: (){
                                            setState(() {
                                              if (_formKey.currentState!.validate()) {
                                                Navigator.pop(context);
                                              }
                                            });
                                            Map<String, dynamic> userdata={
                                              'name':_nameController.text,
                                              'email': _emailController.text,
                                              'address': _addressController.text,
                                              'uid':uId,
                                            };
                                            FirebaseFirestore.instance.collection('user info').add(userdata);
                                          },
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.green),
                                          ),
                                          child: const Text("Update"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                              ),
                            );
                          }
                      );
                    },
                    icon: const Icon(
                        Icons.edit
                    ),
                ),
              ],
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


