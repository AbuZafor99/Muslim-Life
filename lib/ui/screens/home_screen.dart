import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:adhan/adhan.dart';
import 'package:muslim_life/data/zilla_locations.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/category_card.dart';
import '../widgets/salat_time_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late PrayerTimes _prayerTimes;
  late Coordinates _coordinates;
  late double _qiblaDirection;
  bool _loading = true;

  String _selectedDistrict = 'Dhaka';
  String _selectedAsrMethod = 'Shafi';
  CalculationMethod _selectedCalculationMethod = CalculationMethod.muslim_world_league;

  List<Map<String, String>> prayerTimes = [];

  final List<Map<String, String>> category = [
    {"title": "Prayer Time", "image": "assets/images/pray 1.png"},
    {"title": "Tasbih", "image": "assets/images/tasbhi.png"},
    {"title": "Dua", "image": "assets/images/dua 1.png"},
    {"title": "Quran", "image": "assets/images/quran.png"},
  ];

  @override
  void initState() {
    super.initState();
    _calculatePrayerTimes();
  }

  void _calculatePrayerTimes() {
    final selected = zillaLocations.firstWhere(
          (z) => z['name'] == _selectedDistrict,
      orElse: () => {
        'name': 'Dhaka',
        'latitude': 23.8103,
        'longitude': 90.4125,
      },
    );
    _coordinates = Coordinates(
      selected['latitude'],
      selected['longitude'],
    );

    final params = _getCalculationMethod();
    final now = DateTime.now();
    final prayerTimesInstance = PrayerTimes(
      _coordinates,
      DateComponents.from(now),
      params,
    );

    prayerTimes = [
      {'name': 'Fajr', 'time': DateFormat('hh:mm a').format(prayerTimesInstance.fajr)},
      {'name': 'Sunrise', 'time': DateFormat('hh:mm a').format(prayerTimesInstance.sunrise)},
      {'name': 'Dhuhr', 'time': DateFormat('hh:mm a').format(prayerTimesInstance.dhuhr)},
      {'name': 'Asr', 'time': DateFormat('hh:mm a').format(prayerTimesInstance.asr)},
      {'name': 'Maghrib', 'time': DateFormat('hh:mm a').format(prayerTimesInstance.maghrib)},
      {'name': 'Isha', 'time': DateFormat('hh:mm a').format(prayerTimesInstance.isha)},
    ];

    setState(() {
      _prayerTimes = prayerTimesInstance;
      _qiblaDirection = Qibla(_coordinates).direction;
      _loading = false;
    });
  }

  CalculationParameters _getCalculationMethod() {
    switch (_selectedCalculationMethod) {
      case CalculationMethod.karachi:
        return CalculationMethod.karachi.getParameters();
      case CalculationMethod.muslim_world_league:
        return CalculationMethod.muslim_world_league.getParameters();
      case CalculationMethod.umm_al_qura:
        return CalculationMethod.umm_al_qura.getParameters();
      case CalculationMethod.egyptian:
        return CalculationMethod.egyptian.getParameters();
      case CalculationMethod.north_america:
        return CalculationMethod.north_america.getParameters();
      default:
        return CalculationMethod.muslim_world_league.getParameters();
    }
  }

  BoxDecoration _dropdownDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha(20),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
      border: Border.all(color: const Color(0xff764CA5), width: 1.5),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    String nextPrayerName = '';
    Duration timeRemaining = Duration.zero;
    DateTime now = DateTime.now();

    if (now.isBefore(_prayerTimes.fajr)) {
      nextPrayerName = 'Fajr';
      timeRemaining = _prayerTimes.fajr.difference(now);
    } else if (now.isBefore(_prayerTimes.sunrise)) {
      nextPrayerName = 'Sunrise';
      timeRemaining = _prayerTimes.sunrise.difference(now);
    } else if (now.isBefore(_prayerTimes.dhuhr)) {
      nextPrayerName = 'Dhuhr';
      timeRemaining = _prayerTimes.dhuhr.difference(now);
    } else if (now.isBefore(_prayerTimes.asr)) {
      nextPrayerName = 'Asr';
      timeRemaining = _prayerTimes.asr.difference(now);
    } else if (now.isBefore(_prayerTimes.maghrib)) {
      nextPrayerName = 'Maghrib';
      timeRemaining = _prayerTimes.maghrib.difference(now);
    } else if (now.isBefore(_prayerTimes.isha)) {
      nextPrayerName = 'Isha';
      timeRemaining = _prayerTimes.isha.difference(now);
    } else {
      nextPrayerName = 'Fajr';
      final tomorrow = now.add(const Duration(days: 1));
      final tomorrowPrayerTimes = PrayerTimes(
        _coordinates,
        DateComponents.from(tomorrow),
        _getCalculationMethod(),
      );
      timeRemaining = tomorrowPrayerTimes.fajr.difference(now);
    }

    String formattedTimeRemaining = '';
    if (timeRemaining.inHours > 0) {
      formattedTimeRemaining += '${timeRemaining.inHours} hours, ';
    }
    formattedTimeRemaining += '${timeRemaining.inMinutes.remainder(60)} minutes';


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
                            Text(
                              DateFormat('hh:mm a').format(DateTime.now()),
                              style: const TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateFormat.yMMMMEEEEd().format(DateTime.now()),
                              style: const TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Qibla Direction: ${_qiblaDirection.toStringAsFixed(2)}°',
                                style: const TextStyle(
                                  fontFamily: 'playfair',
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            const Center(
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
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.only(bottom: 10),
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
                            Text(
                              DateFormat.yMMMMEEEEd().format(DateTime.now()),
                              style: const TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Divider(
                                height: 1, thickness: 1, color: Colors.white),
                            const SizedBox(height: 10),
                            Text(
                              'Next prayer: $nextPrayerName in $formattedTimeRemaining',
                              style: const TextStyle(
                                fontFamily: 'playfair',
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat('hh:mm a').format(_prayerTimes.fajr),
                              style: const TextStyle(
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
                                  for (int i = 0; i < prayerTimes.length; i++)
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
      ),
    );
  }
}
