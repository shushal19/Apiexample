import 'dart:developer';

import 'package:apiexample/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'model/multi_user.dart';


class MultiUserScreen extends StatefulWidget {
  const MultiUserScreen({super.key});

  @override
  State<MultiUserScreen> createState() => _MultiUserScreenState();
}

class _MultiUserScreenState extends State<MultiUserScreen> {
  late HttpService http;
  MultiUser? user;
  bool isLoading=false;

 Future getUser() async{
isLoading=true;
Response response =await http.getRequest("api/users?page=2");
isLoading=false;

try {
  if(response.statusCode==200){
    setState(() {
      user=MultiUser.fromJson(response.data);
    });

  }
  
} 
catch (e) {
  log("error");
  
}


 }
 @override
  void initState() {
http=HttpService();
    getUser();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Multi User Screen")),
      ),
      body:isLoading?
       const Center(child: CircularProgressIndicator())
      :
      Center(
        child: ListView.builder(
          itemCount: user?.data!.length,
          itemBuilder: ((context, index) {
          List<Data>? listOfUsers = user?.data;
          Data singleUser=listOfUsers![index];
          return  ListTile(leading: Image.network(singleUser.avatar!),title: Text("${singleUser.firstName}"),subtitle:  Text("${singleUser.lastName}"),);
        })
          ),
      ));
  }
}