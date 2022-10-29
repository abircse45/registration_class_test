import 'package:authentication_part/local/my_pref.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String ? token;
    void getToken ()async{
      MyPreference.getToken().then((value) {
       setState(() {
         token = value;
       });
      });
    }

    @override
  void initState() {

      getToken();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Center(
        child: Text("${token}",style: TextStyle(fontSize: 24),),
      ),
    );
  }
}
