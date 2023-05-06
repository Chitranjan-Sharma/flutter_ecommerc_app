

import 'package:ecommerc_app/api/api.services.dart';
import 'package:ecommerc_app/colors.dart';
import 'package:ecommerc_app/models/home_content.dart';
import 'package:ecommerc_app/models/user.model.dart';
import 'package:ecommerc_app/view/screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

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
                    'Hey, Welcome',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please Register !',
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
                  controller: userNameController,
                  decoration: const InputDecoration(
                      hintText: 'Username',
                      icon: Icon(Icons.person),
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
                        registerUser();
                      },
                      child: const Text(
                        'Register',
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
                    'Existing Customer ?',
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
                              builder: (content) => const LoginScreen()));
                    },
                    child: const Text(
                      'Login',
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

  void registerUser() {
    if (emailController.text.trim() != "" && passController.text.trim() != "") {
      UserModel userModel = UserModel(
          id: "",
          userName: userNameController.text,
          email: emailController.text,
          password: passController.text,
          profileImg: "default");

      Api.postUser(userModel, context);
    }
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