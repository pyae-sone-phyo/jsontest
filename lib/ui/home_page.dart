import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsontest/model/user.dart';
import 'package:jsontest/network/apis.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User _user;
  bool _isLoading = true;
  getUser() async {
    Api.fetchPost().then((response) {
      print(response.statusCode);
      final data = json.decode(response.body);
      User user = User.fromJson(data);
      if (response.statusCode == 200) {
        if (this.mounted) {
          setState(() {
            this._user = user;
            _isLoading = false;
          });
        }
      } else {
        throw Exception("Fail to get user data");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Json Test"),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListTile(
                leading: CircleAvatar(
                  child: Text(_user.id.toString()),
                  backgroundColor: Colors.amber,
                ),
                title: Text(_user.title),
                subtitle: Text(_user.body),
              ));
  }
}
