// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:ui';
import 'homepage.dart';
import 'map.dart';
import 'myprofile.dart';
import 'settings.dart';
import 'upload.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class OrthogonalLabel extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagepath;

  const OrthogonalLabel(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(57, 102, 80, 164),
        ),
        padding: const EdgeInsets.all(6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 84.0,
              height: 84.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imagepath),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchPageState extends State<SearchPage> {
  // filtering
  final List<String> _labels = [
    'Beer',
    'Lunch',
    'Bar',
    'Party',
    'Live music',
    'Coffee',
    'Brunch',
    'Concert',
    'Festival',
    'Club',
    'Pool/Darts',
    'Bowling'
  ];

  final List<String> selectedFilters = [];

  void _toggleFilter(String filter) {
    setState(() {
      if (selectedFilters.contains(filter)) {
        selectedFilters.remove(filter);
      } else {
        selectedFilters.add(filter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          color: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Text(
            'Hangify',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'mySofia',
              fontWeight: FontWeight.w400,
              fontSize: 25,
              letterSpacing: 0.01,
              fontFeatures: [
                FontFeature.enable('pnum'),
                FontFeature.enable('lnum')
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'What are the plans for today?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Sofia Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Hinted search text',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapPage()),
                      );
                    },
                  ),
                  fillColor: const Color.fromARGB(57, 102, 80, 164),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  // todo:do something with the search query
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _labels.map((filter) {
                    bool isSelected = selectedFilters.contains(filter);
                    return SizedBox(
                      width: MediaQuery.of(context).size.width / 3 - 16,
                      child: FilterChip(
                        elevation: 4.0,
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (isSelected) {
                          _toggleFilter(filter);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Events that you may be interested in:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapPage()),
                              );
                            },
                            child: const OrthogonalLabel(
                              title: 'OPEN HOUSE Athens 2023',
                              subtitle:
                                  'The 10th OPEN HOUSE Athens returns at 1 & 2 of April',
                              imagepath: 'assets/images/open_house_athens.jpg',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapPage()),
                              );
                            },
                            child: const OrthogonalLabel(
                                title: 'Lostre, Kampethon',
                                subtitle:
                                    'Αμολάμε αητό στο Καμπεθόν.Παραδοσιακά κουλουμα με τους λοσ τρε. λάηβ.',
                                imagepath: 'assets/images/kampethon.jpg'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapPage()),
                              );
                            },
                            child: const OrthogonalLabel(
                                title: 'Athens Street Food Festival 2023',
                                subtitle:
                                    'The 6th Athens Street Foost Festival comes in May.',
                                imagepath:
                                    'assets/images/athens_street_food_festival.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                child: const Text(
                  'Guide me',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 102, 102, 102),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            label: 'Back',
          ),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Image.asset('assets/icons/HangifyLogo.png'),
                onPressed: () {},
                iconSize: 10.0,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 102, 102, 102),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadPage()),
                );
              },
            ),
            label: 'Add',
          ),
        ],
      ),
    );
  }
}
