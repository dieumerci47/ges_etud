import 'package:flutter/material.dart';
import 'package:ges_etud/aimation/delayed_animtion.dart';
import 'package:ges_etud/main.dart';
import 'package:ges_etud/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: d_blue, size: 25),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                DelayedAnimation(
                  delay: 1500,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.15),
                    ),
                    child: Icon(
                      Icons.admin_panel_settings,
                      size: 60,
                      color: d_blue,
                    ),
                  ),
                ),
                //TEXT
                DelayedAnimation(
                  delay: 2000,
                  child: Container(
                    child: Text(
                      "Connexion",
                      style: TextStyle(
                        color: d_blue,
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                DelayedAnimation(
                  delay: 2000,
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      "Connectez-vous pour continuer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 24,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DelayedAnimation(
                  delay: 2500,
                  child: Container(margin: EdgeInsets.all(20), child: _form()),
                ),
                SizedBox(height: 10),
                DelayedAnimation(
                  delay: 3500,
                  child: Container(
                    // padding: EdgeInsets.all(20),
                    padding: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        backgroundColor: d_blue,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Se connecter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 5),
                DelayedAnimation(
                  delay: 4000,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Mot de passe oublié ?",
                        style: TextStyle(color: d_blue, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Adresse email",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez entrer votre email";
              }
              return null;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              // labelText: "Email",
              labelStyle: TextStyle(color: Colors.red),
              // fillColor: Colors.grey.shade200,
              fillColor: Colors.yellow.withOpacity(0.08),
              filled: true,
              // prefixIcon: Icon(Icons.email, color: d_blue),
              suffixIcon: Icon(Icons.email_outlined, color: Colors.black),
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Mot de passe",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),

          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez entrer votre mot de passe";
              }
              return null;
            },
            obscureText: _isObscure,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.yellow.withOpacity(0.08),

              // labelText: "Mot de passe",
              // prefixIcon: Icon(Icons.lock, color: d_blue),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(
                  _isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
