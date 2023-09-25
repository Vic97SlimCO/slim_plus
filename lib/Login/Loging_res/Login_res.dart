
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Log {
  late String message;
  late int status;
  late List<Data> data;

  Log({required this.status, required this.message, required this.data});

  factory Log.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['data'] as List;
    print(list.runtimeType);
    List<Data> DataList = list.map((i) => Data.fromJson(i)).toList();
    return Log(
        status: parsedJson['status'],
        message: parsedJson['message'],
        data: DataList);
  }
}
class Data{
  final String NOMBRE,TOKEN;
  final int USER_ID;

  Data({required this.NOMBRE, required this.TOKEN, required this.USER_ID});

  factory Data.fromJson(Map<String,dynamic> parsedJson){
    return Data(
        NOMBRE: parsedJson['NOMBRE'],
        TOKEN: parsedJson['TOKEN'],
        USER_ID: parsedJson['USER_ID']);
  }
}

