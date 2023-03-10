import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScannableTextFormField extends StatefulWidget {
  final FormFieldValidator<String>? validator;
  final InputDecoration? textInputDecoration;
  final String Function(String)? scanTransformer;

  /// Creates a form field with a text box and a button to allow text to be scanned in from a QR code or barcode
  ///
  /// [validator] is a function used to validate the input to the text box when submitted. This is just like the validator from [TextFormField]
  /// [textInputDecoration] is also a passthrough to allow text decoration elements of the [TextFormField] to be customized
  /// [scanTransformer] is a function that allows scan data to be transformed before it is sent to the text field. This can be useful for transforming data (like parsing an ID from a URL) from the scanned code. This could also be a place where sound could be played if preferred.
  const ScannableTextFormField(
      {super.key,
      this.validator,
      this.textInputDecoration,
      this.scanTransformer});

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
                // in this case if a scan value of -1 comes back, it means the scanner was canceled without scanning anything, so ignore it
                // currently waiting for the library maintainers to add a more proper callback for this
                //https://github.com/AmolGangadhare/flutter_barcode_scanner/issues/26
                if (res is String && res != "-1") {
                  if (widget.scanTransformer != null) {
                    res = widget.scanTransformer!(res);
                  }
                  _handleScan(res);
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
    // Clean up the controller when the widget is removed from the widget tree.
    myController.dispose();
    super.dispose();
  }
}
