import 'package:flutter/material.dart';

class MultiSelectDialog extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;

  MultiSelectDialog({required this.options, required this.selectedOptions});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<String> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    selectedOptions = List.from(widget.selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Text(
        "Select Aircraft Types",
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.options.map((aircraft) {
            return CheckboxListTile(
              value: selectedOptions.contains(aircraft),
              title: Text(
                aircraft,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              onChanged: (isChecked) {
                setState(() {
                  if (isChecked == true) {
                    selectedOptions.add(aircraft);
                  } else {
                    selectedOptions.remove(aircraft);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          onPressed: () => Navigator.of(context).pop(selectedOptions),
        ),
      ],
    );
  }
}
