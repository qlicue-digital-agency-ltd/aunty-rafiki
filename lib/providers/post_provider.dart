import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
import 'package:aunty_rafiki/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostProvider with ChangeNotifier {
  //variable declaration
  bool _isFetchingData = false;
  List<Post> _availablePosts = [];
  bool _isSubmitingCommentData = false;
  List<DropdownMenuItem> _categoryList = [];

  PostProvider() {
    fetchPosts();
  }

//getters
  bool get isFetchingData => _isFetchingData;

  List<Post> get availablePosts => _availablePosts;
  List<DropdownMenuItem> get categoryList => _categoryList;

  bool get isSubmitingCommentData => _isSubmitingCommentData;
  // //setters
  set setSelectedPostList(List<Post> postList) {
    _availablePosts = postList;
    notifyListeners();
  }

//http requests
  Future<void> fetchPosts() async {
    _isFetchingData = true;
    notifyListeners();
    List<Post> _fetchedPosts = [];

    try {
      final http.Response response = await http.get(Uri.parse(api + "posts"));

      final Map<String, dynamic> data = json.decode(response.body);
      print('---------------------------------------------');
      print(data);
      print('---------------------------------------------');
      if (response.statusCode == 200) {
        data['data'].forEach((data) {
          final post = Post.fromMap(data);
          _fetchedPosts.add(post);
        });
      }
    } catch (error) {
      print(error);
    }

    _availablePosts = _fetchedPosts;
    _isFetchingData = false;
    print(_availablePosts);
    notifyListeners();
  }
}
