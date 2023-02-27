// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:ui';
import 'homepage.dart';
import 'settings.dart';
import 'myprofile.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({Key? key}) : super(key: key);

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  bool _showedSnackBar = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // questions and answers
  final List<Map<String, dynamic>> _questions = [
    {
      'question': '1. Beer or cider?',
      'answers': ['Beer', 'Cider', 'I don\'t drink'],
    },
    {
      'question': '2. Tell us about your taste in music',
      'answers': ['Trap', 'Hip hop', 'Rock', 'Jazz', 'Folk', 'Techno', 'RnB'],
    },
    {
      'question': '3. Finally, tell us about your type',
      'answers': [
        'Edgy',
        'Calm',
        'Cool',
        'Spontaneous',
        'Enthousiastic',
        'Geeky',
        'Outgoing'
      ],
    }
  ];
  final List<List<bool>> _selectedAnswers = [
    [false, false, false],
    [false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false],
  ];

  @override
  Widget build(BuildContext context) {
    // snackbar to indicate the user to swipe left to continue
    if (_currentPageIndex == 0 && !_showedSnackBar) {
      _showedSnackBar = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            'Swipe left to go to the next page',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: 0.01,
              fontFeatures: [
                FontFeature.enable('pnum'),
                FontFeature.enable('lnum')
              ],
            ),
          ),
          duration: const Duration(milliseconds: 7000),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color(0xFFE7E0EC),
          margin: const EdgeInsets.only(left: 80, bottom: 60, right: 50),
          elevation: 8,
          action: SnackBarAction(
            label: 'OK',
            textColor: const Color(0xff6750A4),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ));
      });
    }

    // swipe
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (details.delta.dx > 0) {
          // swipe right
          if (_currentPageIndex > 0) {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        } else if (details.delta.dx < 0) {
          // swipe left
          if (_currentPageIndex < _questions.length - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            // navigate to home page (i'm in the last quesitonnaire page)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
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
                  MaterialPageRoute(
                      builder: (context) => const MyProfilePage()),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Let\'s get to know you',
                  style: TextStyle(
                    fontFamily: 'Sofia-Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _questions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1.0),
                                  child: Text(
                                    _questions[index]['question'],
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    // to detect swipes inside the list
                                    onHorizontalDragUpdate:
                                        (DragUpdateDetails details) {
                                      if (details.delta.dx > 0) {
                                        // swipe right
                                        if (_currentPageIndex > 0) {
                                          _pageController.previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      } else if (details.delta.dx < 0) {
                                        // swipe left
                                        if (_currentPageIndex <
                                            _questions.length - 1) {
                                          _pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        } else {
                                          // navigate to home page
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()),
                                            (Route<dynamic> route) => false,
                                          );
                                        }
                                      }
                                    },
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          _questions[index]['answers'].length,
                                      itemBuilder: (BuildContext context,
                                          int answerIndex) {
                                        final String answer = _questions[index]
                                            ['answers'][answerIndex];
                                        return CheckboxListTile(
                                          title: Text(answer),
                                          value: _selectedAnswers[index]
                                              [answerIndex],
                                          onChanged: (bool? newValue) {
                                            setState(() {
                                              _selectedAnswers[index]
                                                      [answerIndex] =
                                                  newValue ?? false;
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          onPageChanged: (int pageIndex) {
                            setState(() {
                              _currentPageIndex = pageIndex;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
