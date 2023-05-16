import 'package:flutter/material.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    Size size  =MediaQuery.of(context).size;
    return Container(
      
      color: Colors.purple,
      height: 100,
      width: 100,
    );
  }
}
