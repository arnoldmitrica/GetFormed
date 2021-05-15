// import 'package:flutter/material.dart';
// import 'package:rsvp_form_app/scoped-model/main.dart';
// import 'package:rsvp_form_app/utils/button.dart';
// import 'package:rsvp_form_app/utils/colors.dart';
// import 'package:rsvp_form_app/utils/constants.dart';
// import 'package:scoped_model/scoped_model.dart';

// class FormPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _FormPageState();
// }

// class _FormPageState extends State<FormPage> {
//   Map<String, dynamic> _formData = <String, dynamic>{
//     'name': '???',
//     'ticket': 0,
//     'gender': 0,
//     'food': false,
//   };

//   BuildContext context;

//   List<String> options = [];
//   int _ticketCounter = 0;
//   final _nameTextController = TextEditingController();
//   bool _validateName = false;

//   void _resetFields() {
//     _nameTextController.text = '';
//     Map<String, dynamic> _formData = <String, dynamic>{
//       'name': '???',
//       'ticket': 0,
//       'gender': 0,
//       'food': false,
//     };

//     setState(() {
//       _ticketCounter = 0;
//       _validateName = false;
//     });
//   }

//   void _showDialog(String title, String content) {
//     showDialog<AlertDialog>(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(title),
//             content: Text(content),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text(ALERT_OK),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }

//   void _handleGenderChange(int value) =>
//       setState(() => _formData['gender'] = value);

//   void _handleFoodOption(bool value) =>
//       setState(() => _formData['food'] = value);

//   ListTile getNameInputListTile() {
//     return ListTile(
//       leading: Padding(
//         padding: EdgeInsets.only(left: 8.0, top: 16.0),
//         child: Text(
//           YOUR_NAME,
//           style: Theme.of(context).textTheme.subtitle,
//         ),
//       ),
//       title: Padding(
//         padding: EdgeInsets.only(top: 10.0),
//         child: Theme(
//           data: ThemeData(
//             primaryColor: mRegistrationBlack,
//             primaryColorDark: mRegistrationBlack,
//           ),
//           child: Container(
//             height: 40.0,
//             child: TextField(
//               style: Theme.of(context).textTheme.subtitle,
//               controller: _nameTextController,
//               textCapitalization: TextCapitalization.words,
//               decoration: InputDecoration(
//                   fillColor: mRegistrationBlack,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       Icons.clear,
//                       color: mRegistrationBlack,
//                     ),
//                     onPressed: () {
//                       _nameTextController.clear();
//                     },
//                   ),
//                   hintText: HINT_NAME,
//                   labelText: LABEL_NAME),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget getTicketCounter() {
//     return ListTile(
//       leading: Padding(
//         padding: EdgeInsets.only(left: 8.0, top: 8.0),
//         child: Text(
//           NO_TICKETS,
//           style: Theme.of(context).textTheme.subtitle,
//         ),
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.remove),
//             color: mRegistrationBlack,
//             onPressed: () {
//               if (_ticketCounter > 0) {
//                 setState(() {
//                   _ticketCounter--;
//                 });
//               } else {
//                 _formData['ticket'] = _ticketCounter;
//               }
//             },
//           ),
//           Text(
//             _ticketCounter.toString(),
//             style: Theme.of(context).textTheme.title,
//           ),
//           IconButton(
//             icon: Icon(Icons.add),
//             color: mRegistrationBlack,
//             onPressed: () {
//               if (_ticketCounter < 9) {
//                 setState(() {
//                   _ticketCounter++;
//                 });
//               } else {
//                 _formData['ticket'] = _ticketCounter;
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget getGenderOption(){

//     return ListTile(
//       leading: Padding(
//         padding: EdgeInsets.only(left: 8.0,top: 4.0),
//         child: Text(
//           GENDER,
//           style: Theme.of(context).textTheme.subtitle,
//         ),
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Radio(
//             activeColor: mRegistrationBlack,
//             value: 0,
//             groupValue: _formData['gender'] as int,
//             onChanged: _handleGenderChange,
//           ),
//           Text(
//             GENDER_CHOICES[0],
//             style: Theme.of(context).textTheme.subtitle,
//           ),
//           Radio(
//             activeColor: mRegistrationBlack,
//             value: 1,
//             groupValue: _formData['gender'] as int,
//             onChanged: _handleGenderChange,
//           ),
//           Text(
//             GENDER_CHOICES[1],
//             style: Theme.of(context).textTheme.subtitle,
//           ),
//         ],
//       ),
//     );

//   }

//   Widget getFoodOption(){
//     return Padding(
//       padding: EdgeInsets.only(bottom: 12.0),
//       child: ListTile(
//         leading: Checkbox(
//           activeColor: mRegistrationBlack,
//           onChanged: _handleFoodOption,
//           value: _formData['food'] as bool,
//         ),
//         title: InkWell(
//           onTap: (){
//             setState(() {
//               _formData['food'] = !_formData['food'];
//             });
//           },
//           child: Text(
//             NEED_FOOD,
//             style: Theme.of(context).textTheme.subtitle,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget getSectionHeader(String title){

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(top: 18.0,left: 22),
//           child: Text(
//             title,
//             style: Theme.of(context).textTheme.headline,
//           ),

//         ),
//         Padding(
//           padding: EdgeInsets.only(left: 18.0,right: 18.0),
//           child: Divider(
//             color: mYankeeBlue,
//           ),
//         )
//       ],
//     );

//   }

//   Widget getSubmitButton(){

//     return Padding(
//       padding: EdgeInsets.only(bottom: 16.0),
//       child: Center(
//         child: FormAppButton(text: SUBMIT,action: _submitForm).getButton(context),
//       ),
//     );

//   }

//   void _submitForm(){

//     _formData['name'] = _nameTextController.text;

//     setState(() {
//       _nameTextController.text.isEmpty
//           ? _validateName = true
//           : _validateName = false;
//     });

//     MainModel _model = ScopedModel.of(context);

//     if(!_validateName){
//       final bool success = _model.submit(_formData);

//       if(success) {
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text(TITLE_SUBMISSION_SUCCESS),
//                 content: Text(MESSAGE_SUBMISSION_SUCCESS),
//                 actions: <Widget>[
//                   FlatButton(
//                     child: Text(ALERT_OK),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       _resetFields();
//                     },
//                   )
//                 ],
//               );
//             }
//         );
//       }else{
//         _showDialog(TITLE_ERROR, MESSAGE_ERROR);
//       }
//     }else{
//       _showDialog(TITLE_VALIDATION, MESSAGE_VALIDATION);
//     }
//   }

//   List<Widget> renderForm(){
//     return[
//       getSectionHeader(SECTION_YOUR_DETAILS),
//       getNameInputListTile(),
//       getGenderOption(),
//       getSectionHeader(SECTION_TICKET),
//       getTicketCounter(),
//       getSectionHeader(SECTION_FOOD),
//       getFoodOption(),
//       getSubmitButton()
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     this.context = context;

//     return Scaffold(
//       body: ListView(
//         children: renderForm(),
//       ),
//     );
//   }

// }
