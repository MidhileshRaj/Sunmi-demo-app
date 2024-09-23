import 'package:flutter/material.dart';
import 'package:sunmi_app_demo/controller/api_services.dart';

class MainController extends ChangeNotifier{
  TextEditingController getItemController = TextEditingController();

  String barcode = "";

  TextEditingController itemCOde = TextEditingController();

  TextEditingController itemDescription = TextEditingController();

  TextEditingController arabicItemDescription = TextEditingController();

  TextEditingController salesPrice = TextEditingController();

  TextEditingController barCode = TextEditingController();

  TextEditingController unitCode = TextEditingController();

  addItem()async{
     await ApiServices.addProductDetails();
  }

  getItem()async{

  }
}