// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
   DateTime? _expiryTime;
  bool get isAuth {
    return _token != null;
  }
  String? get token{
    if(_expiryTime !=null &&
      _expiryTime!.isAfter(DateTime.now()) && _token !=null){
      return _token!;
    }else {
      return null;
    }
  }
  Future<void> _authenticate(String email,String password,String requiredurl) async{
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$requiredurl?key=AIzaSyA-o5QlCpnhy327cM8R7xHfM8e3260l3Dc");
    final response = await http.post(url,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));
             final responseData = json.decode(response.body);
    _token = responseData["idToken"];
    _userId = responseData["localId"];
    _expiryTime = DateTime.now()
        .add(Duration(seconds: int.parse(responseData["expiresIn"])));
    notifyListeners();
           
  }
  
  Future<void> signup(String email, String password) async {
   return _authenticate(email, password, "signUp");
       
  }
  Future<void> login(String email, String password,) async {
    return _authenticate(email, password,"signInWithPassword" );
  }
}
