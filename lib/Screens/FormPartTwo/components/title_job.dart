import 'package:flutter/material.dart';
import 'package:mi_card/components/rounded_input_field.dart';
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:provider/provider.dart';

class GetTitleJob extends StatefulWidget {
  GetTitleJob({Key key}) : super(key: key);

  @override
  _GetTitleJobState createState() => _GetTitleJobState();
}

class _GetTitleJobState extends State<GetTitleJob> {
  TextEditingController jobTitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ViewModel>(builder: (titleJobContext, form, child) {
      print("jobTitleeeee");
      return FocusScope(
        onFocusChange: (focus) {
          if (focus == false) {
            form.updateCompletePercentState("jobTitle", jobTitle.text);
          }
        },
        child: RoundedInputField(
            func: nameValidator,
            hintText: "Your job title",
            onChanged: (value) {
              jobTitle.text = value;
            }),
      );
    });
  }
}

Function(String) nameValidator = (String name) {
  if (name.isNotEmpty && name.length > 2) {
    print('name $name');
    return null;
  } else {
    return "Name is invalid";
  }
};
