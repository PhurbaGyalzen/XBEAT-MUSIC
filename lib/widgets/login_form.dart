import "package:flutter/material.dart";
import "../theme/colors.dart";

class PasswordFieldValidator {
  static String? validate(String value) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value.isEmpty) {
      return ("Password is required for login");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid Password(Min. 6 Character)");
    }
    return null;
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool hiddenPassword = true;
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        key: Key('emailFieldKey'),
        autofocus: false,
        style: TextStyle(color: black),
        controller: usernameController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email or Username");
          }
          return null;
        },
        onSaved: (value) {
          usernameController.text = value!;
        },
        cursorColor: black,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: white,
          filled: true,
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email or Username",
          hintStyle: TextStyle(color: grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        key: Key('passwordFieldKey'),
        style: TextStyle(
          color: black,
        ),
        autofocus: false,
        controller: passwordController,
        cursorColor: black,
        obscureText: hiddenPassword,
        validator: (value) => PasswordFieldValidator.validate(value!),
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: white,
          filled: true,
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          hintStyle: TextStyle(color: grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hiddenPassword = !hiddenPassword;
              });
            },
            color: grey.withOpacity(0.6),
            icon:
                Icon(hiddenPassword ? Icons.visibility_off : Icons.visibility),
          ),
        ));

    final loginButton = Material(
      key: Key('loginButtonKey'),
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: primary,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(usernameController.text, passwordController.text);
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: black,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/logo2.png",
                            fit: BoxFit.contain,
                          ),
                        )),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              "Don't have an account? ",
                              style: TextStyle(color: white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      print(email);
      print(password);
    }
  }
}
