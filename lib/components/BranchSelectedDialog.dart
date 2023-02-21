import 'package:flutter/material.dart';

class BranchSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select a branch'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Branch 1'),
            onTap: () {
              // TODO: Handle selection
            },
          ),
          ListTile(
            title: Text('Branch 2'),
            onTap: () {
              // TODO: Handle selection
            },
          ),
          ListTile(
            title: Text('Branch 3'),
            onTap: () {
              // TODO: Handle selection
            },
          ),
        ],
      ),
    );
  }
}
