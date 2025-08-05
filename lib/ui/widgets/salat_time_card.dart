import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SalatTimeCard extends StatelessWidget {
  final String title;
  final String time;
  const SalatTimeCard({required this.title, required this.time});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      // width: MediaQuery.of(context).size.width/5.6,
      margin: EdgeInsets.only(right: 5,left: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'playfair',
              color: Color(0xff764CA5),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
                fontFamily: 'playfair',
                color: Color(0xff764CA5),
                fontSize: 10,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}