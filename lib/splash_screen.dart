import 'package:shared_preferences/shared_preferences.dart';

import 'imports.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    void initState() {
      // TODO: implement initState
      super.initState();
      
    Future.delayed( Duration(seconds: 3), () async{
        SharedPreferences pref = await SharedPreferences.getInstance();
        var token = pref.getString('token');
        print("Token:$token");
        if (token==null || token=='null'){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));

        }else{
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home_screen()));
        }

      });
    }
    return Container(
     
      color: Colors.white,
      child:Center(
        
        // child: Lottie.asset("assets/json/unibookstack.json"),
        child: FlutterLogo(
          size: 300,

        ),

      ),
    );
  }
}
