import 'package:flutter/material.dart';
import 'package:hdsproject1/profile/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
            'BonsaiHut',
          style: TextStyle(
            fontFamily: 'Pacifico',
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const Profile()));
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/welcomeimage.jpg'),
            ),
          ),
        ],
      ),
      drawer:  Drawer(
        elevation: 10,
        backgroundColor: Colors.green,
        shadowColor: Colors.white,
        shape: DrawerTheme.of(context).shape,
        width: 180,
        child: SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.only(
            top: 80,
          ),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Image.asset('assets/images/loginimage.png'),
               SizedBox(height: 150,),
               Divider(height: .2,color: Colors.white,),
               ListTile(
                onTap: (){},
                leading: Text(
                  'Cart',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 25,
                    color: Colors.white
                  ),
                ),
                trailing: Icon(Icons.shopping_cart,size: 25,color: Colors.yellow,),
              ),
               Divider(height: .2,color: Colors.white,),
               ListTile(
                 onTap: (){},
                leading: Text(
                  'Sellers',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 25,
                      color: Colors.white
                  ),
                ),
                trailing: Icon(Icons.sell,size: 25,color: Colors.yellow,),
              ),
               Divider(height: .2,color: Colors.white,),
               ListTile(
                 onTap: (){},
                leading: Text(
                  'Top sellers',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                trailing: Icon(Icons.people,size: 25,color: Colors.yellow,),
              ),
               Divider(height: .2,color: Colors.white,),
               ListTile(
                 onTap: (){},
                leading: Text(
                  'Premium',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 25,
                      color: Colors.white
                  ),
                ),
                trailing: Icon(Icons.star_sharp,size: 25,color: Colors.yellow,),
              ),
               Divider(height: .2,color: Colors.white,),
               ListTile(
                onTap: (){},
                leading: Text(
                  'Design temp.',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                    child: Image.asset('assets/images/design2.png',fit: BoxFit.cover,color: Colors.white,),
                  height: 35,
                  width: 35,
                ),
              ),
               Divider(height: .2,color: Colors.white,),
               ListTile(
                 onTap: (){},
                leading: Text(
                  'Exit',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 25,
                      color: Colors.white,
                  ),
                ),
                trailing: Icon(Icons.exit_to_app,size: 25,color: Colors.yellow,),
              ),
               Divider(height: .2,color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}
