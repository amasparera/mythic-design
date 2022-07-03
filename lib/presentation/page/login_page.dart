import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/size.dart';
import '../../common/thema_app.dart';
import '../provider/login_nothifier.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const String route = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              width: 350,
              alignment: Alignment.topRight,
              child: Image.asset("asset/icons/login image .png")),
          // _bodyLogin(),
          Consumer<LoginNothifier>(builder: (context, data, child) {
            return data.isLogin ? _bodyLogin(context) : _bodySingUp(context);
          })
        ],
      )),
    );
  }

  final _formKey = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String password = "";

  Widget _bodySingUp(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultPading),
        children: [
          const Padding(
            padding: EdgeInsets.only(
                left: defaultPading * 1.5, top: defaultPading * 2),
            child: Text(
              "SingUp",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .3),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPading),
            child: Text(
              "Enter your details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name';
              } else if (value.length <= 6) {
                return "Minimum 6 charakter";
              }
              return null;
            },
            onSaved: (value) {
              name = value!;
            },
            decoration: InputDecoration(
                hintText: "Name",
                hintStyle: const TextStyle(
                    color: placeholder, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none),
                fillColor: inputBacgroud,
                filled: true),
          ),
          const SizedBox(height: defaultPading),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              } else if (value.length <= 6) {
                return "Minimum 6 charakter";
              } else if (value.contains(" ")) {
                return "Forbidden to use space";
              }
              return null;
            },
            onSaved: (value) {
              email = value!;
            },
            decoration: InputDecoration(
                hintText: "Email",
                hintStyle: const TextStyle(
                    color: placeholder, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none),
                fillColor: inputBacgroud,
                filled: true),
          ),
          const SizedBox(height: defaultPading),
          TextFormField(
            obscureText: context.read<LoginNothifier>().obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              } else if (value.length <= 6) {
                return "Minimum 6 charakter";
              }
              return null;
            },
            onSaved: (value) {
              password = value!;
            },
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    context.read<LoginNothifier>().swipObscureText();
                  },
                  child: Icon(
                    context.read<LoginNothifier>().obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                hintText: "Password",
                hintStyle: const TextStyle(
                    color: placeholder, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none),
                fillColor: inputBacgroud,
                filled: true),
          ),
          Container(
            width: double.infinity,
            height: 50,
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.symmetric(
                horizontal: defaultPading, vertical: defaultPading * 2),
            decoration: BoxDecoration(
                color:
                    context.read<LoginNothifier>().valid ? Colors.grey : null,
                borderRadius: BorderRadius.circular(8),
                gradient: context.read<LoginNothifier>().valid
                    ? null
                    : const LinearGradient(
                        colors: [Color(0xff0038F5), Color(0xff9F03FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
            child: MaterialButton(
              onPressed: context.read<LoginNothifier>().valid
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        context.read<LoginNothifier>().singUp(
                              context,
                              name,
                              email,
                              password,
                            );
                      }
                    },
              child: context.read<LoginNothifier>().valid
                  ? const SizedBox(
                      height: 25, width: 25, child: CircularProgressIndicator())
                  : const Text(
                      "SingUp",
                      style: TextStyle(
                          color: offWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "do you already have an account?",
                style: TextStyle(fontWeight: FontWeight.bold, color: label),
              ),
              GestureDetector(
                onTap: () {
                  _formKey.currentState?.reset();
                  context.read<LoginNothifier>().swipLogin();
                },
                child: const Text(
                  " Login",
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff31A8FF),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Center(
            child: GestureDetector(
              onTap: () {
              context.read<LoginNothifier>().login(context, "demo@gmail.com", "demo12345");
              },
              child: const Text(
                "Login with demo acount",
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff31A8FF),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: defaultPading * 2)
        ],
      ),
    );
  }

  Widget _bodyLogin(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultPading),
        children: [
          const Padding(
            padding: EdgeInsets.only(
                left: defaultPading * 1.5, top: defaultPading * 2),
            child: Text(
              "Login",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .35),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPading),
            child: Text(
              "Enter your details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              } else if (value.length <= 6) {
                return "Minimum 6 charakter";
              } else if (value.contains(" ")) {
                return "Forbidden to use space";
              }
              return null;
            },
            onSaved: (value) {
              email = value!;
            },
            decoration: InputDecoration(
                hintText: "Email",
                hintStyle: const TextStyle(
                    color: placeholder, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none),
                fillColor: inputBacgroud,
                filled: true),
          ),
          const SizedBox(height: defaultPading),
          TextFormField(
            obscureText: context.read<LoginNothifier>().obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              } else if (value.length <= 6) {
                return "Minimum 6 charakter";
              }
              return null;
            },
            onSaved: (value) {
              password = value!;
            },
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    context.read<LoginNothifier>().swipObscureText();
                  },
                  child: Icon(
                    context.read<LoginNothifier>().obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                hintText: "Password",
                hintStyle: const TextStyle(
                    color: placeholder, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none),
                fillColor: inputBacgroud,
                filled: true),
          ),
          Container(
            width: double.infinity,
            height: 50,
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.symmetric(
                horizontal: defaultPading, vertical: defaultPading * 2),
            decoration: BoxDecoration(
                color:
                    context.read<LoginNothifier>().valid ? Colors.grey : null,
                borderRadius: BorderRadius.circular(8),
                gradient: context.read<LoginNothifier>().valid
                    ? null
                    : const LinearGradient(
                        colors: [Color(0xff0038F5), Color(0xff9F03FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
            child: MaterialButton(
              onPressed: context.read<LoginNothifier>().valid
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        context
                            .read<LoginNothifier>()
                            .login(context, email, password);
                      }
                    },
              child: context.read<LoginNothifier>().valid
                  ? const SizedBox(
                      height: 25, width: 25, child: CircularProgressIndicator())
                  : const Text(
                      "Login",
                      style: TextStyle(
                          color: offWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "do you not have an account?",
                style: TextStyle(fontWeight: FontWeight.bold, color: label),
              ),
              GestureDetector(
                onTap: () {
                  _formKey.currentState?.reset();
                  context.read<LoginNothifier>().swipLogin();
                },
                child: const Text(
                  " SingUp",
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff31A8FF),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Center(
            child: GestureDetector(
              onTap: () {
              context.read<LoginNothifier>().login(context, "demo@gmail.com", "demo12345");
              },
              child: const Text(
                "Login with demo acount",
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff31A8FF),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: defaultPading * 2)
        ],
      ),
    );
  }
}
