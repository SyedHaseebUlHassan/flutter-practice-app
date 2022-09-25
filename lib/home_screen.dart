import 'package:shared_preferences/shared_preferences.dart';

import 'imports.dart';
import 'package:http/http.dart' as http;
class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  
  logout()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    try{
    var token = pref.getString('token');
    print("Token:$token");
    final responce= await http.post(Uri.parse("http://adeegmarket.zamindarestate.com/api/v1/logout"),
      headers: {
      'Content-Type': "application/json",
      'Authorization': "Bearer $token"
      },
    );
    print(responce.statusCode);
    print("Body: ${responce.body}");
    pref.setString('token', 'null');
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
    }
    catch(e){
      print("Catch Error_______");
      print(e.toString());
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Text("LogOut"),

      ),
    );
  }
}
