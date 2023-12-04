import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'http_service.dart';
import 'model/single_user.dart';

class SingleuserScreen extends StatefulWidget {
  const SingleuserScreen({super.key});

  @override
  State<SingleuserScreen> createState() => _SingleuserScreenState();
}

class _SingleuserScreenState extends State<SingleuserScreen> {
  late HttpService http;
  SingleUser? user;
  bool isLoading=false;

 Future getUser() async{
isLoading=true;
Response response =await http.getRequest("/api/users/2");
isLoading=false;

try {
  if(response.statusCode==200){
    setState(() {
      user=SingleUser.fromJson(response.data);
    });

  }
  
} 
catch (e) {
  log("error");
  
}


 }
 @override
  void initState() {
HttpService();
    getUser();
    super.initState();
  }
  


  
   
    



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Single User Screen")),
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         Center(child: Text("id=${user!.data!.id}")),
           Center(child: Text("Firstname=${user!.data!.firstName}")),
           Center(child: Text("Lastname=${user!.data!.lastName}")),
           Center(child: Text("Email=${user!.data!.email}")),
          Center(child: Image.network("${user!.data!.avatar}"))

        ],
        

      )
    );
  }
}

