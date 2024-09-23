import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmi_app_demo/controller/main_controller.dart';
import 'package:sunmi_app_demo/utils/string_constants.dart';
import 'package:sunmi_app_demo/utils/widgets/button_widget.dart';

import '../models/bar_code_item_models.dart';
import '../utils/widgets/custom_text_field_design.dart';

class GetItemDetails extends StatefulWidget {
  const GetItemDetails({super.key});

  @override
  State<GetItemDetails> createState() => _GetItemDetailsState();
}

class _GetItemDetailsState extends State<GetItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MainController>(
        builder: (BuildContext context, MainController value, Widget? child) {
          return Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFieldDesign(
                    label: 'Item Code eneter',
                    controller: value.getItemController),
                SizedBox(
                  height: 10,
                ),
                ButtonWidget(
                    text: "Get Details",
                    onClicked: () async {
                      await value.getDetailsMethod();
                      setState(() {});
                    }),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: value.getDetailsMethod(),
                  builder: (BuildContext context,
                      AsyncSnapshot<BarCodeData?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Details will be displayed here");
                    }
                    if (snapshot.hasData) {
                      var product = snapshot.data!.product;
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height:
                                      MediaQuery.sizeOf(context).height * .1,
                                  width: MediaQuery.sizeOf(context).width * .75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            StringConstants.yellowBackground),
                                        fit: BoxFit.fill,
                                        opacity: .7),
                                  ),
                                  child: ListTile(
                                    title: Text("${product.itemDescription}"),
                                    subtitle: Text(product.itemCode),
                                    trailing: Column(
                                      children: [
                                        Text("Retail Price"),
                                        Text(
                                          "\$${product.salesPrice}",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Image(
                                image: NetworkImage(
                                    "${value.server + product.barcCode}"),
                                height: 80,
                                width: MediaQuery.sizeOf(context).width * .7,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("${product.unitCode}")
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Text("No data");
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code_scanner),
        onPressed: () async {
          Provider.of<MainController>(context,listen: false).scannBarCode();
        },
      ),
    );
  }
}
