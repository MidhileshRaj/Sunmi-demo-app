import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sunmi_app_demo/controller/main_controller.dart';

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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code_scanner),
        onPressed: () async {
          try {
            final barcode = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666',
              'Cancel',
              true,
              ScanMode.DEFAULT,
            );
            if (!context.mounted) return;

            // this.barcode = barcode;
          } on PlatformException {
            // barcode = 'Failed to get platform version.';
          }
        },
      ),
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
                    CustomTextFieldDesign(
                      label: 'BarCode',
                      controller: value.barCode,
                    ),
                    CustomTextFieldDesign(
                      label: 'Unit Code',
                      hint: '907-5345-98',
                      controller: value.unitCode,
                    ),
                    ButtonWidget(
                      text: "Add Data",
                      onClicked: () async {

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
