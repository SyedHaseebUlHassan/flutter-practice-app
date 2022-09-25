import 'dart:convert';

import 'imports.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:developer';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passconfirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool loading = false;


  var formkey = GlobalKey<FormState>();
  reg( String name, String email, String password, String phone,String password_confirmation ) async{
    setState(() {
      loading = true;
    });

    try{ final response = await http.post(Uri.parse("http://adeegmarket.zamindarestate.com/api/v1/reg"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name':name,
        'email':email,
        'phone':phone,
        'password':password,
        'password_confirmation':password_confirmation,
        'role':2,

      }),
    );
    // print(response.statusCode);


    if (response.statusCode==200){


      var body = jsonDecode(response.body);

      var bodyResponse = body['status'];
      debugPrint('bodyResponse: $bodyResponse');

      log("Body Response: $bodyResponse");

      if (bodyResponse==200){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> home_screen()));


      }
      else{
        log("Your Email password is wrong please try again later");
      }

    }
    else{
      log("Internal Server Error!");
    }
    setState(() {
      loading= false;
    });

      // print(response.body);
    }catch(e){
      debugPrint('e: $e');
      log("Internal Server Error!");
      setState(() {
        loading= false;
      });
    }


  }
  String pass = '';
  // bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    // alignment: Alignment.center,
                    height: 150,
                    width: 150,

                    decoration: BoxDecoration(
                      // color: Colors.blue,
                        shape: BoxShape.circle,
                        //   color: Colors.green,

                        image: DecorationImage(
                          image: AssetImage("assets/images/prelogo.png"),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      alignment: Alignment.center,
                      // color: Colors.blueAccent,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Create an account",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Start a healthy journey with us",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),


                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          child: TextFormField(
                            controller: nameController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Required"),
                            ]),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            style: TextStyle(color: Colors.black),
                            decoration: inputDecoration(
                                labelText: "Name",
                                icon: const Icon(Icons.account_circle_outlined, color: Color(0xffEF873D),),


                                hintText: ""),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          child: TextFormField(
                            controller: emailController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Required"),
                              EmailValidator(
                                  errorText: "Enter a valid email address")
                            ]),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            style: TextStyle(color: Colors.black),
                            decoration: inputDecoration(
                                labelText: "Email",
                                icon: const Icon(Icons.email_outlined, color: Color(0xffEF873D),),


                                hintText: "haseeb@gmail.com"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          child: TextFormField(
                            controller: phoneController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Required"),

                            ]),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            style: TextStyle(color: Colors.black),
                            decoration: inputDecoration(
                                labelText: "Phone",
                                icon: const Icon(Icons.phone, color: Color(0xffEF873D),),


                                hintText: "haseeb@gmail.com"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is Required";
                              } else if (value.length <= 6) {
                                return "Password should be greater than 6 latter";
                              }
                            },
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            style: TextStyle(color: Colors.black),
                            // obscureText: isVisible,
                            decoration: inputDecoration(
                              isPassword: true,
                              // showPassword: true,
                              labelText: 'Password',
                              hintText: "",
                              icon: const Icon(Icons.lock_outline, color: Color(0xffEF873D),),

                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          child: TextFormField(
                            controller: passconfirmController,
                            validator: (val) =>
                            // MultiValidator([
                            //   RequiredValidator(errorText: "Required"),
                            //   MatchValidator(errorText: "Passwords do not match").validateMatch(passwordController.toString(), passwordController.toString()),
                            //
                            // ]),
                            MatchValidator (errorText: "Passwords do not match").validateMatch(passconfirmController.text, passwordController.text),

                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            style: TextStyle(color: Colors.black),
                            decoration: inputDecoration(
                                labelText: "Confirm Password",
                                icon: const Icon(Icons.lock_outline, color: Color(0xffEF873D),),
                                hintText: ""),
                          ),
                        ),

                        loading == true? Lottie.asset(height: 100, width: 100,'assets/json/customloader.json')
                        :SizedBox(
                          height: 57,
                          width: 250,
                          child: ElevatedButton(
                              onPressed: () {

                                // print('Clicked');
                                if (formkey.currentState!.validate()) {
                                  reg(nameController.text, emailController.text, passwordController.text, phoneController.text,passconfirmController.text);

                                  print("Validation Okay");
                                  print('Name: ${nameController.text}');
                                  print('Email: ${emailController.text}');
                                  print('Phone: ${phoneController.text}');
                                  print('Password: ${passwordController.text}');
                                  print('Confirm Password: ${passconfirmController.text}');
                                } else {
                                  print("Not Validate");
                                }
                              },
                              style: ElevatedButton.styleFrom(

                                  backgroundColor: Color(0xffEF873D),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration({
    required String labelText,
    required Widget icon,
    bool isPassword = false ,
    bool showPassword = false ,
    // required bool isEmail,
    required String hintText,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.black12,
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      icon: icon,
      suffixIcon:
      Visibility(

        visible: isPassword,
        child: showPassword ? GestureDetector(
            onTap: (){
              setState(() {
                showPassword = !showPassword ;
              });
            },
            child: Icon(Icons.visibility)) : GestureDetector(
            onTap: (){
              setState(() {
                showPassword = !showPassword ;
              });
            },
            child: Icon(Icons.visibility_off)),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color(0xffEF873D),
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 2,
        ),
      ),
    );
  }
}
