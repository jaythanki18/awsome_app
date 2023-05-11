import 'dart:convert';
import 'package:awsome_app/utils/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/change_name_card.dart';
import '../widgets/drawer.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameController = TextEditingController();
  var myText = "Login";
  var url = "https://jsonplaceholder.typicode.com/photos";
  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    //When data comes it will show data untill data does not come it will show other process
    var res = await http.get(Uri.parse(url));
    data = jsonDecode(res.body);
    print(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Awsome app"),
        actions: [
          IconButton(
              onPressed: (){
                Constants.prefs.setBool("loggedIn", false);
                Navigator.pushReplacementNamed(context, "/login");
              },
              icon: Icon(Icons.exit_to_app)
          )
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: data != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(data[index]["title"]),
                      subtitle: Text("ID: ${data[index]["id"]}") ,
                      leading: Image.network(data[index]["url"]),
                    ),
                  );
                },
                itemCount: data.length,
              )
            : Center(child: CircularProgressIndicator()),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myText = _nameController.text;
          setState(() {});
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
