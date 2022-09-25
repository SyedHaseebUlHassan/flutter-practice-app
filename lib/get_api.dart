import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:developer';


class ApiTesting extends StatefulWidget {
  const ApiTesting({Key? key}) : super(key: key);

  @override
  State<ApiTesting> createState() => _ApiTestingState();
}

class _ApiTestingState extends State<ApiTesting> {
  var responseBody;

  List countries=[];
  bool loading = true;
  @override
  initState(){
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading= true;
    });

    log("Api Calling...");

    //getapi
    // var api = "https://ipinfo.io/161.185.160.93/geo";

    //population Api
    var api = "https://datausa.io/api/data?drilldowns=Nation&measures=Population";

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

         countries = responseBody['data'].toList();
         log('Countries: $countries');

      });

      debugPrint('data:"$responseBody');


      // firstapi data
      // var city = data['city'];
      // var ip = data['ip'].toString();
      // var region = data['region'];
      // var country = data['country'];
      // var origion = data['org'];
      // debugPrint('city:"$city');

      //

  }else{
      print("Server Error! Please try again later");


    }

    log("API  Okay...");
    setState(() {
      loading= false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            loading==true?
                Text("Loading..."):

            Container(

            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("City Name: ${data['city']}"),
            //     Row(
            //       children: [
            //         Text("Country Name:"),
            //         Text(data['country']),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Text("Origin Name:"),
            //         Text(data['org']),
            //       ],
            //     ),
            //   ],
            // )

              child: Column(
                children: [
                  // Text(responseBody['data'][3]['Year'].toString()),

                  Container(
                    height: MediaQuery.of(context).size.height*0.8,

                    child:ListView.builder(itemCount: countries.length,itemBuilder: (context, i){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(countries[i]['Nation']),
                          Text(countries[i]['Year']),
                          Text(countries[i]['Population'].toString()),
                        ],
                      );
                    },)
                  )
                ],
              ),

        ),
            // ElevatedButton(onPressed: (){getData();}, child: Text("Get Data")),
          ],

        ),
      ),
    );
  }
}
