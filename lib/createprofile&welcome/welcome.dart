import 'package:flutter/material.dart';
import 'package:hdsproject1/home.dart';


class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

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
              const Positioned(
                bottom: 320,
                left: 100,
                child: Text(
                    'BonsaiHut',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
              Positioned(
                bottom: 200,
                left: 30,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: ()async{
                      setState(() {_isloading=true;});
                      await Future.delayed(const Duration(seconds: 1));
                      setState(() {_isloading=false;});
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const Home()));
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _isloading?
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(width: 50,),
                              Text("Loading..",style: TextStyle(color: Colors.green),),
                              SizedBox(width: 100,),
                              CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ):
                        const Text(
                          "Welcome to HUT Master",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                              fontFamily: 'Pacifico',
                          ),
                        ),
                      ),
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
