import 'package:flutter/material.dart';

class MongoDBScreen extends StatefulWidget {
  const MongoDBScreen({ Key? key }) : super(key: key);

  @override
  _MongoDBScreenState createState() => _MongoDBScreenState();
}

class _MongoDBScreenState extends State<MongoDBScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      height: size.height,
      width: size.width,
      child: const Center(
        child: Text(
          'Coming Soon...!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
