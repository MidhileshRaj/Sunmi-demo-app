import 'package:flutter/material.dart';
import 'package:sunmi_app_demo/utils/string_constants.dart';

import 'helper_services.dart';

class ConfigurationPageController extends ChangeNotifier {
  TextEditingController serverNameController = TextEditingController();

  TextEditingController dataBaseNameController = TextEditingController();

  TextEditingController tableName = TextEditingController();

  TextEditingController userName = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController ipAddress = TextEditingController();
  bool enableTextField = true;

  configurePageInitialization() async {
    var server = await HelperServices.getServerData(StringConstants.server);
    var table = await HelperServices.getServerData(StringConstants.table);
    var database = await HelperServices.getServerData(StringConstants.dataBase);
    var isConfigured = await HelperServices.checkConfiguration();
    print(isConfigured);
    if ( isConfigured) {
      enableTextField = false;

      serverNameController.text = server;
      dataBaseNameController.text = database;
      tableName.text = table;
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

  saveConfiguration() async {
    await HelperServices.saveServerData(
        StringConstants.server, serverNameController.text);
    await HelperServices.saveServerData(
        StringConstants.table, tableName.text);
    await HelperServices.saveServerData(
        StringConstants.dataBase, dataBaseNameController.text);
    await HelperServices.saveServerData(StringConstants.table, tableName.text);
    await HelperServices.saveServerData(
        StringConstants.userName, userName.text);
    await HelperServices.setConfiguration(true);
  }
}
