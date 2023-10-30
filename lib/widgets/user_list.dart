import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../const.dart';
import 'add_user.dart';


class USerListPage extends StatefulWidget {
  const USerListPage({super.key});

  @override
  State<USerListPage> createState() => _USerListPageState();
}

class _USerListPageState extends State<USerListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Book Appointment'),
            backgroundColor: purple,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) {
                        return Student(null);
                      }),
                    )).then(((value) {
                      setState(() {
                        getUser();
                      });
                    }));
                  },
                  child: const Icon(
                    Icons.add_rounded ,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
          body: FutureBuilder<http.Response>(
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.hasData) {
                return ListView.builder(
                  itemCount: jsonDecode(snapshot.data!.body.toString()).length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return Student(
                                jsonDecode(snapshot.data!.body.toString())[index].toString());
                          },
                        )).then(
                              (value) {
                            setState(() {
                              getUser();
                            });
                          },
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              color: transparent,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          (jsonDecode(snapshot.data!.body.toString())[
                                          index]['Firstname'])
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 5,),
                                        Text(
                                          (jsonDecode(snapshot.data!.body.toString())[
                                          index]['Lastname'])
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      (jsonDecode(snapshot.data!.body.toString())[
                                      index]['Mobilenumber'])
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                    Text(
                                      (jsonDecode(snapshot.data!.body.toString())[
                                      index]['Email'])
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                    // Text(
                                    //   (jsonDecode(snapshot.data!.body.toString())[
                                    //   index]['salary'])
                                    //       .toString(),
                                    //   style: TextStyle(
                                    //       fontSize: 13, color: Colors.grey.shade600),
                                    // ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Container(
                                    //   padding: EdgeInsets.only(right: 20),
                                    //   child: InkWell(
                                    //     onTap: () {
                                    //       Navigator.of(context).push(MaterialPageRoute(
                                    //         builder: (context) {
                                    //           return AddEmployee(jsonDecode(snapshot
                                    //               .data!.body
                                    //               .toString())[index]);
                                    //         },
                                    //       )).then(
                                    //         (value) {
                                    //           setState(() {
                                    //             getUser();
                                    //           });
                                    //         },
                                    //       );
                                    //     },
                                    //     child: Icon(Icons.edit),
                                    //   ),
                                    // ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20),
                                      child: InkWell(
                                        onTap: () {
                                          alert(jsonDecode(snapshot.data!.body
                                              .toString())[index]['id'].toString());
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            future: getUser(),
          ),
        ));
  }

  void alert(id) {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you Sure Want To Delete ?'),
          actions: [
            TextButton(
                onPressed: ((() async {
                  http.Response res = await deleteUser(id);
                  if (res.statusCode == 200) {
                    setState(() {});
                  }
                  Navigator.of(context).pop();
                })),
                child: Text('Yes')),
            TextButton(
                onPressed: ((() {
                  Navigator.of(context).pop();
                })),
                child: Text('No')),
          ],
        );
      }),
    );
  }

  Future<http.Response> getUser() async {
    var res = await http
        .get(Uri.parse('https://63f5d3c659c944921f6741f9.mockapi.io/Student'));

    return res;
  }

  Future<http.Response> deleteUser(id) async {
    // print(id);
    var response1 = await http.delete(
        Uri.parse("https://63f5d3c659c944921f6741f9.mockapi.io/Student/" + id));
    return response1;
  }
}
