import 'package:api_app/splash_screen.dart';

import 'get_api.dart';
import 'imports.dart';
import 'joke_api.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),

    );
  }
}

