import 'package:flutter/material.dart';
import 'package:hdsproject1/home.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
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