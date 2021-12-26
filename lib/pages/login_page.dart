import 'package:first_flutter/utils/routs.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRouts.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.canvasColor,
      child: SingleChildScrollView (
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset("assets/images/login_image.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20,),
              Text("Welcome $name",
                style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Enter username",
                        labelText: "Username",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty credentials";
                        }

                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Enter password",
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty credentials";
                        } else if (value.length<6) {
                        return "Password to short";
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              Material(
                color: context.theme.buttonColor,
                borderRadius: BorderRadius.circular(changeButton ?50 : 8),
                child: InkWell(
                  onTap: () => moveToHome(context),
                  child: AnimatedContainer (
                    duration: Duration(seconds: 1),
                    width: changeButton ? 60 : 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: changeButton ? Icon(Icons.done, color: Colors.white,) : const Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 300,),
            ],
          ),
        ),
      ),
    );
  }
}
