import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScannableTextFormField extends StatefulWidget {
  final FormFieldValidator<String>? validator;
  final InputDecoration? textInputDecoration;

  const ScannableTextFormField(
      {super.key, this.validator, this.textInputDecoration});

  @override
  State<ScannableTextFormField> createState() => _ScannableTextFormFieldState();
}

class _ScannableTextFormFieldState extends State<ScannableTextFormField> {
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _handleScan(String newValue) {
    setState(() {
      // _value = newValue;
      myController.text = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: myController,
            // The validator receives the text that the user has entered.
            validator: widget.validator,
            decoration: widget.textInputDecoration,
          ),
        ),
        Expanded(
          flex: 0,
          child: IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () async {
              var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleBarcodeScannerPage(),
                  ));
              setState(() {
                if (res is String) {
                  _handleScan(res);
                  //TODO: maybe play sound
                }
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }
}
