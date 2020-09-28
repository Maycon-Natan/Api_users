import 'dart:convert';
import 'dart:async';
import 'package:app_api/pages/API.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Api> _api;

  Future<List<Api>> _getUser() async {
    try {
      List<Api> listUser = List();
      final response =
          await http.get('https://jsonplaceholder.typicode.com/users');

      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listUser.add(Api.fromJson(item)));
        return listUser;
      } else {
        print('Error ao Carregar Lista');
        return null;
      }
    } catch (e) {
      print('Error ao Carregar Lista');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser().then((map) {
      _api = map;
      print(_api.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: _api.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  height: 80,
                  color: Colors.cyan[400],
                  child: Column(
                    children: [
                      Text(_api[index].id.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(_api[index].name),
                      Text(_api[index].email),
                      Text(_api[index].phone),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
