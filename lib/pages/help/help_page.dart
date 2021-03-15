import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  Widget helpTopic({String? title, String? content, Icon? icon}) {
    return Card(
      elevation: 20,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon != null) ...[
              icon,
              SizedBox(
                width: 15,
              ),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ...[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                  Text(
                    content ?? '',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.help,
              size: 22,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Help')
          ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            helpTopic(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: 'Detele Item',
                content:
                    'Swipe right to left on an item then tap on delete to confirm.'),
            helpTopic(
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                title: 'Edit Item',
                content: 'Long tap on an item to edit.'),
          ],
        ),
      ),
    );
  }
}
