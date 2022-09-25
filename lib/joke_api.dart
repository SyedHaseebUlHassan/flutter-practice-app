import 'imports.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';
import 'package:lottie/lottie.dart';

class jokeTask extends StatefulWidget {
  const jokeTask({Key? key}) : super(key: key);

  @override
  State<jokeTask> createState() => _jokeTaskState();
}

class _jokeTaskState extends State<jokeTask> {
  bool loading = true;
  var responseBody;
  var jokes;
  bool isVisible = false;


  @override
  initState(){
    super.initState();
    getJoke();
  }

  getJoke() async {
    setState(() {
      loading= true;
    });

    log("Api Calling...");



    //Jokes Api
    var api = "https://official-joke-api.appspot.com/random_joke";

    var response = await http.get(Uri.parse(api),
      headers: {
        'Content-Type': 'application/json',
      },


    );
    print(response.statusCode);
    // print("Body:${response.body}");

    if(response.statusCode==200){
      setState(() {
        responseBody = jsonDecode(response.body);
        debugPrint("Body: $responseBody");






      });

      debugPrint('data:"$responseBody');




    }else{
      print("Server Error! Please try again later");


    }

    log("API  Okay...");
    setState(() {
      loading= false;
    });


  }
  void showAnswer(){
    Text(responseBody['punchline']);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Color(0xffEF873D),
        title: Text("Jokes for You!"),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(height: 50,),
            Text("Click and unlock The Jokes!", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),

            loading==true? Lottie.asset('assets/json/circleloader.json'):
            Container(

              decoration: BoxDecoration(
                  color:  Color(0xffEF873D).withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blue,
                  width: 4,

                )
              ),
              padding: EdgeInsets.all(50),


                child: Column(
                  children: [
                    Text(responseBody['setup'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                    SizedBox(height: 20,),
                    isVisible == true?
                        Text(responseBody['punchline'],style: TextStyle(color: Colors.white, fontSize: 22),):Container(),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: (){
                          getJoke();
                          setState(() {
                            isVisible = !isVisible;
                          });

                        }, 
                            style: ButtonStyle(),
                            child: Text("Next Joke")),

                        TextButton(
                            onPressed: (){
                          setState(() {
                            isVisible = !isVisible ;
                          });
                        },
                            child: Text("Show Answer",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                      ],
                    ),




                  ],
                )),]
        ),
      ),
    );
  }
}
