import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var url = "https://flagrant-amusements.000webhostapp.com/";

Future get(var data, String file) async
{

  var response = await http.post(url + file, body: json.encode(data));
  
  return jsonDecode(response.body);
}

Future set(var data, String file) async
{

  var response = await http.post(url + file, body: json.encode(data));

  return jsonDecode(response.body);
}

Future update(var data) async
{

  var response = await http.post(url + "update.php", body: json.encode(data));

  return response;
  //OU
  return jsonDecode(response.body);
}

Future delete(var data) async
{

  var response = await http.post(url + "delete.php", body: json.encode(data));

  return response;
  //OU
  return jsonDecode(response.body);
}