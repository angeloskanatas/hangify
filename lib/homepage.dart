// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'search.dart';
import 'settings.dart';
import 'upload.dart';
import 'othersprofile.dart';
import 'myprofile.dart';

class Post {
  final String name;
  final String location;
  final String avatar;
  final String title;
  final String description;
  final String postimagePath;
  bool isFavourite;

  Post({
    required this.name,
    required this.location,
    required this.avatar,
    required this.title,
    required this.description,
    required this.postimagePath,
    required this.isFavourite,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Post> posts = [
    //post list
    Post(
      name: 'Johnis',
      location: 'Spiti mou',
      avatar: 'assets/images/johnis.jpg',
      title: 'Xaroumenos johnis',
      description: 'arazw broskia loskia',
      postimagePath: 'assets/images/johnis.jpg',
      isFavourite: false,
    ),
    Post(
      name: 'Giorgos',
      location: 'Sth paralia',
      avatar: 'assets/images/giorgos_paralia.jpg',
      title: 'Edw na deite aragma',
      description: 'Plats plits',
      postimagePath: 'assets/images/giorgos_paralia.jpg',
      isFavourite: false,
    ),
    Post(
      name: 'Aggelos Ui/Ux',
      location: 'Sto ypogeio',
      avatar: 'assets/images/aggelos.jpg',
      title: 'Egw kai an arazw',
      description: 'Zzzzzz...',
      postimagePath: 'assets/images/random6.jpg',
      isFavourite: false,
    ),
    Post(
      name: 'Giorgos',
      location: 'Sthn epeixeirhsh',
      avatar: 'assets/images/giorgos_paralia.jpg',
      title: 'Chief financial officer',
      description: 'Kai milame kai prafit',
      postimagePath: 'assets/images/giorgos_cfo.jpg',
      isFavourite: false,
    ),
    // add more posts
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        // ignore: prefer_const_constructors
        title: Text(
          'Hangify',
          style: const TextStyle(
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
          children: [
            const SizedBox(height: 60.0),
            Expanded(
              child: SingleChildScrollView(
                child: CarouselSlider.builder(
                  itemCount: posts.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    final post = posts[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
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
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OthersProfilePage()),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(post.avatar),
                                  radius: 20.0,
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                                height: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 3.0),
                                  Text(post.location)
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            height: 300.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              image: DecorationImage(
                                image: AssetImage(post.postimagePath),
                                fit: BoxFit.cover,
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
                          const SizedBox(height: 5.0),
                          Row(
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
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 480.0,
                    viewportFraction: 0.8,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: true,
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
              onTap: () {},
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
