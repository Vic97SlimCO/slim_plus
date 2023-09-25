import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slim_plus/Products/Products.dart';
import 'package:slim_plus/constants.dart';

import '../Products/Products_res/Products_res.dart';

class Navigation_menu extends StatefulWidget {
  int id;
  String user;
  String password;
  String token;
  List<Proveedores> provs;
  List<Sublinea> sub;
  Navigation_menu({Key? key,required this.id,required this.user, required this.password,required this.token,required this.provs,required this.sub}) : super(key: key);

  @override
  State<Navigation_menu> createState() => _Navigation_menuState();
}

class _Navigation_menuState extends State<Navigation_menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/random_user.png'),
                        radius: 30,
                      ),
                    ),
                    Expanded(
                        child: Text(widget.user)
                    ),
                  ],
                ),
              ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                fit: BoxFit.fill
              ),
            ),
          ),
          ListTile(
            leading: Container(child: SVG_ICONS.letra_P,width: 30,height: 30,),
            title: Text('Productos Slim'),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
                  Products_Screen(id: widget.id, user: widget.user, password: widget.password, token: widget.token, provs: widget.provs, sub: widget.sub)), (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
