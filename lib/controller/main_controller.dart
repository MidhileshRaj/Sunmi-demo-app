import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sunmi_app_demo/controller/api_services.dart';
import 'package:sunmi_app_demo/controller/helper_services.dart';
import 'package:sunmi_app_demo/utils/string_constants.dart';

import '../models/bar_code_item_models.dart';

class MainController extends ChangeNotifier {
  TextEditingController getItemController = TextEditingController();

  String barcode = "";
  String server = "";


  TextEditingController itemCOde = TextEditingController();

  TextEditingController itemDescription = TextEditingController();

  TextEditingController arabicItemDescription = TextEditingController();

  TextEditingController salesPrice = TextEditingController();

  TextEditingController barCode = TextEditingController();

  TextEditingController unitCode = TextEditingController();
  final GlobalKey globalKey = GlobalKey();

  Future<void> captureBarcodeAndSave(
      MainController value, BuildContext context) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      print("=============================1");

      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      print("=============================2");

      // Save the image to a file
      final directory = (await getApplicationDocumentsDirectory()).path;
      print("=============================5");
      File imgFile = File('$directory/barcode_${value.itemCOde.text}.png');
      print("=============================3");

      await imgFile.writeAsBytes(pngBytes);
      print("=============================4");

      var server = await HelperServices.getServerData(StringConstants.server);
      var dataBase =
          await HelperServices.getServerData(StringConstants.dataBase);
      var username =
          await HelperServices.getServerData(StringConstants.userName);

      print("=============================");
      username = "root";
      notifyListeners();

      // Upload the file to your API
      var result = await ApiServices.addProductDetails(
          userName: username,
          dataBase: dataBase,
          itemCode: itemCOde.text,
          itemDesc: itemDescription.text,
          arabicDecs: arabicItemDescription.text,
          salesPrice: salesPrice,
          unitCode: unitCode,
          barcode: imgFile,
          server: server);
      if (result) {
        _showSuccessDialog(context);
      }
    } catch (e) {
      stdout.writeln("Error capturing barcode: $e");
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Product added successfully!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  scannBarCode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.DEFAULT,
      );
      getItemController.text = barcode.toString();
      server = await HelperServices.getServerData(StringConstants.server);
      var dataBase = await HelperServices.getServerData(StringConstants.dataBase);
      var userName = await HelperServices.getServerData(StringConstants.userName);
      print("==========1${userName}");

      var response = await ApiServices.getBarCodeDetails(
          userName, dataBase, server,barcode);
      if(response!= null){
        return response;
      }else{
        return null;
      }

      // barcode scanned action
    } on PlatformException {
      // handle platform exception
    }
  }

 Future<BarCodeData?> getDetailsMethod() async {
    server = await HelperServices.getServerData(StringConstants.server);
    var dataBase = await HelperServices.getServerData(StringConstants.dataBase);
    var userName = await HelperServices.getServerData(StringConstants.userName);
print("==========1${userName}");

    var response = await ApiServices.getBarCodeDetails(
        userName, dataBase, server, getItemController.text);
    if(response!= null){
      return response;
    }else{
      return null;
    }
  }
}
