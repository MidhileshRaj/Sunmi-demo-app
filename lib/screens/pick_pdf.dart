import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:oversea_mip/screens/image_preview.dart';
import 'package:oversea_mip/screens/preview_pdf.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_filex/open_filex.dart';  // For opening non-renderable file types

class FilePickerDemo extends StatefulWidget {
  const FilePickerDemo({super.key});

  @override
  FilePickerDemoState createState() => FilePickerDemoState();
}

class FilePickerDemoState extends State<FilePickerDemo> {
  FilePickerResult? result;

  late PDFViewController pdfViewController ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          result = await FilePicker.platform
              .pickFiles(allowMultiple: true);
          if (result == null) {
          } else {
            setState(() {});
          }
        },
          child: const Icon(Icons.add),),
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: result != null?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: result?.files.length ?? 0,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 500,
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(
                        children: [
                          SizedBox(
                            height:400,width: MediaQuery.sizeOf(context).width,
                            child: PDFView(
                              filePath:result!.files[index].path,
                              autoSpacing: true,
                              enableSwipe: true,
                              pageSnap: true,
                              swipeHorizontal: true,
                              onError: (error) {
                              },
                              onPageError: (page, error) {
                              },
                              onViewCreated: (PDFViewController vc) {
                                pdfViewController = vc;
                              },
                              onPageChanged: (page, total) {
                              },
                            ),
                          ),
                          Text(result!.files[index].name),
                          ElevatedButton(
                            onPressed: () {
                              _displayFile(result!.files[index]);
                            },
                            child: Text(
                              'Display ${result!.files[index].extension?.toUpperCase() ?? 'FILE'}',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                ),
              ),
            ):const SizedBox(),
        ),
      ),
    );
  }

  void _displayFile(PlatformFile file) {
    // Determine the file type based on the file extension
    final extension = file.extension?.toLowerCase();

    if (extension == 'pdf') {
      _displayPdf(file);
    } else if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
      _displayImage(file);
    } else if (extension == 'docx') {
      _openFileExternally(file);  // Handle `.docx` by opening externally or converting it to `.pdf`
    } else {
      _openFileExternally(file);  // Handle unsupported types by opening externally
    }
  }

  void _displayPdf(PlatformFile file) {
    // Display the PDF in a preview screen using flutter_pdfview
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(filePath: file.path!),
      ),
    );
  }

  void _displayImage(PlatformFile file) {
    // Display the image using Image.file
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(imageFile: File(file.path!)),
      ),
    );
  }

  void _openFileExternally(PlatformFile file) {
    // Open unsupported file types with the system default application
    OpenFilex.open(file.path.toString());
  }
}
//
