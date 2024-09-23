import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:barcode_widget/barcode_widget.dart';

import '../controller/main_controller.dart';
import '../utils/widgets/button_widget.dart';
import '../utils/widgets/custom_text_field_design.dart';

class BarcodeGeneratorPage extends StatefulWidget {
  const BarcodeGeneratorPage({super.key});

  @override
  State<BarcodeGeneratorPage> createState() => _BarcodeGeneratorPageState();
}

class _BarcodeGeneratorPageState extends State<BarcodeGeneratorPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Consumer<MainController>(
            builder:
                (BuildContext context, MainController value, Widget? child) {
              return Form(
                child: Column(
                  children: [
                    CustomTextFieldDesign(
                      label: 'Item Code',
                      hint: '092787',
                      controller: value.itemCOde,
                    ),
                    CustomTextFieldDesign(
                      label: 'Item Description',
                      hint: 'Item Description',
                      controller: value.itemDescription,
                    ),
                    CustomTextFieldDesign(
                      label: 'Arabic Description',
                      controller: value.arabicItemDescription,
                    ),
                    CustomTextFieldDesign(
                      label: 'Sales Price',
                      controller: value.salesPrice,
                    ),
                    // CustomTextFieldDesign(
                    //   label: 'BarCode',
                    //   controller: value.barCode,
                    // ),
                    CustomTextFieldDesign(
                      label: 'Unit Code',
                      hint: '907-5345-98',
                      controller: value.unitCode,
                    ),
                    value.itemCOde.text.isEmpty
                        ? const SizedBox()
                        : RepaintBoundary(
                            key: value.globalKey, // Key to capture the widget
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(16),
                              child: BarcodeWidget(
                                barcode: Barcode.code128(),
                                data: value.itemCOde.text,
                                width: 200,
                                height: 200,
                                drawText: false,
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                      text: "Add Data",
                      onClicked: () async {
                        setState(() {

                        });
                        // Capture barcode image and upload it
                        Provider.of<MainController>(context, listen: false)
                            .captureBarcodeAndSave(value, context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
