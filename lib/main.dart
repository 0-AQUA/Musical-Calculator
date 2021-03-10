import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

void main() {
  SoundGenerator.release();
  SoundGenerator.init(96000);
  SoundGenerator.setVolume(1);
  SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calcul8r',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.pink,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CalculatorButtonGrid(),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AspectRatio(
                  aspectRatio: 4.0,
                  child: Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Test",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CalculatorButton(
      {Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      debugPrint("${boxConstraints.hasBoundedWidth}");
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width / 7,
            child: RaisedButton(
              child: Text(text),
              onPressed: onPressed,
              color: Colors.pink,
              textColor: Colors.white,
            ),
          ),
        ),
      );
    });
  }
}

class CalculatorButtonGrid extends StatelessWidget {
  final int _numColumns = 4;
  final List<List> buttonList = [
    [
      "1",
      () async {
        SoundGenerator.setFrequency(440);
        SoundGenerator.play();
      }
    ],
    [
      "2",
      () async {
        SoundGenerator.setFrequency(466);
        SoundGenerator.play();
      }
    ],
    [
      "3",
      () async {
        SoundGenerator.setFrequency(493);
        SoundGenerator.play();
      }
    ],
    [
      "4",
      () async {
        SoundGenerator.setFrequency(523);
        SoundGenerator.play();
      }
    ],
    [
      "5",
          () async {
        SoundGenerator.setFrequency(554);
        SoundGenerator.play();
      }
    ],
    [
      "6",
          () async {
        SoundGenerator.setFrequency(587);
        SoundGenerator.play();
      }
    ],
    [
      "7",
          () async {
        SoundGenerator.setFrequency(622);
        SoundGenerator.play();
      }
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _generateRows(),
    );
  }

  List<Widget> _generateRows() {
    List<Widget> rows = [];
    List<CalculatorButton> buttons = [];
    for (int i = 0; i < buttonList.length; i++) {
      buttons.add(CalculatorButton(
          text: buttonList[i][0], onPressed: buttonList[i][1]));
      if (i != 0 && i % _numColumns == 0 || i == buttonList.length - 1) {
        rows.add(Row(
          children: buttons,
        ));
        debugPrint("${buttons.length}");
        buttons = [];
      }
    }
    debugPrint(rows.length.toString());
    return rows;
  }
}
