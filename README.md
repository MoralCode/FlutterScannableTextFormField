# scannabletextformfield

[![Pub Version](https://img.shields.io/pub/v/scannabletextformfield)](https://pub.dev/packages/scannabletextformfield)

A form field for text input in [Flutter Forms](https://docs.flutter.dev/cookbook/forms) that allows data to be scanned in via QR or barcodes in addition to being typed in.



## Usage Example

```dart
import 'package:scannabletextformfield/scannabletextformfield.dart';

//somewhere in your widget UI, ideally within a [Form]
ScannableTextFormField(
	validator: (value) {
		if (value == null || value.isEmpty) {
			return 'A value is required';
		}
		//add your own validation here if you want to verify the data being scanned is correct
		return null;
	},
	textInputDecoration: const InputDecoration(
		border: OutlineInputBorder(),
		labelText: "Label",
		hintText: "Placeholder hint text",
		helperText: 'additional help text',
	),
	scanTransformer: (data) => {
		//Optional: include this propperty if you want to transform the data from scanned codes before it gets entered into the text box, such as extracting an identifier from a URL.
		return data;
	}
)
```