import 'dart:convert';

import 'package:api_integration/modals/UsersModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersFromGetApi extends StatefulWidget {
  const UsersFromGetApi({super.key});

  @override
  State<UsersFromGetApi> createState() => _UsersFromGetApiState();
}

class _UsersFromGetApiState extends State<UsersFromGetApi> {
  List<UsersModal> _myusers = [];

  Future<List<UsersModal>> getUsers() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      _myusers.clear();

      var data = jsonDecode(response.body);
      for (Map<String, dynamic> i in data) {
        _myusers.add(UsersModal.fromJson(i));
      }

      return _myusers;
    } else {
      return _myusers;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Api For Users'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: _myusers.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text(_myusers[index].id.toString()),
                              Text(_myusers[index].name.toString()),
                              Text(_myusers[index].username.toString()),
                              Text(_myusers[index].email.toString()),
                              Text(_myusers[index].address!.zipcode.toString()),
                              Text(_myusers[index].address!.city.toString()),
                              Text(_myusers[index].address!.street.toString()),
                              Text(_myusers[index].address!.suite.toString()),
                              Text(
                                  _myusers[index].address!.geo!.lng.toString()),
                              Text(
                                  _myusers[index].address!.geo!.lat.toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
