import 'package:flutter/material.dart';
import 'package:nova_maps/Views/HomePage.dart';

class UniversityChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose an University'), //  Updated title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Added padding around the column
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UniversityButton(
                text: "NOVA FCT",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
              ),
              SizedBox(height: 16), // Added spacing between buttons
              UniversityButton(
                text: 'NOVA Medical School',
                onPressed: () {
                  _showInDevelopmentPopup(context);
                },
              ),
              SizedBox(height: 16), // Added spacing between buttons
              UniversityButton(
                text: 'NOVA FCSH',
                onPressed: () {
                  _showInDevelopmentPopup(context);
                },
              ),

              SizedBox(height: 16), // Added spacing between buttons
              UniversityButton(
                text: 'NOVA IMS',
                onPressed: () {
                  _showInDevelopmentPopup(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void _showInDevelopmentPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('In Development'),
        content: Text('This map is not finished.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

class UniversityButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  UniversityButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: EdgeInsets.all(16),
          textStyle: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
