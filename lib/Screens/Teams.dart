import 'dart:convert';
import 'package:daily_task/Myjson.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../app/constans/app_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Response response = await post(
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
  // final boolean offline;
  final bool temporarilyOffline;

  const Album({
    required this.numExecutors,
    // required this.offline,
    required this.temporarilyOffline,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      numExecutors: json['numExecutors'],
      // offline: json['offline'],
      temporarilyOffline: json['temporarilyOffline'],
    );
  }
}

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({Key? key}) : super(key: key);

  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  List<ResourceFinder> searchlist = [];
  final TextEditingController _controller = TextEditingController();
  List<String> buttonTexts = [];

  @override
  void initState() {
    super.initState();
    searchlist = mylist;
    // Initialize the buttonTexts list with a default value for each button
    buttonTexts = List.generate(searchlist.length, (_) => '-');
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
            itemCount:
                searchlist.where((element) => element.type == "GGR").length,
            itemBuilder: (_, i) {
              final filteredList =
                  searchlist.where((element) => element.type == "GGR").toList();
              return Row(
                children: [
                  Expanded(
                      child: ListTile(
                          onTap: () {},
                          hoverColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kBorderRadius),
                          ),
                          leading: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 50,
                            height: 50,
                            child: filteredList[i].type == "Selenoid"
                                ? Icon(Icons.star, color: Colors.amber)
                                : filteredList[i].type == "GGR"
                                    ? Icon(Icons.check, color: Colors.green)
                                    : Icon(Icons.warning, color: Colors.red),
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
                          subtitle: Text(filteredList[i].ip.toString()),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == "0") {
                              } else if (value == "1") {
                                makePostRequest("1.1.1.1", "xy");
                              } else {
                                print("Nothing");
                              }
                            },
                            itemBuilder: (BuildContext bc) {
                              if (filteredList[i].type == "Selenoid") {
                                return [
                                  const PopupMenuItem(
                                    value: "0",
                                    child: Text("Print Name and IP"),
                                  ),
                                  const PopupMenuItem(
                                    value: "1",
                                    child: Text("Send to 1.1.1.1"),
                                  ),
                                ];
                              } else if (filteredList[i].type == "GGR") {
                                return [
                                  const PopupMenuItem(
                                    value: "0",
                                    child: Text("Print Name and IP"),
                                  ),
                                  const PopupMenuItem(
                                    value: "2",
                                    child: Text("Send to 2.2.2.2"),
                                  ),
                                ];
                              } else {
                                return [
                                  const PopupMenuItem(
                                    value: "0",
                                    child: Text("Print Name and IP"),
                                  ),
                                ];
                              }
                            },
                          ))),
                ],
              );
            },
          )),
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
