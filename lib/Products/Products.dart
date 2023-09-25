import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:searchfield/searchfield.dart';
import 'package:slim_plus/Menu/Drawer_Menu.dart';
import 'package:slim_plus/Products/Products_res/Products_res.dart';
import 'package:slim_plus/Products/Publicaciones.dart';
import 'package:slim_plus/constants.dart';

class Products_Screen extends StatefulWidget {
  int id;
  String user;
  String password;
  String token;
  List<Proveedores> provs;
  List<Sublinea> sub;
  Products_Screen({Key? key,required this.id,required this.user, required this.password,required this.token,required this.provs,required this.sub}) : super(key: key);

  @override
  State<Products_Screen> createState() => _Products_ScreenState();
}

class _Products_ScreenState extends State<Products_Screen> with TickerProviderStateMixin{
  bool v30_is_sorting = false;
  int status_code = 0;
  List<productos> Slim_products = <productos>[];
  final GlobalKey<ScaffoldState> sca_key = GlobalKey<ScaffoldState>();
  TextEditingController controller_searcher = TextEditingController();
  List<String> drop_tipo = <String>['*','Accesorios','Refacciones'];
  List<String> drop_stock= <String>['*','Con Stock','Sin Stock'];
  String? Proveedor;
  String? Sublineav;
  String? Stock;
  String? Tipo;
  String Proveedor_searcher = '*';
  String Sublinea_searcher = '*';
  String Stock_searcher = '*';
  String Tipo_searcher = '*';
  @override
  void initState() {
    get_products();
    super.initState();
  }

  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sca_key,
      appBar: _AppBar(),
        drawer: Navigation_menu(id: widget.id, user: widget.user, password: widget.password, token: widget.token, provs: widget.provs, sub: widget.sub),
        endDrawer: _endDrawer(),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Visibility(
                    visible: status_code ==1 || status_code ==2 || status_code ==3,
                    child: Expanded(
                      flex: 1,
                        child: _Row_searcher(),
                    ),
                  ),
                  Expanded(
                    flex: 11,
                      child: list_status(status_code),
                  ),
                ],
              ),
          ),
        ),
    );
  }

   list_status(int code){
      switch(code){
        case 0:
          return _Loading();
        case 1:
          return _Lista();
        case 2:
          return _NoData();
        case 3:
          return _ServerError();
        case 4:
          return _AuthErr();
      }
  }

   get_products()async{
        setState(() {
        v30_is_sorting = false;
        Slim_products.clear();
        status_code = 0;
        Sublinea_searcher = _Sub_converter(Sublineav??'*', widget.sub);
        Proveedor_searcher = _Prov_converter(Proveedor??'*',widget.provs);
        Stock_searcher = _Stock_converter();
        Tipo_searcher = _Tipo_converter();
        });
       var url = Uri.parse('http://45.56.74.34:6660/Slim_Company?title=${controller_searcher.text.toUpperCase().trim()}&sublinea=${Sublinea_searcher}&proveedor=${Proveedor_searcher}&tipo=${Tipo_searcher}&stock=${Stock_searcher}');
       print(url);
       var response =  await http.get(url,headers: {
         'id':widget.id.toString(),
         'User':widget.user,
         'Password':widget.password,
         'Token':widget.token
       });
       if(response.statusCode ==200){
         String sJson = response.body.toString();
         var Json = json.decode(sJson);
         print(Json["code"] );
         setState(() {
           status_code =int.parse(Json["code"]);
         });
         var Jsonv= Json["data"] as List;
         for (var noteJson in Jsonv) {
           setState(() {
             Slim_products.add(productos.fromJson(noteJson));
           });

         }
       }else{

       }
    }
    _AppBar(){
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
          onPressed: (){
          _openDrawer();
      }, icon: Icon(Icons.menu,color: Colors.black)),
      actions: [
        Visibility(
          visible: status_code ==1 || status_code ==2 || status_code ==3,
          child: IconButton(
              onPressed: (){
              sca_key.currentState?.openEndDrawer();
          }, icon:Icon(Icons.search,color: Colors.black,)),
        ),
      ],
    );
  }
    _Row_searcher(){
    return Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(onPressed: (){
              setState(() {
                v30_is_sorting = !v30_is_sorting;
                if(v30_is_sorting == true){
                  Slim_products.sort();
                }else{
                  Slim_products.sort((a,b)=>a.V30_total!.compareTo(b.V30_total!));
                }
              });
            }, icon: Icon(v30_is_sorting?Icons.arrow_drop_down_circle_outlined:Icons.arrow_circle_up_sharp),),
          ),
          Expanded(
            flex: 8,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Buscar...',
                ),
                controller: controller_searcher,
                onSubmitted: (txt)async{
                  await get_products();
                },
              ),
          ),
          Expanded(
            flex: 1,
              child: IconButton(
                  onPressed: ()async{
                    await get_products();
                  },
                  icon: Icon(Icons.refresh)))
        ],
      );
    }
    _Lista(){
     return ListView.builder(
          itemCount: Slim_products.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                      depth: 8,
                      lightSource: LightSource.topLeft,
                      color: Colors.white60
                  ),
                  child: ListTile(
                    leading: Image.network(Slim_products[index].iMAGE!,width: 50,height: 50,),
                    title: Text(Slim_products[index].cODIGO!,style: Normal_text.headerstyle,),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(Slim_products[index].dESCRIPCION!,style: Normal_text.subtitlestyle,),
                        Text('WMS STOCK: '+Slim_products[index].sTOCKCEDIS.toString()+' CH: '+Slim_products[index].ch.toString()+' FUL: '+Slim_products[index].ful.toString(),style: Normal_text.subtitlestyle,),
                        Text('ML: '+Slim_products[index].mL.toString()+' AMZ: '+Slim_products[index].aMZ.toString()+' SHEIN: '+Slim_products[index].sHEIN.toString(),style: Normal_text.subtitlestyle,),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Publicaciones(Codigo: Slim_products[index].cODIGO!,desc: Slim_products[index].dESCRIPCION!,stock: Slim_products[index].sTOCKCEDIS!,)),
                      );
                    },
                  ),
                ),
              ),
            );
          }
      );
    }
    _Loading(){
      return Center(
        child: SpinKitChasingDots(
          color: Colors.purple,
        ),
      );
    }
    _ServerError(){
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('SERVER INTERNAL ERROR'),
            Image.network('https://martinbrainon.com/inicio/wp-content/uploads/2017/04/false-2061132_1280.png'),
          ],
        ),
      );
    }
    _AuthErr(){
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Error de autenticacion'),
            SpinKitRipple(
              color: Colors.purple,
            )
          ],
        ),
      );
    }
    _NoData(){
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            Text('Sin datos que mostrar'),
            SpinKitRotatingPlain(
              color: Colors.purple,
            ),
          ]
        ),
      );
    }
    _endDrawer(){
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                child: Image.asset('assets/logo.png'),
            ),
            DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  hint: Text('Proveedores'),
                    items: widget.provs.map((map)=>
                     DropdownMenuItem(
                         child: Text(map.nOMBRE!),
                          value: map.nOMBRE,
                     ),
                    ).toList(),
                  value: Proveedor,
                  onChanged: (String? value){
                    setState(() {
                      Proveedor = value;
                    });
                    get_products();
                  },
                ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                hint: Text('Sublinea'),
                items: widget.sub.map((map)=>
                    DropdownMenuItem(
                      child: Text(map.nOMBRE!),
                      value: map.nOMBRE,
                    ),
                ).toList(),
                value: Sublineav,
                onChanged: (String? value){
                  setState(() {
                    Sublineav = value;
                  });
                  get_products();
                },
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                hint: Text('Tipo'),
                items: drop_tipo.map((String? e)=>
                    DropdownMenuItem<String>(
                      value: e,
                      child: Text(e!),
                    ),
                ).toList(),
                value: Tipo,
                onChanged: (String? value){
                  setState(() {
                    Tipo = value;
                  });
                  get_products();
                },
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                hint: Text('Stock'),
                items: drop_stock.map((String? e)=>
                    DropdownMenuItem<String>(
                      value: e,
                      child: Text(e!),
                    ),
                ).toList(),
                value: Stock,
                onChanged: (String? value){
                  setState(() {
                    Stock = value;
                  });
                  get_products();
                },
              ),
            ),
          ],
        ),
      );
    }
    _openDrawer(){
    sca_key.currentState?.openDrawer();
    }
    _Prov_converter(String nombre,List<Proveedores>listas){
      String proveedor = '*';
      listas = widget.provs.where((element){
        var searcher = element.nOMBRE;
        return searcher!.contains(nombre);
      }).toList();
      proveedor = listas[0].iD==0?'*':listas[0].iD.toString();
      if(proveedor!='*'){
        switch(proveedor.length){
          case 1:proveedor='00'+proveedor; break;
          case 2:proveedor='0'+proveedor; break;
        }
      }
      return proveedor;
    }
    _Sub_converter(String nombre,List<Sublinea>listas){
    listas = widget.sub.where((element){
      var searcher = element.nOMBRE;
      return searcher!.contains(nombre);
    }).toList();
    return listas[0].iD==0?'*':listas[0].iD.toString();
  }
    _Stock_converter(){
    String stock_ = '*';
      switch(Stock){
        case 'Con Stock':
          stock_ = 'con';
          break;
        case 'Sin Stock':
          stock_ = 'sin';
          break;
      }
      return stock_;
    }
    _Tipo_converter(){
    String tipo_ = '*';
    switch(Tipo){
      case 'Accesorios':
        tipo_ = 'A';
        break;
      case 'Refacciones':
        tipo_ = 'R';
        break;
    }
    return tipo_;
  }

}
