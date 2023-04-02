import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hdsproject1/showprofile/buttons/logout.dart';
import 'package:image_picker/image_picker.dart';
import 'buttons/home_button.dart';
import 'buttons/personal_history.dart';

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
  final _cU = FirebaseAuth.instance;

  DatabaseReference ref = FirebaseDatabase.instance.ref();





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
            const HomeButton(),
            const SizedBox(height: 5,),
            const PersonalHistory(),//H
            const SizedBox(height: 5,),
            const LogoutButton(),// omeIcon
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('user data').where(
                  'uid',
                  isEqualTo: _cU.currentUser!.uid
              ).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
               if (snapshot.hasData) {
                 return SizedBox(
                   height: 600,
                   width: 250,
                   child: ListView.builder(
                     itemCount: 1,
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
                                 Text(
                                   FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
                                   style: const TextStyle(
                                     color: Colors.white,
                                     fontWeight: FontWeight.w300,
                                     fontSize: 20,
                                   ),
                                 ),
                                 const SizedBox(height: 10,),
                                 Stack(
                                   children: [
                                     CircleAvatar(
                                       radius: 80,
                                       backgroundColor: Colors.white.withOpacity(.5),
                                       backgroundImage: NetworkImage(
                                         snapshot.data!.docs[index]['image'],
                                       ),
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
                                                   color: Colors.green,
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

                                                             }catch(error){return;}
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

                                                           }catch(error){return;}
                                                           Navigator.of(context).pop();
                                                         },
                                                         icon: const Icon(Icons.camera,size: 35,color: Colors.white,),
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
                                 const SizedBox(height: 5,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     const Text(
                                       'Name: ',
                                       style: TextStyle(
                                         color: Colors.white,
                                           fontSize: 20,
                                           fontWeight: FontWeight.w300
                                       ),
                                     ),
                                     SizedBox(
                                       width: 100,
                                       child: Flex(
                                         direction: Axis.horizontal,
                                         children: [
                                           Expanded(
                                             flex: 1,
                                             child: Text(
                                               snapshot.data!.docs[index]['name'],
                                               style: const TextStyle(
                                                   color: Colors.white,
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.w300,
                                                   overflow: TextOverflow.ellipsis
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                      const Text(
                                       'Email: ',
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 20,
                                           fontWeight: FontWeight.w300
                                       ),
                                     ),
                                     SizedBox(
                                       width: 100,
                                       child: Flex(
                                         direction: Axis.horizontal,
                                         children: [
                                           Expanded(
                                             flex: 1,
                                             child: Text(
                                               snapshot.data!.docs[index]['email'],
                                               style: const TextStyle(
                                                   color: Colors.white,
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.w300,
                                                   overflow: TextOverflow.ellipsis
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     const Text(
                                       'Address: ',
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 20,
                                           fontWeight: FontWeight.w300
                                       ),
                                     ),
                                     SizedBox(
                                       width: 100,
                                       child: Flex(
                                         direction: Axis.horizontal,
                                         children: [
                                           Expanded(
                                             flex: 1,
                                             child: Text(
                                               snapshot.data!.docs[index]['address'],
                                               style: const TextStyle(
                                                   color: Colors.white,
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.w300,
                                                 overflow: TextOverflow.ellipsis,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                                 const SizedBox(height: 10,),
                                 Card(
                                   color: Colors.green.shade500,
                                   margin: const EdgeInsets.only(left: 0,right: 0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                       const Text(
                                         'Edit ',
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 20,
                                           fontWeight: FontWeight.w300,
                                           overflow: TextOverflow.fade,
                                         ),
                                       ),
                                       IconButton(
                                         onPressed: (){
                                          setState(() {
                                            _nameController.text=snapshot.data!.docs[index]['name'];
                                            _emailController.text=snapshot.data!.docs[index]['email'];
                                            _addressController.text=snapshot.data!.docs[index]['address'];
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context){
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
                                                              stream: FirebaseFirestore.instance.collection('user data').snapshots(),
                                                              builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
                                                                if (snapshot.hasData) {
                                                                  return SizedBox(
                                                                    height: 300,
                                                                    child: ListView.builder(
                                                                      itemCount: 1,
                                                                      itemBuilder: (context, index)=>
                                                                          Column(
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    padding: const EdgeInsets.only(left: 10),
                                                                                    width: 100,
                                                                                    child: Flex(
                                                                                      direction: Axis.horizontal,
                                                                                      children:[
                                                                                        Expanded(
                                                                                          flex: 1,
                                                                                          child: Text(
                                                                                            snapshot.data!.docs[index]['name'],
                                                                                            style: const TextStyle(
                                                                                              color: Colors.white,
                                                                                              fontSize: 20,
                                                                                              fontWeight: FontWeight.w300,
                                                                                            ),
                                                                                            maxLines: 1,
                                                                                            textDirection: TextDirection.ltr,
                                                                                            textAlign: TextAlign.justify,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                        ),],
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
                                                                                  const SizedBox(width: 50,),
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
                                                                              ),
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
                                                                                  snapshot.data!.docs[index].reference.update(userdata);
                                                                                },
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all(Colors.green),
                                                                                ),
                                                                                child: const Text("Update"),
                                                                              ),
                                                                            ],
                                                                          )
                                                                    ),
                                                                  );
                                                                }  else return Container();
                                                              }
                                                          ),
                                                        ],
                                                      ),

                                                    ),
                                                  );
                                                }
                                            );
                                          });
                                         },
                                         icon: const Icon(
                                           Icons.edit,
                                           color: Colors.white,
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                       );
                     },
                   ),
                 );
               }  else
                 return Container();
                }
            ),
          ],
        ),
      ),
    );
  }
}



