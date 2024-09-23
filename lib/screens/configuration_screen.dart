import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmi_app_demo/controller/configuration_page_controller.dart';
import 'package:sunmi_app_demo/controller/helper_services.dart';
import 'package:sunmi_app_demo/screens/get_item_details.dart';
import 'package:sunmi_app_demo/utils/widgets/button_widget.dart';

import '../utils/widgets/custom_text_field_design.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ConfigurationPageController>(context,listen: false).configurePageInitialization();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<ConfigurationPageController>(builder: (BuildContext context, ConfigurationPageController value, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Database Config.",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                CustomTextFieldDesign(
                  enable: value.enableTextField,
                  label: 'Server name',
                  hint: '192.168.100.75',
                  controller: value.serverNameController,
                ),
                CustomTextFieldDesign(
                  enable: value.enableTextField,
                  label: 'Database Name',
                  hint: 'TechSysDB',
                  controller: value.dataBaseNameController,
                ),
                CustomTextFieldDesign(
                  enable: value.enableTextField,
                  label: 'Table Name',
                  hint: 'Products',
                  controller:value. tableName,
                ),
                CustomTextFieldDesign(
                  label: 'Username',
                  hint: 'root',
                  controller:value. userName,
                ),
                CustomTextFieldDesign(
                  label: 'password',
                  hint: '12345678',
                  controller:value. password,
                ),
                CustomTextFieldDesign(
                  label: 'IP Address',
                  hint: '192.168.100.10',
                  controller:value. ipAddress,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      text: "Configure",
                      onClicked: () async {
Provider.of<ConfigurationPageController>(context,listen: false).saveConfiguration();
                        if (!context.mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GetItemDetails(),
                            ));
                      },
                    ),SizedBox(width: 20,),ButtonWidget(
                      text: "Reset",
                      onClicked: () async {
                        await HelperServices.setConfiguration(false);
                        if(!context.mounted) return;
                        Provider.of<ConfigurationPageController>(context,listen: false).configurePageInitialization();
                      },
                    ),
                  ],
                )
              ],
            );
          },),
        ),
      ),
    );
  }
}
