import 'dart:convert';

import 'package:http/http.dart' as http;

class productos extends Comparable{
  String? cODIGO;
  int? sTOCKCEDIS;
  int? ful;
  int? ch;
  String? dESCRIPCION;
  num? cOSTOPUBLICACION;
  int? aMZ;
  int? mL;
  int? sHEIN;
  int? V30_total;
  String? iMAGE;

  productos(
      {this.cODIGO,
        this.sTOCKCEDIS,
        this.dESCRIPCION,
        this.ful,
        this.ch,
        this.cOSTOPUBLICACION,
        this.aMZ,
        this.mL,
        this.sHEIN,
        this.V30_total,
        this.iMAGE});

  productos.fromJson(Map<String, dynamic> json) {
    cODIGO = json['CODIGO'];
    sTOCKCEDIS = json['STOCK_CEDIS'];
    ful = json['FULL'];
    ch = json['CH'];
    dESCRIPCION = json['DESCRIPCION'];
    cOSTOPUBLICACION = json['COSTO_PUBLICACION'];
    aMZ = json['AMZ'];
    mL = json['ML'];
    sHEIN = json['SHEIN'];
    V30_total = json['AMZ']+json['ML']+json['SHEIN'];
    iMAGE = json['IMAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CODIGO'] = this.cODIGO;
    data['STOCK_CEDIS'] = this.sTOCKCEDIS;
    data['DESCRIPCION'] = this.dESCRIPCION;
    data['COSTO_PUBLICACION'] = this.cOSTOPUBLICACION;
    data['FULL'] = this.ful;
    data['CH'] = this.ch;
    data['AMZ'] = this.aMZ;
    data['ML'] = this.mL;
    data['SHEIN'] = this.sHEIN;
    data['V30_total'] = this.V30_total;
    data['IMAGE'] = this.iMAGE;
    return data;
  }

  @override
  int compareTo(other) {
    return other.V30_total!.compareTo(V30_total);
  }
}

class ML {
  String? iD;
  String? tITLE;
  String? sKU;
  String? sTATUS;
  num? pRICE;
  String? lOGISTICTYPE;
  int? aVAILABLEQUANTITY;
  String? dt;
  int? age;
  String? tHUMBNAIL;
  int? v30;

  ML(
      {this.iD,
        this.tITLE,
        this.sKU,
        this.sTATUS,
        this.pRICE,
        this.dt,
        this.age,
        this.lOGISTICTYPE,
        this.aVAILABLEQUANTITY,
        this.tHUMBNAIL,
        this.v30});

  ML.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    tITLE = json['TITLE'];
    sKU = json['SKU'];
    sTATUS = json['STATUS'];
    pRICE = json['PRICE'];
    dt = json['DATE_CREATED'];
    age = json['AGE'];
    lOGISTICTYPE = json['LOGISTIC_TYPE'];
    aVAILABLEQUANTITY = json['AVAILABLE_QUANTITY'];
    tHUMBNAIL = json['THUMBNAIL'];
    v30 = json['V30'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TITLE'] = this.tITLE;
    data['SKU'] = this.sKU;
    data['STATUS'] = this.sTATUS;
    data['PRICE'] = this.pRICE;
    data['DATE_CREATED'] = this.dt;
    data['AGE'] = this.age;
    data['LOGISTIC_TYPE'] = this.lOGISTICTYPE;
    data['AVAILABLE_QUANTITY'] = this.aVAILABLEQUANTITY;
    data['THUMBNAIL'] = this.tHUMBNAIL;
    data['V30'] = this.v30;
    return data;
  }
}

class SHEIN {
  String? spuName;
  String? productName;
  String? sellerSku;
  num? salePrice;
  int? inventoryQuantity;
  String? imageSmallUrlMAIN;
  String? dt;
  int? age;
  int? v30;

  SHEIN(
      {this.spuName,
        this.productName,
        this.sellerSku,
        this.salePrice,
        this.inventoryQuantity,
        this.imageSmallUrlMAIN,
        this.v30});

  SHEIN.fromJson(Map<String, dynamic> json) {
    spuName = json['spuName'];
    productName = json['productName'];
    sellerSku = json['sellerSku'];
    salePrice = json['salePrice'];
    age = json['AGE'];
    dt = json['lastUpdateTime'];
    inventoryQuantity = json['inventoryQuantity'];
    imageSmallUrlMAIN = json['imageSmallUrl_MAIN'];
    v30 = json['V30'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spuName'] = this.spuName;
    data['productName'] = this.productName;
    data['sellerSku'] = this.sellerSku;
    data['salePrice'] = this.salePrice;
    data['AGE'] = this.age;
    data['lastUpdateTime'] = this.dt;
    data['inventoryQuantity'] = this.inventoryQuantity;
    data['imageSmallUrl_MAIN'] = this.imageSmallUrlMAIN;
    data['V30'] = this.v30;
    return data;
  }
}

class AMZ {
  String? asin;
  String? item;
  String? sku;
  String? status;
  num? price;
  int? quantity;
  String? dt;
  int? age;
  String? image;
  int? v30;

  AMZ(
      {this.asin,
        this.item,
        this.sku,
        this.status,
        this.price,
        this.quantity,
        this.image,
        this.v30});

  AMZ.fromJson(Map<String, dynamic> json) {
    asin = json['asin'];
    item = json['item'];
    sku = json['sku'];
    status = json['status'];
    price = json['price'];
    age = json['AGE'];
    dt = json['created_date'];
    quantity = json['quantity'];
    image = json['image'];
    v30 = json['V30'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asin'] = this.asin;
    data['item'] = this.item;
    data['sku'] = this.sku;
    data['status'] = this.status;
    data['price'] = this.price;
    data['created_date'] = this.dt;
    data['AGE'] = this.age;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    data['V30'] = this.v30;
    return data;
  }
}

class Proveedores {
  String? nOMBRE;
  int? iD;

  Proveedores({this.nOMBRE, this.iD});

  Proveedores.fromJson(Map<String, dynamic> json) {
    nOMBRE = json['NOMBRE'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NOMBRE'] = this.nOMBRE;
    data['ID'] = this.iD;
    return data;
  }
}

class Sublinea {
  int? iD;
  String? nOMBRE;

  Sublinea({this.iD, this.nOMBRE});

  Sublinea.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nOMBRE = json['NOMBRE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NOMBRE'] = this.nOMBRE;
    return data;
  }
}

class Products_atrib{
  Future<List<Proveedores>> Prove() async{
    var url = Uri.parse('http://45.56.74.34:5558/proveedores/list');
    var response = await http.get(url);
    List<Proveedores> proveedores = <Proveedores>[];
    if(response.statusCode ==200){
      String sJson =response.body.toString();
      var Json = json.decode(sJson);
      var Jsonv = Json["data"] as List;
      for (var noteJson in Jsonv) {
        proveedores.add(Proveedores.fromJson(noteJson));
      }
      return proveedores;
    }else
      throw Exception('NO se pudo');
  }
  Future<List<Sublinea>> Subline() async{
    var url = Uri.parse('http://45.56.74.34:5558/productos/sublineas2/list');
    var response = await http.get(url);
    List<Sublinea> sublinea = <Sublinea>[];
    if(response.statusCode ==200){
      String sJson =response.body.toString();
      var Json = json.decode(sJson);
      var Jsonv = Json["data"] as List;
      for (var noteJson in Jsonv) {
        sublinea.add(Sublinea.fromJson(noteJson));
      }
      return sublinea;
    }else
      throw Exception('NO se pudo');
  }
}