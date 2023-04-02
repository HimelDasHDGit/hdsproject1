import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hdsproject1/home.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
   const CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

  String profileImageUrl = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();


  final _cU = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var uId= FirebaseAuth.instance.currentUser!.uid;
    var number= FirebaseAuth.instance.currentUser!.phoneNumber;
    return Scaffold(
      backgroundColor: Colors.green,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:  Text(
          "Make a profile for your hut🌲",
          style: TextStyle(
            fontSize: 25,
            color: Colors.lightGreenAccent.withOpacity(.9),
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.w100,
            shadows: const [
              Shadow(
                color: Colors.blue,
                offset: Offset(0, 1),
                blurRadius: 0,
              ),
            ],
          ),
        ),
        leadingWidth: 15,
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: 750,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user data').where(
              'uid',
              isEqualTo: _cU.currentUser!.uid
          ).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {


            if (!snapshot.hasData) {
              return const Home();
            }

                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (context,index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 90,left: 10,right: 10,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              Container(
                                padding: const EdgeInsets.only(left: 3,right: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green,
                                  border: Border.all(color: Colors.white,width: 2,),
                                ),
                                child: Text(
                                  FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Pacifico',
                                    shadows: [
                                      Shadow(
                                        color: Colors.white,
                                        offset: Offset(0, 1),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30,),
                              const Center(
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage('assets/images/welcomeimage.jpg'),
                                ),
                              ),
                              const SizedBox(height:10,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(8),
                                  color: Colors.green,
                                ),
                                width: 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      child: const Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      ),
                                      onTap: ()async{
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
                                      },
                                    ),
                                    GestureDetector(
                                      child: const Icon(
                                        Icons.camera,
                                        color: Colors.white,
                                      ),
                                      onTap: ()async{
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
                                      },
                                    ),
                                  ],
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
                                    hintText: 'Name',
                                    hintStyle: const TextStyle(color: Colors.white),
                                  ),
                                  cursorColor: Colors.white,
                                  controller: _nameController,
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
                                      Map<String, dynamic> userdata={
                                        'name':_nameController.text,
                                        'email': _emailController.text,
                                        'address': _addressController.text,
                                        'uid':uId,
                                        'number': number,
                                        'image': profileImageUrl,
                                      };
                                      FirebaseFirestore.instance.collection('user data').add(userdata);
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const Home()));
                                    }
                                  });

                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.green),
                                ),
                                child: const Text("Update"),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                );

          }
        ),
      ),
    );
      // return StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection('user data').snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return Home();
      //     }  else{
      //       return Scaffold(
      //         backgroundColor: Colors.green,
      //         extendBodyBehindAppBar: true,
      //         appBar: AppBar(
      //           title:  Text(
      //             "Make a profile for your hut🌲",
      //             style: TextStyle(
      //               fontSize: 25,
      //               color: Colors.lightGreenAccent.withOpacity(.9),
      //               fontFamily: 'Pacifico',
      //               fontWeight: FontWeight.w100,
      //               shadows: [
      //                 Shadow(
      //                   color: Colors.blue,
      //                   offset: Offset(0, 1),
      //                   blurRadius: 0,
      //                 ),
      //               ],
      //             ),
      //           ),
      //           leadingWidth: 15,
      //           toolbarHeight: 60,
      //           centerTitle: true,
      //           backgroundColor: Colors.transparent,
      //         ),
      //         body: SingleChildScrollView(
      //           physics: BouncingScrollPhysics(),
      //           child: Padding(
      //             padding: EdgeInsets.only(
      //               top: 90,left: 10,right: 10,
      //             ),
      //             child: Form(
      //               key: _formKey,
      //               child: Column(
      //                 children: [
      //                   SizedBox(height: 20,),
      //                   Container(
      //                     padding: EdgeInsets.only(left: 3,right: 3),
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(8),
      //                       color: Colors.green,
      //                       border: Border.all(color: Colors.white,width: 2,),
      //                     ),
      //                     child: Text(
      //                       FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
      //                       style: TextStyle(
      //                         fontSize: 25,
      //                         color: Colors.white,
      //                         fontFamily: 'Pacifico',
      //                         shadows: [
      //                           Shadow(
      //                             color: Colors.white,
      //                             offset: Offset(0, 1),
      //                             blurRadius: 0,
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(height: 30,),
      //                   Center(
      //                     child: CircleAvatar(
      //                       radius: 50,
      //                       backgroundImage: AssetImage('assets/images/welcomeimage.jpg'),
      //                     ),
      //                   ),
      //                   SizedBox(height:10,),
      //                   Container(
      //                     decoration: BoxDecoration(
      //                       borderRadius:BorderRadius.circular(8),
      //                       color: Colors.green,
      //                     ),
      //                     width: 70,
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                       children: [
      //                         Icon(
      //                           Icons.camera,
      //                           color: Colors.white,
      //                         ),
      //                         Icon(
      //                           Icons.photo,
      //                           color: Colors.white,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   const SizedBox(height: 10,),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 20,right: 20),
      //                     child: TextFormField(
      //                       decoration: InputDecoration(
      //                         focusedBorder: OutlineInputBorder(
      //                           borderSide: const BorderSide(
      //                             color: Colors.white,
      //                             width: 1,
      //                           ),
      //                           borderRadius: BorderRadius.circular(8),
      //                         ),
      //                         border: OutlineInputBorder(
      //                           borderRadius: BorderRadius.circular(8),
      //                           borderSide: const BorderSide(
      //                             color: Colors.white,
      //                             width: 2,
      //                           ),
      //
      //                         ),
      //                         hintText: 'Name',
      //                         hintStyle: const TextStyle(color: Colors.white),
      //                       ),
      //                       cursorColor: Colors.white,
      //                       controller: _nameController,
      //                       validator: (value){
      //                         if (value!.isEmpty) {
      //                           return "Can't be empty";
      //                         }
      //                         else {
      //                           return null;
      //                         }
      //                       },
      //                     ),
      //                   ),
      //                   const SizedBox(height: 10,),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 20,right: 20),
      //                     child: TextFormField(
      //                       decoration: InputDecoration(
      //                         border: OutlineInputBorder(
      //                           borderRadius: BorderRadius.circular(8),
      //                         ),
      //                         focusedBorder: OutlineInputBorder(
      //                           borderSide: const BorderSide(
      //                             color: Colors.white,
      //                             width: 2,
      //                           ),
      //                           borderRadius: BorderRadius.circular(8),
      //                         ),
      //                         hintText: 'Email',
      //                         hintStyle: const TextStyle(color: Colors.white),
      //                       ),
      //                       cursorColor: Colors.white,
      //                       controller: _emailController,
      //                       keyboardType: TextInputType.emailAddress,
      //                       validator: (value){
      //                         if (value!.isEmpty) {
      //                           return "Can't be empty";
      //                         }
      //                         //else if (int.fromEnvironment(value)>11){return "Invalid email";}
      //                         else {
      //                           return null;
      //                         }
      //                       },
      //                     ),
      //                   ),
      //                   const SizedBox(height: 10,),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 20,right: 20),
      //                     child: TextFormField(
      //                       decoration: InputDecoration(
      //                         focusedBorder: OutlineInputBorder(
      //                           borderSide: const BorderSide(
      //                             color: Colors.white,
      //                             width: 1,
      //                           ),
      //                           borderRadius: BorderRadius.circular(8),
      //                         ),
      //                         border: OutlineInputBorder(
      //                           borderRadius: BorderRadius.circular(8),
      //                           borderSide: const BorderSide(
      //                             color: Colors.white,
      //                             width: 2,
      //                           ),
      //
      //                         ),
      //                         hintText: 'Address',
      //                         hintStyle: const TextStyle(color: Colors.white),
      //                       ),
      //                       cursorColor: Colors.white,
      //                       controller: _addressController,
      //                       validator: (value){
      //                         if (value!.isEmpty) {
      //                           return "Can't be empty";
      //                         }
      //                         else {
      //                           return null;
      //                         }
      //                       },
      //                     ),
      //                   ),
      //                   const SizedBox(height: 10,),
      //                   ElevatedButton(
      //                     onPressed: (){
      //                       setState(() {
      //                         if (_formKey.currentState!.validate()) {
      //                           Map<String, dynamic> userdata={
      //                             'name':_nameController.text,
      //                             'email': _emailController.text,
      //                             'address': _addressController.text,
      //                             'uid':uId,
      //                             'number': number,
      //                           };
      //                           FirebaseFirestore.instance.collection('user data').add(userdata);
      //                           Navigator.push(context, MaterialPageRoute(builder: (_)=>Home()));
      //                         }
      //                       });
      //
      //                     },
      //                     style: ButtonStyle(
      //                       backgroundColor: MaterialStateProperty.all(Colors.green),
      //                     ),
      //                     child: const Text("Update"),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       );
      //     }
      //   }
      // );
  }
}
