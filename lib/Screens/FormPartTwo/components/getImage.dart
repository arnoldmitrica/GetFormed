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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width / 8),
      child: Consumer<ViewModel>(builder: (imageContext, form, child) {
        Image image;
        try {
          final val = File(form.model.values["imagePath"]).existsSync();
          if (val == false) {
            _image = null;
            throw ErrorDescription("No image");
          } else {
            _image = File(form.model.values["imagePath"]);
          }
        } catch (err) {
          print(err.toString());
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _getFromGallery(),
              child: Text("Upload image"),
            ),
            _image == null
                ? Text('No image selected.')
                //Provider.of<ViewModel>(imageContext, listen: false)
                //.updateCompletePercentState("imagePath", null)
                : Image.file(_image),
          ],
        );
      }),
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
}
