import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

import 'modals/CommentsModal.dart';

class CommentsGetApiScreen extends StatefulWidget {
  CommentsGetApiScreen({super.key});

  @override
  State<CommentsGetApiScreen> createState() => _CommentsGetApiScreenState();
}

class _CommentsGetApiScreenState extends State<CommentsGetApiScreen> {
  List<CommentsModal> _myComments = [];

  Future<List<CommentsModal>> getComments() async {
    var response = await myhttp.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (Map<String, dynamic> i in data) {
        _myComments.add(CommentsModal.fromJson(i));
      }

      return _myComments;
    } else {
      return _myComments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Api'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getComments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: _myComments.length,
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
                              Text(_myComments[index].postId.toString()),
                              Text(_myComments[index].id.toString()),
                              Text(_myComments[index].name.toString()),
                              Text(_myComments[index].email.toString()),
                              Text(_myComments[index].body.toString()),
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
