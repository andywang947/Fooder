import 'package:flutter/material.dart';

class FloatingSideList extends StatefulWidget {
  @override
  _FloatingSideListState createState() => _FloatingSideListState();
}

class _FloatingSideListState extends State<FloatingSideList> {
  bool _isVisible = true;
  Map<int, bool> _checkboxValues = {1: true, 2: true, 3: true};

  // Toggle visibility of the side list
  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  // Update the checkbox value when clicked
  void _onCheckboxChanged(int index, bool? value) {
    setState(() {
      _checkboxValues[index] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content of your page can go here
        Positioned(
          top: 5,
          right: 5,
          child: ElevatedButton(
            onPressed: _toggleVisibility,
            child: Text(_isVisible ? "Hide Side List" : "Show Side List"),
          ),
        ),
        
        // Floating side list that can be toggled
        if (_isVisible)
          Positioned(
            top: 60,
            right: 0,
            child: Material(
              elevation: 8.0,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 200,
                height: 400,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Floating Side List",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    // Checkbox List
                    ..._checkboxValues.keys.map((index) {
                      return CheckboxListTile(
                        title: Text("Option $index"),
                        value: _checkboxValues[index],
                        onChanged: (value) {
                          _onCheckboxChanged(index, value);
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
