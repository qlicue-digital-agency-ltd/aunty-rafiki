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
    fetchPosts(userId: 1);
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
  Future<void> fetchPosts({@required int userId}) async {
    _isFetchingData = true;
    notifyListeners();
    List<Post> _fetchedPosts = [];
    final Map<String, dynamic> _data = {
      'user_id': userId,
    };

    try {
      final http.Response response =
          await http.post(api + "posts", body: json.encode(_data));

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['posts'].forEach((data) {
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
