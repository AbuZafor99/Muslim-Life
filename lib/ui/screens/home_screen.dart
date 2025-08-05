import 'package:flutter/material.dart';

import '../widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> prayerTimes = [
    {'name': 'Fajr', 'time': '4:30 am'},
    {'name': 'Dhuhr', 'time': '1:00 pm'},
    {'name': 'Asr', 'time': '4:30 pm'},
    {'name': 'Maghrib', 'time': '6:15 pm'},
    {'name': 'Isha', 'time': '7:30 pm'},
  ];

  final List<Map<String, String>> category = [
    {"title": "Prayer Time", "image": "assets/images/pray 1.png"},
    {"title": "Tasbih", "image": "assets/images/tasbhi.png"},
    {"title": "Dua", "image": "assets/images/dua 1.png"},
    {"title": "Quran", "image": "assets/images/quran.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.menu, size: 30),
              const SizedBox(width: 15),
              const Expanded(
                child: Text(
                  "Home",
                  style: TextStyle(
                    fontFamily: "playfair",
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFCEC5D8),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(Icons.notifications_none, size: 30),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/images/main_card_bg.png",
                    height: MediaQuery.of(context).size.height / 4.9,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 23,
                    horizontal: 39,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'আসসালামু আলাইকুম',
                        style: TextStyle(
                          fontFamily: 'playfair',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '12:45 PM',
                        style: TextStyle(
                          fontFamily: 'playfair',
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '1st Ramadan 4445',
                        style: TextStyle(
                          fontFamily: 'playfair',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Tuesday, 12 Mar 2024',
                        style: TextStyle(
                          fontFamily: 'playfair',
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4.5,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/Category Section.png",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "playfair",
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          itemCount: category.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              title: category[index]['title']!,
                              image: category[index]['image']!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
