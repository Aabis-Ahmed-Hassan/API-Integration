import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersGetApiWithoutModal extends StatefulWidget {
  const UsersGetApiWithoutModal({super.key});

  @override
  State<UsersGetApiWithoutModal> createState() =>
      _UsersGetApiWithoutModalState();
}

class _UsersGetApiWithoutModalState extends State<UsersGetApiWithoutModal> {
  var data;
  Future<void> getUsersDataWithoutModal() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      print('success');
      print(data);
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Api For Users Without Modal.'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsersDataWithoutModal(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('loading');

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print('data loaded in future function');

                  return ListView.builder(
                    itemCount: data.length,
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
                              Text(data[index]['id'].toString()),
                              Text(data[index]['name'].toString()),
                              Text(data[index]['username'].toString()),
                              Text(data[index]['email'].toString()),
                              Text(
                                  data[index]['address']['zipcode'].toString()),
                              Text(data[index]['address']['city'].toString()),
                              Text(data[index]['address']['street'].toString()),
                              Text(data[index]['address']['suite'].toString()),
                              Text(data[index]['address']['geo']['lng']
                                  .toString()),
                              Text(data[index]['address']['geo']['lat']
                                  .toString()),
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
