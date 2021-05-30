import 'package:flutter/material.dart';
import 'package:mi_card/components/text_field_container.dart';
import 'package:mi_card/constants.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String Function(String) func;
  final String initialValue;
  RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.initialValue,
      this.func})
      : super(key: key);

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  TextEditingController textCntrl = TextEditingController();

  @override
  void initState() {
    textCntrl.text = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: textCntrl,
        validator: widget.func,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        //focusNode: widget._focus,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
