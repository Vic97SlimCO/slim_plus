import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:slim_plus/constants.dart';
import 'Products_res/Products_res.dart';

class Publicaciones extends StatefulWidget {
  String Codigo;
  int stock;
  String desc;
  Publicaciones({Key? key,required this.Codigo,required this.stock,required this.desc}) : super(key: key);

  @override
  State<Publicaciones> createState() => _PublicacionesState();
}

class _PublicacionesState extends State<Publicaciones> {
  List<ML> Pub_ML = <ML>[];
  List<AMZ> Pub_AMZ = <AMZ>[];
  List<SHEIN> Pub_SHEIN = <SHEIN>[];

  @override
  void initState() {

    _getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _Bar(),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [

              Visibility(
                  visible: Pub_ML.isNotEmpty,
                  child: Expanded(
                      child: _ListML())),
              Visibility(
                visible:  Pub_AMZ.isNotEmpty,
                  child: Expanded(
                      child: _ListAMZ())),
              Visibility(
                  visible: Pub_SHEIN.isNotEmpty,
                  child: Expanded(
                      child: _ListSHEIN())),
            ],
          ),
      ),
    );
  }

  _ListML(){
    return ListView.builder(
        itemCount: Pub_ML.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Image.network(Pub_ML[index].tHUMBNAIL!),
            title:  Text(Pub_ML[index].iD!,style: Normal_text.headerstyle,),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(Pub_ML[index].tITLE!,style: Normal_text.headerstyle,),
                Text('SKU: ${Pub_ML[index].sKU!}',style: Normal_text.subtitlestyle,),
                Text('Price: ${Pub_ML[index].pRICE} V30: ${Pub_ML[index].v30.toString()}',style: Normal_text.subtitlestyle),
                Text('Status: ${Pub_ML[index].sTATUS!} Quantity: ${Pub_ML[index].aVAILABLEQUANTITY.toString()} Logistica: ${Pub_ML[index].lOGISTICTYPE}',style: Normal_text.subtitlestyle),
                Text('Fecha: ${Pub_ML[index].dt} Age: ${Pub_ML[index].age.toString()}',style: Normal_text.subtitlestyle)
              ],
            ),
          );
        }
    );
  }
  _ListAMZ(){
    return ListView.builder(
        itemCount: Pub_AMZ.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Image.network(Pub_AMZ[index].image!),
            title:  Text(Pub_AMZ[index].asin!,style: Normal_text.headerstyle,),
            subtitle: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(Pub_AMZ[index].item!,style: Normal_text.headerstyle,),
                Text('SKU: ${Pub_AMZ[index].sku!}',style: Normal_text.subtitlestyle),
                Text('Price: ${Pub_AMZ[index].price!} V30: ${Pub_AMZ[index].v30.toString()}',style: Normal_text.subtitlestyle),
                Text('Status: ${Pub_AMZ[index].status!} Quantity: ${Pub_AMZ[index].quantity.toString()}',style: Normal_text.subtitlestyle),
                Text('Fecha: ${Pub_AMZ[index].dt} Age: ${Pub_AMZ[index].age.toString()}',style: Normal_text.subtitlestyle)
              ],
            ),
          );
        }
    );
  }
  _ListSHEIN(){
    return ListView.builder(
        itemCount: Pub_SHEIN.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Image.network(Pub_SHEIN[index].imageSmallUrlMAIN!),
            title:  Text(Pub_SHEIN[index].spuName!,style: Normal_text.headerstyle),
            subtitle: Column(
              children: [
                Text(Pub_SHEIN[index].productName!,style: Normal_text.headerstyle),
                Text('SKU: ${Pub_SHEIN[index].sellerSku!}',style: Normal_text.subtitlestyle),
                Text('Price: ${Pub_SHEIN[index].salePrice!} V30: ${Pub_SHEIN[index].v30.toString()} Quantity: ${Pub_SHEIN[index].inventoryQuantity}',style: Normal_text.subtitlestyle),
                Text('Fecha: ${Pub_SHEIN[index].dt} Age: ${Pub_SHEIN[index].age.toString()}',style: Normal_text.subtitlestyle)
              ],
            ),
          );
        }
    );
  }

  _getData() async {
    var url = Uri.parse('http://45.56.74.34:6660/Slim_Company/canales?CODIGO=${widget.Codigo}');
    var response =  await http.get(url);
    if (response.statusCode == 200) {
      String sJson = response.body.toString();
      var Json = json.decode(sJson);
      var Jsonv= Json["data"];
      print(Jsonv);
      var JML = Jsonv["ML"] as List;
      var JAMZ = Jsonv["AMZ"] as List;
      var JSHEIN = Jsonv["SHEIN"] as List;
      for (var noteJson in JML) {
        setState(() {
          Pub_ML.add(ML.fromJson(noteJson));
        });
      }
      for (var noteJson in JAMZ) {
        setState(() {
          Pub_AMZ.add(AMZ.fromJson(noteJson));
        });
      }
      for (var noteJson in JSHEIN) {
        setState(() {
          Pub_SHEIN.add(SHEIN.fromJson(noteJson));
        });
      }
    }
    else {
    print(response.reasonPhrase);
    }
  }
  _Bar(){
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        /*children: [
        Text(widget.Codigo),
        Text(widget.desc),
        Text('Stock: ${widget.stock}'),
        ],*/
      ),
    );
  }
}
