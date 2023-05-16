import 'dart:convert';
import 'package:daily_task/Screens/SelectedTeamCards.dart';
import 'package:daily_task/app/utils/helpers/app_helpers.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<Album> fetchData() async {
  String url = 'https://api.npoint.io/30df1b498ced4b9f8454';
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final dynamic data = jsonDecode(response.body);
    final album = Album.fromJson(data);
    return album;
  } else {
    throw Exception('Failed to load data from the API');
  }
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

class CardTaskData {
  final String label;
  final String jobDesk;
  final DateTime dueDate;

  const CardTaskData({
    required this.label,
    required this.jobDesk,
    required this.dueDate,
  });
}

class CardTask extends StatelessWidget {
  const CardTask({
    required this.data,
    required this.primary,
    required this.onPrimary,
    Key? key,
  }) : super(key: key);

  final CardTaskData data;
  final Color primary;
  final Color onPrimary;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectedTeamScreen(
                      teamname: data.label,
                      key: null,
                    )),
          ),
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(.7)],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              ),
            ),
            child: _BackgroundDecoration(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildLabel(),
                          const SizedBox(height: 20),
                          _buildJobdesk(),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDate(),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            thickness: 1,
                            color: onPrimary,
                          ),
                        ),
                        _buildHours(),
                      ],
                    ),
                    const Spacer(flex: 2),
                    _doneButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Text(
      data.label,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: onPrimary,
          letterSpacing: 1),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildJobdesk() {
    return Container(
      decoration: BoxDecoration(
        color: onPrimary.withOpacity(.3),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        data.jobDesk,
        style: TextStyle(
          color: onPrimary,
          fontSize: 10,
          letterSpacing: 1,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDate() {
    return _IconLabel(
      color: onPrimary,
      iconData: EvaIcons.calendarOutline,
      label: DateFormat('d MMM').format(data.dueDate),
    );
  }

  Widget _buildHours() {
    return _IconLabel(
      color: onPrimary,
      iconData: EvaIcons.clockOutline,
      label: data.dueDate.dueDate(),
    );
  }

  Widget _doneButton() {
    return ElevatedButton.icon(
      onPressed: () {
        fetchData().then((album) {
          Fluttertoast.showToast(
            msg: 'Status: ${album.temporarilyOffline}',
            gravity: ToastGravity.BOTTOM,
          );
        });
      },
      style: ElevatedButton.styleFrom(
        primary: onPrimary,
        onPrimary: primary,
      ),
      icon: const Icon(EvaIcons.checkmarkCircle2Outline),
      label: const Text("Done"),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({
    required this.color,
    required this.iconData,
    required this.label,
    Key? key,
  }) : super(key: key);

  final Color color;
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
          size: 18,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(.8),
          ),
        )
      ],
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  const _BackgroundDecoration({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Transform.translate(
            offset: const Offset(25, -25),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Transform.translate(
            offset: const Offset(-70, 70),
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class DuplicateCardTaskData {
  final String label;
  //final String jobDesk;
  //final DateTime dueDate;
  final int numberOfMachines;

  const DuplicateCardTaskData({
    required this.label,
    //required this.jobDesk,
    //required this.dueDate,
    required this.numberOfMachines,
  });

  DuplicateCardTaskData copyWith({
    String? label,
    //String? jobDesk,
    //DateTime? dueDate,
    int? numberOfMachines,
  }) {
    return DuplicateCardTaskData(
      label: label ?? this.label,
      //jobDesk: jobDesk ?? this.jobDesk,
      //dueDate: dueDate ?? this.dueDate,
      numberOfMachines: numberOfMachines ?? this.numberOfMachines,
    );
  }
}

class DuplicateCardTask extends StatelessWidget {
  const DuplicateCardTask({
    required this.data,
    required this.primary,
    required this.onPrimary,
    Key? key,
  }) : super(key: key);

  final DuplicateCardTaskData data;
  final Color primary;
  final Color onPrimary;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(.7)],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              ),
            ),
            child: _BackgroundDecoration(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 126,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildLabel(),
                          const SizedBox(height: 40),
                          _buildNumberOfMachines(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Text(
      data.label,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: onPrimary,
        letterSpacing: 1,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildNumberOfMachines() {
    return FutureBuilder<Album>(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<Album> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading spinner while the data is being fetched
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
                SizedBox(height: 6),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          // Display an error message if the data failed to load
          return Text('Error: ${snapshot.error}');
        } else {
          // Display the number of machines
          return Center(
            child: Text(
              '${snapshot.data!.numExecutors}',
              style: TextStyle(
                color: onPrimary,
                fontSize: 45,
                letterSpacing: 1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
      },
    );
  }

  // Widget _buildJobdesk() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: onPrimary.withOpacity(.3),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //     child: Text(
  //       data.jobDesk,
  //       style: TextStyle(
  //         color: onPrimary,
  //         fontSize: 10,
  //         letterSpacing: 1,
  //       ),
  //       maxLines: 1,
  //       overflow: TextOverflow.ellipsis,
  //     ),
  //   );
  // }

  // Widget _buildDate() {
  //   return _IconLabel(
  //     color: onPrimary,
  //     iconData: EvaIcons.calendarOutline,
  //     label: DateFormat('d MMM').format(data.dueDate),
  //   );
  // }

  // Widget _buildHours() {
  //   return _IconLabel(
  //     color: onPrimary,
  //     iconData: EvaIcons.clockOutline,
  //     label: data.dueDate.dueDate(),
  //   );
  // }

  Widget _doneButton() {
    return ElevatedButton.icon(
      onPressed: () {
        fetchData().then((album) {
          Fluttertoast.showToast(
            msg: 'Status: ${album.numExecutors}',
            gravity: ToastGravity.BOTTOM,
          );
        });
      },
      style: ElevatedButton.styleFrom(
        primary: onPrimary,
        onPrimary: primary,
      ),
      icon: const Icon(EvaIcons.checkmarkCircle2Outline),
      label: const Text("Refresh"),
    );
  }
}

class _IconLabelDuplicate extends StatelessWidget {
  const _IconLabelDuplicate({
    required this.color,
    required this.iconData,
    required this.label,
    Key? key,
  }) : super(key: key);

  final Color color;
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
          size: 18,
        ),
        //const SizedBox(width: 1),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(.8),
          ),
        )
      ],
    );
  }
}
