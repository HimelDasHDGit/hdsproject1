import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hdsproject1/main.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
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
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (_)=> AuthGate()));
            },
            icon:  Icon(
              Icons.logout,
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