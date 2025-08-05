import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  const CategoryCard({required this.title, required this.image});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 90,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(image, height: 30, width: 30),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              fontFamily: "playfair",
            ),
          ),
        ],
      ),
    );
  }
}