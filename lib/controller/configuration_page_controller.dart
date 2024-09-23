import 'package:flutter/material.dart';

import 'helper_services.dart';

class ConfigurationPageController extends ChangeNotifier{
  TextEditingController serverNameController = TextEditingController();

  TextEditingController dataBaseNameController = TextEditingController();

  TextEditingController tableName = TextEditingController();

  TextEditingController userName = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController ipAddress = TextEditingController();
  bool enableTextField = true;
  configurePageInitialization()async{
    var isConfigured =  HelperServices.checkConfiguration();
    if (await isConfigured) {
      enableTextField = false;

      serverNameController.text = "http://192.168.20.2:4000";
      dataBaseNameController.text = "techsysdb";
      tableName.text = "products";
      ipAddress.text = "192.168.20.2";
      notifyListeners();
    } else {
      enableTextField = true;
      serverNameController.text = "http://192.168.20.2:4000";
      dataBaseNameController.text = "techsysdb";
      tableName.text = "products";
      ipAddress.text = "192.168.20.2";
      notifyListeners();
    }

  }

}