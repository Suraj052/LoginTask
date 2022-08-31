// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:login/home.dart';

import 'main.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isHidden = true;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assests/pic.jpg"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Image.asset('assests/pic.jpg'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28.0, 80.0, 0.0, 0.0),
                    child: Text(
                      "Hello Again ! \nWelcome \nback",
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Recoleta',
                          color: HexColor('#091945')
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(28.0, 15.0, 0.0, 15.0),
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Icon(
                        Icons.how_to_reg_rounded,
                        color: HexColor("#091945"),
                        size: 70,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(22.0,0.0, 22.0,0.0),
                      child:Container(
                        height: size.height*0.06,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              offset: Offset(0.0,2.0),
                            )]
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (email)=>
                            email != null && !EmailValidator.validate(email)
                                ?'Enter a valid email'
                                :null,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email Id',
                            ),
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(22.0,0.0, 22.0,0.0),
                      child:Container(
                        height: size.height*0.06,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              offset: Offset(0.0,2.0),
                            )]
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: isHidden,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                            value != null && value.length<6
                                ?'Enter minimum 6 chracters'
                                :null,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: toggle,
                                child: Icon(Icons.visibility),
                              ),
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.fromLTRB(22.0,0.0, 22.0,0.0),
                    child: Container(
                      height: size.height*0.070,
                      width: size.width*0.9,
                      child: RaisedButton(
                        padding: EdgeInsets.all(5.0),
                        color: HexColor("#091945"),
                        onPressed: signin,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text('Sign In',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                          onPressed: () {},
                          child:Text('Forgot Password',
                            style: TextStyle(
                                color: HexColor("#091945"),
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black45, fontSize: 18.0),
                          text: "Don't have account? ",
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = (){},
                              text: 'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: HexColor("#091945"),
                                fontSize: 17.0,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }


  void toggle()
  {

    setState(() {
      isHidden = !isHidden;
    });
  }

  Future signin() async
  {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.white))),
    );

    try
    {

      Response response = await post(
          Uri.parse('https://ecommerce-calculator.herokuapp.com/api/MPC/login'),
          body: {
            'email' : emailController.text.trim(),
            'password' : passwordController.text.trim()
          },
          headers: {
            'x-auth': base64Encode(utf8.encode
              ('${emailController.text.trim()}:${passwordController.text.trim()}')),
                    }
      );

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());
        print(data['message']);
        if(data['message']=='loggedIn')
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Home()));
        }
        else if(data['message']=='Invalid_EmailId')
        {
          showToast();
          navigatorKey.currentState!.popUntil((route) => route.isFirst);
        }
        else if(data['message']=='Invalid_Password')
        {
          showToast2();
          navigatorKey.currentState!.popUntil((route) => route.isFirst);
        }

      }
    }
    catch(e)
    {
      print(e);
    }

  }


}


void showToast()=>Fluttertoast.showToast(
  msg: 'No user found for that email',
  fontSize: 13.0,
  backgroundColor: HexColor("#091945"),
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);


void showToast2()=>Fluttertoast.showToast(
  msg: 'Wrong password provided for that user',
  fontSize: 13.0,
  backgroundColor: HexColor("#091945"),
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);


void showToast3()=>Fluttertoast.showToast(
  msg: 'Internal Error,Something went wrong',
  fontSize: 13.0,
  backgroundColor: HexColor("#091945"),
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);
