
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slim_plus/Products/Products_res/Products_res.dart';
import 'package:http/http.dart' as http;
import '../Products/Products.dart';
import 'Loging_res/Login_res.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Slim Plus',
      home: const LoginScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Georgia',
        useMaterial3: true,
        textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.black),
        primaryColor: Colors.black,
          iconTheme: IconThemeData(
              color: Colors.black
          )
        ),
      );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Proveedores> provs = <Proveedores>[Proveedores(nOMBRE: '*',iD: 0)];
  List<Sublinea> sub = <Sublinea>[];
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void initial()async{
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  void getProductsData() async{
    await Products_atrib().Prove().then((value) => {
      setState((){
        provs.addAll(value);
      })
    });
    await Products_atrib().Subline().then((value) =>{
      setState((){
        sub.addAll(value);
      })
    });
  }
  @override
  void initState() {
    getProductsData();
    initial();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 250,
          child: Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Bienvenido de vuelta'),
                    SizedBox(height: 10,),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Usuario'
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 20,),
                    NeumorphicButton(
                      child: Text('Ingresar'),
                      onPressed: ()async{
                        await _Log_In();
                      },
                    )
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }

  _Log_In()async{
    var url = Uri.parse('http://45.56.74.34:5558/usuarios/login/?name=${nameController.text}&password=${passwordController.text}');
    var response = await http.get(url);
    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      Log log = new Log.fromJson(jsonResponse);
      if (log.status ==0){
        _showDialog(context);
      } else {
        int userid = log.data[0].USER_ID;
        String name = log.data[0].NOMBRE;
        String token = log.data[0].TOKEN;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context)=>Products_Screen(
                  id: userid, user: name, password: passwordController.text, token:token,provs: provs,sub: sub,)),
                (Route<dynamic>route) => false);
      }
    }
  }
  void _showDialog(BuildContext context) {//El show dialog mostrado en cuento la sesion sea erronea
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Error !!!",style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
          content: new Text("Usuario o contraseña incorrectos",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
