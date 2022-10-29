import 'package:authentication_part/local/my_pref.dart';
import 'package:authentication_part/model/login_error_model.dart';
import 'package:authentication_part/model/login_model.dart';
import 'package:authentication_part/screens/home_screen.dart';
import 'package:authentication_part/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loginLoader = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late LoginModel _loginModel;
  late LoginErrorModel _loginErrorModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        title: Text("Login Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 20),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    labelText: "Phone Number",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 20),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 30,
            ),
         loginLoader ? Center(child: CircularProgressIndicator(),) :   GestureDetector(
              onTap: () {
                login();
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 28.0, right: 28, bottom: 15),
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.purple.shade300),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegistrationScreen()));
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 28.0, right: 28, bottom: 15),
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.purple.shade300),
                  child: Text(
                    "Go to Register page",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<LoginModel?> login() async {

    setState(() {
      loginLoader = true;
    });
    Map<String, dynamic> body = {
      "Username": "${phoneController.text}",
      "Password": "${passwordController.text}",
      "grant_type": "password",
    };

    var response = await http.post(
      Uri.parse("https://srvc.aide.com.bd/token"),
      body: body,
      headers: {"Accept": "application/json"},
    );
    _loginModel = loginModelFromJson(response.body);

    if (response.statusCode == 200) {

        Fluttertoast.showToast(
            msg: "${_loginModel.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        setState(() {
          loginLoader = false;
        });
        MyPreference.setToken(_loginModel.accessToken.toString());

        print("Response__-${response.body}");
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));

    }else if(response.statusCode==400) {
      _loginErrorModel = loginErrorModelFromJson(response.body);
      Fluttertoast.showToast(
          msg: "${_loginErrorModel.errorDescription.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

    }
  }
}
