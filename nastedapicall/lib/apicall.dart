import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCall extends StatefulWidget {
  const ApiCall({Key? key}) : super(key: key);

  @override
  _ApiCallState createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Api Call"),
          elevation: 0.1,
          backgroundColor: Colors.black87),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("loading");
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ReusbaleRow(
                                title: 'id',
                                value: data[index]['id'].toString()),
                            ReusbaleRow(
                                title: 'name',
                                value: data[index]["name"].toString()),
                            ReusbaleRow(
                                title: 'username',
                                value: data[index]['username'].toString()),
                            ReusbaleRow(
                                title: 'email',
                                value: data[index]['email'].toString()),
                            ReusbaleRow(
                                title: 'adddress',
                                value: data[index]['address']['street']
                                    .toString()),
                            ReusbaleRow(
                                title: 'phone',
                                value: data[index]['phone'].toString()),
                            ReusbaleRow(
                                title: 'website',
                                value: data[index]['website'].toString()),
                            // ReusbaleRow(title: 'company', value: data[index]['company'].toString()),
                            // ReusbaleRow(title: 'company', value: data[index]['name'].toString()),
                          ],
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

class ReusbaleRow extends StatelessWidget {
  String title, value;
  ReusbaleRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
