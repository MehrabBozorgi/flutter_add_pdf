import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FileScreen extends StatefulWidget {
  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  FilePickerResult? result;
  File? file;
  FilePickerStatus? filePickerStatus;
  var _value;
  var _fileName;
  var _fileSize;
  Uint8List? bytes;

  Future getImage_FilePicker() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowCompression: true,
    );
    file = File(result!.files.single.path.toString());
    //Pdf Size
    bytes = file!.readAsBytesSync();
    final mb = bytes!.lengthInBytes / 1024 / 1024;

    setState(() {
      _value = file;
      _fileName = result!.names;
      _fileSize = mb.toString().substring(0, 4);
    });

    print('============');
    print('${_value}');
    print('${_fileName}');
    print('${_fileSize}');

    print('============');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        getImage_FilePicker();
                      },
                      child: _value == null || _value == '0'
                          ? Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.picture_as_pdf,
                                    size: 150,
                                  ),
                                ),
                                Text(
                                  'انتخاب',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            )
                          : Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Theme.of(context).accentColor,
                                    width: 1),
                              ),
                              child: SfPdfViewer.file(
                                _value,
                                scrollDirection: PdfScrollDirection.vertical,
                                canShowScrollHead: false,
                                canShowScrollStatus: false,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              _fileName != null
                  ? _fileName != '0'
                      ? _value != '0'
                          ? Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    _fileName
                                        .toString()
                                        .replaceAll('[', '')
                                        .replaceAll(']', ''),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                Text(
                                  '${_fileSize}KB',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            )
                          : Container()
                      : Container()
                  : Container(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
