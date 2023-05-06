import 'package:ecommerc_app/api/api.services.dart';
import 'package:ecommerc_app/colors.dart';
import 'package:ecommerc_app/models/home_content.dart';
import 'package:ecommerc_app/view/screen/register_screen.dart';
import 'package:ecommerc_app/view/splash_screen/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(HomeContent.bgImage.toString()),
                  fit: BoxFit.cover)),
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome Back',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please Login !',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      icon: Icon(Icons.email),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white),
                child: TextField(
                  controller: passController,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      icon: Icon(Icons.lock),
                      border: InputBorder.none),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  decoration: BoxDecoration(
                      color: MyColor.baseColor4,
                      borderRadius: BorderRadius.circular(25)),
                  width: 100,
                  height: 45,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        // HomeContent.isLoggedIn = true;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (content) => const SplashScreen()));
                        Api.email = emailController.text;
                        Api.password = passController.text;
                        if (Api.email.trim() != "" &&
                            Api.password.trim() != "") {
                          Api.fetchUsers(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Both field required')));
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'New Customer ?',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const RegisterScreen()));
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*


ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                HomeContent.dpImg,
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ) */