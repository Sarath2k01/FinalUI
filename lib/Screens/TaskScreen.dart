import 'dart:convert';

import 'package:daily_task/Myjson.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../app/constans/app_constants.dart';
import 'GGR.dart';

Future<Album> fetchData() async {
  String url = 'https://api.npoint.io/30df1b498ced4b9f8454';
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    try {
      final dynamic data = jsonDecode(response.body);
// Now you can access the values of the JSON object
      final album = Album.fromJson(data);
      return album;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to decode data from the API');
    }
  } else {
    throw Exception('Failed to load data from the API');
  }
}

makePostRequest(String ip, String name) async {
  print("makePostRequest" + ip + name);
  final uri = Uri.parse('http://httpbin.org/post');
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {'id': 21, 'name': 'bob'};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  final response = await http.post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  String responseBody = response.body;
}

class Album {
  final int numExecutors;
  final bool temporarilyOffline;

  const Album({
    required this.numExecutors,
    required this.temporarilyOffline,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      numExecutors: json['numExecutors'],
      temporarilyOffline: json['temporarilyOffline'],
    );
  }
}

Widget _buildStatus(String buttonText) {
  Color backgroundColor;
  Color textColor;

  if (buttonText == "False") {
    backgroundColor = Colors.red;
    textColor = Colors.white;
    buttonText = "Offline";
  } else if (buttonText == "Online") {
    backgroundColor = Colors.green;
    textColor = Colors.white;
  } else {
    // handle any other status if necessary
    backgroundColor = Colors.grey;
    textColor = Colors.black;
  }

  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Text(
      buttonText,
      style: TextStyle(color: textColor),
    ),
  );
}

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<ResourceFinder> searchlist = [];
  TextEditingController _controller = TextEditingController();
  List<String> buttonTexts = [];

  @override
  void initState() {
    super.initState();
    searchlist = mylist;
    // Initialize the buttonTexts list with a default value for each button
    buttonTexts = List.generate(searchlist.length, (_) => '-');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              prefixIcon: Icon(EvaIcons.search),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: .1),
              ),
              hintText: "search..",
            ),
            textInputAction: TextInputAction.search,
            onChanged: (value) {
              searchAppointments(value);
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, i) => SizedBox(height: 8),
              itemCount: searchlist.length,
              itemBuilder: (_, i) {
                return Row(
                  children: [
                    Expanded(
                        child: ListTile(
                            onTap: () {},
                            hoverColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius),
                            ),
                            leading: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 50,
                              height: 50,
                              child: searchlist[i].type == "Selenoid"
                                  ? const Icon(Icons.star, color: Colors.amber)
                                  : searchlist[i].type == "GGR"
                                      ? const Icon(Icons.check,
                                          color: Colors.green)
                                      : const Icon(Icons.warning,
                                          color: Colors.red),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                children: [
                                  Text(searchlist[i].name.toString()),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      fetchData().then((album) {
                                        setState(() {
                                          buttonTexts[i] = capitalize(album
                                              .temporarilyOffline
                                              .toString());
                                        });
                                      });
                                    },
                                    child: const Text('Get Status'),
                                  ),
                                  const SizedBox(width: 25),
                                  SizedBox(
                                    width: 80,
                                    child: Center(
                                      child: buttonTexts[i] == null
                                          ? const Text('-')
                                          : _buildStatus(buttonTexts[i]),
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                ],
                              ),
                            ),
                            subtitle: Text(searchlist[i].ip.toString()),
                            trailing: PopupMenuButton(
                              onSelected: (value) {
                                if (value == "0") {
                                } else if (value == "1") {
                                  makePostRequest(
                                      searchlist[i].ip.toString(), "xy");
                                } else {
                                  print("Nothing");
                                }
                              },
                              //Add code to button here
                              itemBuilder: (BuildContext bc) {
                                if (searchlist[i].type == "Selenoid") {
                                  return [
                                    PopupMenuItem(
                                      child: Text("Selenoid Restart"),
                                      value: '0',
                                      onTap: () {
                                        const String urlPrefix =
                                            "http://localhost:8080/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken?newTokenName=";
                                        String tokenName =
                                            searchlist[i].ip.toString();
                                        String url = urlPrefix + tokenName;

                                        if (searchlist[i].type == "Selenoid") {
                                          url += "_selenoid";
                                        } 
                                        print(url);
                                      },
                                    ),
                                    const PopupMenuItem(
                                      child: Text("Selenoid Update"),
                                      value: '1',
                                    ),
                                    const PopupMenuItem(
                                      child: Text("Selenoid Space Check"),
                                      value: '2',
                                    ),
                                  ];
                                } else if (searchlist[i].type == "GGR") {
                                  return [
                                    const PopupMenuItem(
                                      child: Text("GGR Restart"),
                                      value: '0',
                                    ),
                                    const PopupMenuItem(
                                      child: Text("GGR Update"),
                                      value: '1',
                                    ),
                                    const PopupMenuItem(
                                      child: Text("GGR Space Check"),
                                      value: '2',
                                    ),
                                  ];
                                } else {
                                  return [
                                    const PopupMenuItem(
                                      child: Text("Jenkins Restart"),
                                      value: '0',
                                    ),
                                    const PopupMenuItem(
                                      child: Text("Jenkins Update"),
                                      value: '1',
                                    ),
                                    const PopupMenuItem(
                                      child: Text("Jenkins Space Check"),
                                      value: '2',
                                    ),
                                  ];
                                }
                              },
                            )))
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchAppointments(String query) {
    var mysuggestions = mylist.where((element) {
      final name = element.name.toString().toLowerCase();
      final ip = element.ip.toString();
      final input = query.toLowerCase();
      return name.contains(input) || ip.contains(input);
    }).toList();
    setState(() {
      searchlist = mysuggestions;
    });
  }
}
