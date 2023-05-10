import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Awsome app", home: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Awsome app"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, blurRadius: 5, offset: Offset(2.0, 5.0))
              ],
              color: Colors.teal,
              gradient: LinearGradient(colors: [Colors.yellow, Colors.red])),
          child: Text(
            "I am a box",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}
