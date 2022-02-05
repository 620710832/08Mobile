import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<HomePage> {
  var game = Game();
  String _input = "";
  String _output = "ทายเลข 1 ถึง 100";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess The Number'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.5),
                blurRadius: 5.0,
                offset: const Offset(1.0, 1.0),
              )],

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/guess_logo.png', width: 100.0),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('GUESS',style: TextStyle(fontSize: 36.0, color: Colors.purple.shade200),),
                      Text('THE NUMBER', style: TextStyle(fontSize: 18.0, color: Colors.purple),)
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_input,style: TextStyle(fontSize: 40.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_output,style: TextStyle(fontSize: 15.0)),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int i=1;i<=3;i++)
                        _button(i),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int i=4;i<=6;i++)
                        _button(i),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int i=7;i<=9;i++)
                        _button(i),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(-2),
                      _button(0),
                      _button(-1),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  onPressed: () {
                    int? input = int.tryParse(_input);
                    var Result = game.doGuess(input!);
                    setState(() {
                      if (Result == 1) {
                        _output = "$_input : ค่ามากเกินไป";
                        _input = "";
                      } else if (Result == -1) {
                        _output = "$_input : ค่าน้อยเกินไป";
                        _input = "";
                      } else {
                        _output = "$_input : ค่าถูกต้อง ทายไปทั้งหมด ${game.guessCount} ครั้ง";
                      }
                    });
                  },
                  child: const Text('GUESS',style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _button(int num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(30.0),
        child: OutlinedButton(
          onPressed: (){
            if(num==-1){
              setState(() {
                //'12345'
                var length = _input.length;
                _input = _input.substring(0, length - 1);
              });
            }
            else if (num == -2) {
              setState(() {
                _input = '';
              });
            } else {
              setState(() {
                if(_input.length<=2) {
                  _input = "$_input$num";
                }
              }
              );
              print('pressed $num');
            }
          },

          child: (num == -1) ? Icon(Icons.backspace_outlined)
              :(num==-2)?Icon(Icons.close): Text("$num"),
        ),
      ),
    );
  }
}