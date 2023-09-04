import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ScreenA(),
        '/screenB': (context) => ScreenB(),
      },
    );
  }
}

class ScreenA extends StatefulWidget {
  @override
  _ScreenAState createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> {
  final TextEditingController sentence1Controller = TextEditingController();
  final TextEditingController sentence2Controller = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layar A'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: sentence1Controller,
              decoration: InputDecoration(labelText: 'Kalimat 1'),
            ),
            TextField(
              controller: sentence2Controller,
              decoration: InputDecoration(labelText: 'Kalimat 2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final String? processedResult = await Navigator.pushNamed(
                  context,
                  '/screenB',
                  arguments: {
                    'kalimat1': sentence1Controller.text,
                    'kalimat2': sentence2Controller.text,
                  },
                ) as String?;

                setState(() {
                  result = processedResult ?? '';
                });
              },
              child: Text('Buka ke Layar B'),
            ),
            SizedBox(height: 20),
            Text('Hasil: $result'),
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>? ??
            {};
    final String kalimat1 = args?['kalimat1'] ?? '';
    final String kalimat2 = args?['kalimat2'] ?? '';
    final String result = processSentences(kalimat1, kalimat2);

    return Scaffold(
      appBar: AppBar(
        title: Text('Layar B'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hasil: $result'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, result);
              },
              child: Text('Kembali ke Layar A'),
            ),
          ],
        ),
      ),
    );
  }

  String processSentences(String kalimat1, String kalimat2) {
    String result = '';

    for (int i = 0; i < kalimat1.length; i++) {
      final char = kalimat1[i]!;
      if (char != ' ' && kalimat2.contains(char) && !result.contains(char)) {
        result += char;
      }
    }

    return result;
  }
}
