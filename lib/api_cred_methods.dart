// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:to_do_app_api_connected/alert_dialoges.dart';
import 'package:to_do_app_api_connected/home.dart';

Future<void> submitData(BuildContext context, VoidCallback callback) async {
 
  final title = titleController.text;
  final description = descriptionController.text;

  final body = {
    "title": title,
    "description": description,
    "is_completed": false
  };

  const url = 'https://api.nstack.in/v1/todos';

  final uri = Uri.parse(url);

  final response = await http.post(uri,
      body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
  Navigator.pop(context);
  if (response.statusCode == 201) {
    titleController.clear();
    descriptionController.clear();
    print("creation success");
    Navigator.pop(context);
    callback();
   
  } else {
    print("creation failed");
    failureMessage(context);
  }
}

updateData(String id, BuildContext context, VoidCallback callback) async {
  final url = "https://api.nstack.in/v1/todos/$id";
  final uri = Uri.parse(url);
  final title = titleController.text;
  final description = descriptionController.text;
  final data = {
    'title': title,
    "description": description,
    "is_completed": false
  };
  final response = await http.put(uri,
      headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));
  Navigator.pop(context);
  if (response.statusCode == 200) {
    titleController.clear();
    descriptionController.clear();
    Navigator.pop(context);
     callback();
    
   
  }
}

deleteById(String id, context, VoidCallback callback) async {
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);

  final response = await http.delete(uri);
  if (response.statusCode == 200) {
     callback();
  
  }
}
