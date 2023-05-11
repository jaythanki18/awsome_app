import 'dart:convert';
import 'package:awsome_app/utils/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/change_name_card.dart';
import '../widgets/drawer.dart';
import 'package:http/http.dart' as http;

class HomePageWithFB extends StatefulWidget {
  const HomePageWithFB({Key? key}) : super(key: key);

  @override
  State<HomePageWithFB> createState() => _HomePageWithFBState();
}

class _HomePageWithFBState extends State<HomePageWithFB> {

  var url = "https://jsonplaceholder.typicode.com/photos";
  var data;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getData();
  // }

  Future getData() async {
    //When data comes it will show data untill data does not come it will show other process
    var res = await http.get(Uri.parse(url));
    data = jsonDecode(res.body);
    print(data);
    return data;
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

      body: FutureBuilder(
        future: getData(),
          builder: (context,snapshot){
            switch (snapshot.connectionState){
              case ConnectionState.none:
                return Center(child: Text("Fetch something"),
                );
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                if(snapshot.hasError){
                  return Center(child: Text("Some error occured"),);
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(snapshot.data[index]["title"]),
                        subtitle: Text("ID: ${snapshot.data[index]["id"]}") ,
                        leading: Image.network(snapshot.data[index]["url"]),
                      ),
                    );
                  },
                  itemCount: data.length,
                );
            }
          }
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // myText = _nameController.text;
          // setState(() {});
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
