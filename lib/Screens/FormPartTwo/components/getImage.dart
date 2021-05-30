//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:mi_card/components/utils/formModel.dart';
import 'package:provider/provider.dart';

class GetImage extends StatefulWidget {
  GetImage({Key key}) : super(key: key);

  @override
  _GetImageState createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  bool checkPhoto;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (checkPhoto == false)
        Provider.of<ViewModel>(context, listen: false)
            .updateCompletePercentState("imagePath", null);
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   Provider.of<ViewModel>(context, listen: false).removeListener(() {});
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: () => _getFromGallery(),
        child: Text("Upload image"),
      ),
      FutureBuilder(
          future: _checkPhoto(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("snapshotData is ${snapshot.data}");
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else {
                final formModelImage =
                    Provider.of<ViewModel>(context, listen: false).model.image;
                return snapshot.data == true
                    ? Image.file(File(formModelImage))
                    : Text("No image selected");
              }
            } else
              return CircularProgressIndicator();
          })
    ]);
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
      Provider.of<ViewModel>(context, listen: false)
          .updateCompletePercentState("imagePath", pickedFile.path);
      Provider.of<ViewModel>(context, listen: false).model.image =
          pickedFile.path;
    }
  }

  Future<bool> _checkPhoto() async {
    final img = Provider.of<ViewModel>(context, listen: true).model.image;
    checkPhoto = img != null ? await File(img).exists() : false;
    return checkPhoto == null || checkPhoto == false
        ? Future.value(false)
        : Future.value(true);
  }
}
