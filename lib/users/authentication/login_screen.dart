import 'dart:convert';

import 'package:final_flutter_project/api_connection/api_connection.dart';
import 'package:final_flutter_project/users/authentication/signup_screen.dart';
import 'package:final_flutter_project/users/fragments/dashboard_of_fragments.dart';
import 'package:final_flutter_project/users/model/user.dart';
import 'package:final_flutter_project/users/userPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget
{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async
  {
try
    {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "user_email": emailController.text.trim(),
          "user_password": passwordController.text.trim(),
        },
      );

      if(res.statusCode == 200) //from flutter app the connection with api to server - success
          {
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin['success'] == true)
        {
          Fluttertoast.showToast(msg: "Welcome.You are logged in successfully");

          User userInfo = User.fromJson(resBodyOfLogin["userData"]);

          //save userInfo to local storage
          await RememberUserPrefs.saveRememberUser(userInfo);
          Future.delayed(Duration(milliseconds: 2000), (){
            Get.to(DashboardOfFragments());
          });

        }
        else
        {
          Fluttertoast.showToast(msg: "Incorrect email and password. Please try Again.");

        }
      }
    }
    catch(errorMsg)
    {
      print("Error :: " + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
    backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, cons)
      {
return ConstrainedBox(
  constraints: BoxConstraints(
    minHeight: cons.maxHeight,
  ),
  child: SingleChildScrollView(
    child: Column(
      children: [
        //Login Header
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 285,
          child: Image.asset(
            "images/login.jpg",
          ),
        ),

      //   login screen sign in form
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.all(
                Radius.circular(60),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Color(0xFFEEEEEE),
                  offset: Offset(0, -10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
              child: Column(
                children: [
                  //email-pass login btn
                 Form(
                  key: formKey,
                   child: Column(
                   children: [
                     //email
                     TextFormField(
                       controller: emailController,
                       validator: (val) => val == "" ? "Please write email" : null,
                       decoration: InputDecoration(
                         prefixIcon: const Icon(
                           Icons.email,
                           color: Colors.black,
                         ),
                         hintText: "Email",
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),
                           borderSide: const BorderSide(
                             color: Colors.black,
                           ),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),
                           borderSide: const BorderSide(
                             color: Colors.white24,
                           ),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),
                           borderSide: const BorderSide(
                             color: Colors.black,
                           ),
                         ),
                         disabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),
                           borderSide: const BorderSide(
                             color: Colors.white24,
                           ),
                         ),
                         contentPadding: const EdgeInsets.symmetric(
                           horizontal: 14,
                           vertical: 6,
                         ),
                         fillColor: Colors.white24,
                         filled: true,
                       ),
                     ),
                    const SizedBox(height: 18,),

                     //Password
                     Obx(
                         ()=> TextFormField(
                           controller: passwordController,
                           obscureText: isObsecure.value,
                           validator: (val) => val == "" ? "Please write password" : null,
                           decoration: InputDecoration(
                             prefixIcon: const Icon(
                               Icons.vpn_key_sharp,
                               color: Colors.black,
                             ),
                             suffixIcon: Obx(
                                   ()=> GestureDetector(
                                 onTap: (){
                                   isObsecure.value = ! isObsecure.value;
                                 },
                                 child: Icon(
                                   isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                   color: Colors.black,
                                 ),
                               ),
                             ),
                             hintText: "Password",
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30),
                               borderSide: const BorderSide(
                                 color: Colors.white24,
                               ),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30),
                               borderSide: const BorderSide(
                                 color: Colors.white24,
                               ),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30),
                               borderSide: const BorderSide(
                                 color: Colors.black,
                               ),
                             ),
                             disabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30),
                               borderSide: const BorderSide(
                                 color: Colors.black,
                               ),
                             ),
                             contentPadding: const EdgeInsets.symmetric(
                               horizontal: 14,
                               vertical: 6,
                             ),
                             fillColor: Colors.white24,
                             filled: true,
                           ),
                         ),
                     ),

                     const SizedBox(height: 18,),

                     //button
                     Material(
                       color: Colors.black,
                       borderRadius: BorderRadius.circular(30),
                       child: InkWell(
                         onTap: (){
                          if(formKey.currentState!.validate()){
                            loginUserNow();
                          }
                         },
                         borderRadius: BorderRadius.circular(30),
                         child: const Padding(
                             padding: EdgeInsets.symmetric(
                               vertical: 10,
                               horizontal: 28,
                             ),
                           child: Text(
                             "Login",
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 16,
                             ),
                           ),
                         ),
                       ),
                     ),

                   ],
                 ),
                 ),

                  const SizedBox(height: 16,),
                  //don't have account? navigate sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Text("Dont't have an account?",
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                      TextButton(
                        onPressed: ()
                        {
                          Get.to(SignUpScreen());
                        },
                        child: const Text(
                          "Create an account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                            color: Colors.blueAccent
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Text(
                    "OR",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                    ),
                  ),

                  //for admin login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Are you an admin?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: ()
                        {

                        },
                        child: const Text(
                          "Click here",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  ),
);
        },
      ),
    );
  }
}
