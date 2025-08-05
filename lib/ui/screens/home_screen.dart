import 'package:flutter/material.dart';
import 'package:muslim_life/ui/widgets/salat_time_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/category_card.dart';
import 'package:muslim_life/ui/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex=0;

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xFFF3EDF7),
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.menu, size: 30),
              const SizedBox(width: 15),
              const Expanded(
                child: Text(
                  textAlign: TextAlign.start,
                  "Home",
                  style: TextStyle(
                    fontFamily: "playfair",
                    fontSize: 20,
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
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/images/main_card_bg.png",
                          height: MediaQuery.of(context).size.height / 5.8,
                          fit: BoxFit.fill,
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Tuesday, 12 Mar 2024',
                              style: TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6.5,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/Category Section.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                            const SizedBox(height: 10),
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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/images/quets_bg.png",
                          height: MediaQuery.of(context).size.height / 7,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              textAlign: TextAlign.center,
                              'নিশ্চয় আল্লাহ তা‘আলা তোমাদের দেহ এবং তোমাদের আকৃতি দেখেন না, বরং তিনি তোমাদের অন্তর ও আমল দেখেন।',
                              style: TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              '[সহীহুল বুখারী ৫১৪৪, ৬০৬৬, মুসলিম ২৫৬৪]',
                              style: TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/images/Prayer Time Section.png",
                          height: MediaQuery.of(context).size.height / 4,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Prayer Time',
                              style: TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Tuesday, 12 Mar 2024',
                              style: TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Divider(
                                height: 1, thickness: 1, color: Colors.white),
                            const SizedBox(height: 10),
                            // Next prayer text and large time display
                            const Text(
                              'Next prayer: Asr in 2 hours, 17 minutes',
                              style: TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '4:26 PM',
                              style: TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0;
                                      i < prayerTimes.length;
                                      i++)
                                    Expanded(
                                      child: SalatTimeCard(
                                        title: prayerTimes[i]['name']!,
                                        time: prayerTimes[i]['time']!,
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
                ),
              ],
            ),
          ),
          const Center(
            child: Text('Calendar Page'),
          ),
          const Center(
            child: Text('Schedule Page'),
          ),
          const Center(
            child: Text('Settings Page'),
          ),
        ],
      ),
        bottomNavigationBar: MainNavBarHolder(
          selectedIndex: _selectedIndex,
          onItemSelected: _onItemTapped,
        )
    );
  }
}
