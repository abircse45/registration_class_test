import 'package:authentication_part/model/registrion_model.dart';
import 'package:authentication_part/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late RegisterModel  _registerModel;

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: Text("Registrion Screen"),
      ),
      body: Form(
        key:key ,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28, bottom: 15),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please add your fullname";
                    }
                  },
                  controller: fullnameController,
                  decoration: InputDecoration(
                      hintText: "Full Name",
                      labelText: "Full Name",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28, bottom: 15),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please add your phone number";
                    }
                  },
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                      hintText: "Phone Number",
                      labelText: "Phone Number",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28, bottom: 15),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please add your email";
                    }
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email",
                      labelText: "Email",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28, bottom: 15),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please add your password";
                    }
                  },
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
              GestureDetector(
                onTap: () {
                  if(key.currentState!.validate()){
                    registrationPost();
                  }else{

                  }

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
                      "Registration",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<RegisterModel?> registrationPost() async {
    Map<String, dynamic> body = {
      "FullName": "${fullnameController.text}",
      "Username": "${phoneNumberController.text}",
      "Email": "${emailController.text}",
      "Pswd": "${passwordController.text}",

    };

    var response = await http.post(
      Uri.parse("https://srvc.aide.com.bd/api/Auth/register"),
      headers: {
        "Accept": "application/json",
      },
      body: body,
    );
    _registerModel =  registerModelFromJson(response.body);

    if (response.statusCode == 200) {
      setState(() {
        Fluttertoast.showToast(
            msg: "${_registerModel.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print("Response___${response.body}");
        Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginScreen()));
      });
    }
    else if(response.statusCode==400){
      Fluttertoast.showToast(
          msg: "${_registerModel.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}
