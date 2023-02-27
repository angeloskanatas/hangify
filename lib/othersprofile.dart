// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'myprofile.dart';
import 'search.dart';
import 'settings.dart';
import 'upload.dart';

class Post {
  final String title;
  final String description;
  final String imagePath;
  bool isFavourite;

  Post({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isFavourite,
  });
}

class OthersProfilePage extends StatefulWidget {
  const OthersProfilePage({Key? key}) : super(key: key);

  @override
  State<OthersProfilePage> createState() => _OthersProfilePageState();
}

class _OthersProfilePageState extends State<OthersProfilePage> {
  final List<Post> posts = [
    Post(
      imagePath: 'assets/images/random4.jpg',
      title: 'Maresei o maragkos',
      description: 'Ayto tipota allo',
      isFavourite: false,
    ),
    Post(
      imagePath: 'assets/images/random3.jpg',
      title: 'Jesus',
      description: 'Christ',
      isFavourite: true,
    ),
    Post(
      imagePath: 'assets/images/random5.jpg',
      title: 'Oti na nai',
      description: 'wow',
      isFavourite: false,
    ),
    Post(
      imagePath: 'assets/images/johnis_ceo.jpg',
      title: 'Geia sas',
      description: 'Kyrioi',
      isFavourite: true,
    ),
  ];

  bool connected = false;

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
            const SizedBox(height: 10.0),
            Row(
              children: [
                const SizedBox(width: 10.0),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/johnis.jpg'),
                  radius: 40.0,
                ),
                const SizedBox(width: 5.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Johnis',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 0.0),
                      Row(
                        children: [
                          const Text(
                            'Eimai o johnis',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          const VerticalDivider(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                connected = !connected;
                              });
                            },
                            style: connected
                                ? ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                          color: Color(0xff6750A4), width: 1.5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                  )
                                : ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 26, vertical: 12),
                                  ),
                            child: Text(
                              connected ? 'Connected' : 'Connect',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: connected ? Colors.black : Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Flexible(
              child: GridView.builder(
                itemCount: posts.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400.0,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final post = posts[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10.0),
                              GestureDetector(
                                onTap: () {},
                                child: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/johnis.jpg'),
                                  radius: 20.0,
                                ),
                              ),
                              const SizedBox(width: 5.0, height: 50.0),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Johnis',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 3.0),
                                  Text('Spiti mou')
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 3.0),
                          Flexible(
                            child: Container(
                              height: 210.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(post.imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Text(post.description),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                          const Divider(height: 1.0, color: Colors.grey),
                          const SizedBox(height: 7.0),
                          SizedBox(
                            height: 40.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      post.isFavourite = !post.isFavourite;
                                    });
                                  },
                                  icon: post.isFavourite
                                      ? const Icon(Icons.favorite,
                                          color: Color(0xff6750A4))
                                      : const Icon(Icons.favorite_border),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const CommentsModalBottomSheet(),
                                    );
                                  },
                                  icon: const Icon(Icons.comment),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
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

//comments modal
class CommentsModalBottomSheet extends StatefulWidget {
  const CommentsModalBottomSheet({Key? key}) : super(key: key);

  @override
  _CommentsModalBottomSheetState createState() =>
      _CommentsModalBottomSheetState();
}

class _CommentsModalBottomSheetState extends State<CommentsModalBottomSheet> {
  List<String> _comments = ['wow', 'ase re'];
  double? keyboardHeight;
  TextEditingController _commentController = TextEditingController();

  void _addComment(String comment) {
    setState(() {
      _comments.add(comment);
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final keyboardHeight = this.keyboardHeight ?? screenHeight * 0.25;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: screenHeight - keyboardHeight,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(height: 1.0, color: Colors.grey),
              const SizedBox(height: 10.0),
              // display the comments
              for (final comment in _comments)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 15.0,
                        backgroundImage:
                            AssetImage('assets/images/aggelos.jpg'),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Aggelos Ui/Ux',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Text(comment),
                            const SizedBox(height: 6.0),
                            Row(
                              children: [
                                const Text(
                                  '2h',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Reply',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 10.0),
              // add a new comment
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 15.0,
                      backgroundImage: AssetImage('assets/images/aggelos.jpg'),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Add a comment...',
                          border: InputBorder.none,
                        ),
                        controller: _commentController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          _addComment(_commentController.text);
                        },
                        child: const Text(
                          'Add Comment',
                          style: TextStyle(
                            color: Color(0xff6750A4),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
