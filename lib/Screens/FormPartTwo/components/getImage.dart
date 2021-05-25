//import 'dart:html';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:provider/provider.dart';

class GetImage extends StatefulWidget {
  GetImage({Key key}) : super(key: key);

  @override
  _GetImageState createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  File _image;
  bool checkPhoto;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkPhoto == false
          ? Provider.of<ViewModel>(context, listen: false)
              .updateCompletePercentState("imagePath", null)
          : null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _getFromGallery(),
          child: Text("Upload image"),
        ),
        Consumer<ViewModel>(builder: (imageContext, form, child) {
          return FutureBuilder(
              future: _checkPhoto(form.model.values["imagePath"]),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print("snapshotData is ${snapshot.data}");
                  if (snapshot.hasError)
                    return Text(snapshot.error.toString());
                  else {
                    return snapshot.data == true
                        ? Image.file(File(form.model.values["imagePath"]))
                        : Text("No image selected");
                  }
                } else
                  return CircularProgressIndicator();
              });
        })
      ],
    );
  }

  _getFromGallery() async {
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 200,
    );
    print('pickedfile ${pickedFile.path}');
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      Provider.of<ViewModel>(context, listen: false)
          .updateCompletePercentState("imagePath", pickedFile.path);
    }
  }

  Future<bool> _checkPhoto(String path) async {
    print("path is $path");
    checkPhoto = path != null ? await File(path).exists() : false;
    return path == null ? Future.value(false) : checkPhoto;
  }
}
