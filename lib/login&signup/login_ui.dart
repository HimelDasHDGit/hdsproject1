import 'package:flutter/material.dart';
import 'package:hdsproject1/login&signup/phone_login.dart';
import 'package:hdsproject1/login&signup/phone_signup.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({Key? key}) : super(key: key);

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {

  bool _isloading=false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: Colors.green,
        child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Image.asset('assets/images/loginimage.png'),
              ),
              Positioned(
                bottom: 320,
                left: 100,
                child: Text(
                    'BonsaiHut',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Colors.white70,
                  ),
                ),
              ),
              Positioned(
                bottom: 200,
                left: 30,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: ()async{
                      setState(() {_isloading=true;});
                      await Future.delayed(Duration(seconds: 1));
                      setState(() {_isloading=false;});
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _isloading?
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 50,),
                              Text("Loading..",style: TextStyle(color: Colors.green),),
                              SizedBox(width: 100,),
                              CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ):
                        Text(
                          "Login with contact number",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 150,
                left: 160,
                child: Text(
                  "or",
                  style: TextStyle(
                    fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Positioned(
                bottom: 120,
                left: 80,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>PhoneSignup()));
                  },
                  child: Text(
                    "Create account🌲",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }
}
