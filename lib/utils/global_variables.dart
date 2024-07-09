import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';

const webScreenSize = 900;

const homeScreenItems = [
  FeedScreen(),
  Center(child: Text('Search')),
  AddPostScreen(),
  Center(child: Text('Like')),
  Center(child: Text('Profile')),
];
