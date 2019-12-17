import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:samashti_app/data/data_contract.dart';
import 'package:samashti_app/data/data_dbhelper.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/post_model.dart';
import 'package:sqflite/sqflite.dart';

class PostProvider extends ChangeNotifier {
  DBHelper _dbHelper;

  PostProvider() {
    this._dbHelper = new DBHelper();
  }

  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> allPosts = new List();
    Database db = await _dbHelper.database;
    var allValidPost = await db.query(PostTable.tableName,
        where: "${PostTable.colPostReported}=?", whereArgs: [0], orderBy: "${PostTable.colPostId} DESC");
    allValidPost.forEach((post) => allPosts.add(PostModel.fromJson(post)));
    return allPosts;
  }

  Future<List<PostModel>> getUserPost(int userId) async {
    List<PostModel> allUsersPost = new List();
    Database db = await _dbHelper.database;
    var allUsersPostRaw = await db.query(PostTable.tableName,
        where: "${PostTable.colUserId}=?", whereArgs: [userId]);
    allUsersPostRaw.map((Map<String, dynamic> post) =>
        allUsersPost.add(PostModel.fromJson(post)));
    return allUsersPost;
  }

  Future<String> insertNewPost(var postData) async {
    Database db = await _dbHelper.database;
    String serverResponse = await NetworkHelper.getInstance()
        .performPostRequest(postData, "/post/");

    if (serverResponse != null) {
      var serverJsonResponse = json.decode(serverResponse);
      if (serverJsonResponse != null && serverJsonResponse["error"] == null) {
        var postData = serverJsonResponse["response"]["result"];
        PostModel newPost = PostModel.fromJson(postData);
        db.insert(PostTable.tableName, newPost.toJson());
        return "New Post updated";
      } else {
        return null;
      }
    }
  }
}
