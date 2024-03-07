import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController inputController = TextEditingController();
  String result = "";

  Future<void> callApi() async {
    try {
      var inputData = inputController.text;

      if (inputData.isEmpty) {
        setState(() {
          result = "Error: Input is empty";
        });
        return;
      }

      dynamic requestBody;
      if (int.tryParse(inputData) != null) {
        requestBody = {'number': int.parse(inputData)};
      } else {
        requestBody = {'name': inputData};
      }

      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/hello'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          result = data['message'];
        });
        print('222222222222 $result');
      } else {
        setState(() {
          result = "Error: ${response.statusCode}";
        });
        print(result);
      }
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                labelText: 'Enter a name or number',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                callApi();
              },
              child: Text('Call API'),
            ),
            SizedBox(height: 20),
            Text(
              'API Response:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(result),
          ],
        ),
      ),
    );
  }
}
