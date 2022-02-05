// import 'package:flutter_form_builder/flutter_form_builder.dart';
//
// class Temp_Code extends StatefulWidget {
//   const Temp_Code({Key? key}) : super(key: key);
//
//   @override
//   _Temp_CodeState createState() => _Temp_CodeState();
// }
//
// class _Temp_CodeState extends State<Temp_Code> {
//
//   final _formKey = GlobalKey<FormBuilderState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         FormBuilder(
//           key: _formKey,
//           autovalidate: true,
//           child: Column(
//             children: <Widget>[
//               FormBuilderFilterChip(
//                 name: 'filter_chip',
//                 decoration: InputDecoration(
//                   labelText: 'Select many options',
//                 ),
//                 options: [
//                   FormBuilderFieldOption(
//                       value: 'Test', child: Text('Test')),
//                   FormBuilderFieldOption(
//                       value: 'Test 1', child: Text('Test 1')),
//                   FormBuilderFieldOption(
//                       value: 'Test 2', child: Text('Test 2')),
//                   FormBuilderFieldOption(
//                       value: 'Test 3', child: Text('Test 3')),
//                   FormBuilderFieldOption(
//                       value: 'Test 4', child: Text('Test 4')),
//                 ],
//               ),
//               FormBuilderChoiceChip(
//                 name: 'choice_chip',
//                 decoration: InputDecoration(
//                   labelText: 'Select an option',
//                 ),
//                 options: [
//                   FormBuilderFieldOption(
//                       value: 'Test', child: Text('Test')),
//                   FormBuilderFieldOption(
//                       value: 'Test 1', child: Text('Test 1')),
//                   FormBuilderFieldOption(
//                       value: 'Test 2', child: Text('Test 2')),
//                   FormBuilderFieldOption(
//                       value: 'Test 3', child: Text('Test 3')),
//                   FormBuilderFieldOption(
//                       value: 'Test 4', child: Text('Test 4')),
//                 ],
//               ),
//               FormBuilderDateTimePicker(
//                 name: 'date',
//                 // onChanged: _onChanged,
//                 inputType: InputType.time,
//                 decoration: InputDecoration(
//                   labelText: 'Appointment Time',
//                 ),
//                 initialTime: TimeOfDay(hour: 8, minute: 0),
//                 // initialValue: DateTime.now(),
//                 // enabled: true,
//               ),
//               FormBuilderDateRangePicker(
//                 name: 'date_range',
//                 firstDate: DateTime(1970),
//                 lastDate: DateTime(2030),
//                 format: DateFormat('yyyy-MM-dd'),
//                 onChanged: _onChanged,
//                 decoration: InputDecoration(
//                   labelText: 'Date Range',
//                   helperText: 'Helper text',
//                   hintText: 'Hint text',
//                 ),
//               ),
//               FormBuilderSlider(
//                 name: 'slider',
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.min(context, 6),
//                 ]),
//                 onChanged: _onChanged,
//                 min: 0.0,
//                 max: 10.0,
//                 initialValue: 7.0,
//                 divisions: 20,
//                 activeColor: Colors.red,
//                 inactiveColor: Colors.pink[100],
//                 decoration: InputDecoration(
//                   labelText: 'Number of things',
//                 ),
//               ),
//               FormBuilderCheckbox(
//                 name: 'accept_terms',
//                 initialValue: false,
//                 onChanged: _onChanged,
//                 title: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'I have read and agree to the ',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       TextSpan(
//                         text: 'Terms and Conditions',
//                         style: TextStyle(color: Colors.blue),
//                       ),
//                     ],
//                   ),
//                 ),
//                 validator: FormBuilderValidators.equal(
//                   context,
//                   true,
//                   errorText:
//                   'You must accept terms and conditions to continue',
//                 ),
//               ),
//               FormBuilderTextField(
//                 name: 'age',
//                 decoration: InputDecoration(
//                   labelText:
//                   'This value is passed along to the [Text.maxLines] attribute of the [Text] widget used to display the hint text.',
//                 ),
//                 onChanged: _onChanged,
//                 // valueTransformer: (text) => num.tryParse(text),
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(context),
//                   FormBuilderValidators.numeric(context),
//                   FormBuilderValidators.max(context, 70),
//                 ]),
//                 keyboardType: TextInputType.number,
//               ),
//               FormBuilderDropdown(
//                 name: 'gender',
//                 decoration: InputDecoration(
//                   labelText: 'Gender',
//                 ),
//                 // initialValue: 'Male',
//                 allowClear: true,
//                 hint: Text('Select Gender'),
//                 validator: FormBuilderValidators.compose(
//                     [FormBuilderValidators.required(context)]),
//                 items: genderOptions
//                     .map((gender) => DropdownMenuItem(
//                   value: gender,
//                   child: Text('$gender'),
//                 ))
//                     .toList(),
//               ),
//             ],
//           ),
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: MaterialButton(
//                 color: Theme.of(context).colorScheme.secondary,
//                 child: Text(
//                   "Submit",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {
//                   _formKey.currentState.save();
//                   if (_formKey.currentState.validate()) {
//                     print(_formKey.currentState.value);
//                   } else {
//                     print("validation failed");
//                   }
//                 },
//               ),
//             ),
//             SizedBox(width: 20),
//             Expanded(
//               child: MaterialButton(
//                 color: Theme.of(context).colorScheme.secondary,
//                 child: Text(
//                   "Reset",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {
//                   _formKey.currentState.reset();
//                 },
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
//
// }
