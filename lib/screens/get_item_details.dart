import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmi_app_demo/controller/main_controller.dart';

import '../utils/widgets/custom_text_field_design.dart';

class GetItemDetails extends StatelessWidget {
  const GetItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(
      child: Consumer<MainController>(builder: (BuildContext context, MainController value, Widget? child) {
        return Form(
          child: Column(
            children: [
              CustomTextFieldDesign(label: '', controller: value.getItemController,),


            ],
          ),
        );
      },)
    ),);
  }
}
