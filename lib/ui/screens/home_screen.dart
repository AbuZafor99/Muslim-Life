import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.menu,size: 30,weight: 800,),
            SizedBox(width: 5,),
            Text("Home",style: TextStyle(
              fontFamily: "playfair",
              fontSize: 16
            ),)
          ],
        ),

      ),
      body: const Center(
        child: Text('Welcome to Muslim Life!',),
      ),
    );
  }
}
