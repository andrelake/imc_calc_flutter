import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = 'Informe seus dados';

  GlobalKey<FormState> _formKey = GlobalKey();

  void _resetFields() {

    weightController.text = '';
    heightController.text = '';
    _infoText = 'Informe seus dados';


    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {

    setState(() {
      
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);

      double imc = weight / pow(height/100, 2);

      if(imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsFixed(2)})';
      }
      else if(imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso ideal (${imc.toStringAsFixed(2)})';
      }
      else if(imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente acima do peso (${imc.toStringAsFixed(2)})';
      }
      else if(imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade grau 1 (${imc.toStringAsFixed(2)})';
      }
      else if(imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade grau 2 (${imc.toStringAsFixed(2)})';
      }
      else {
        _infoText = 'Obesidade grau 3 (${imc.toStringAsFixed(2)})';
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC CALC'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_rounded,
                size: 120,
                color: Colors.indigo,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (kg):',
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24
                ),
                controller: weightController,
                // ignore: missing_return
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Insira seu peso';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm):',
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24
                ),
                controller: heightController,
                // ignore: missing_return
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Insira sua altura!';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                      child: Text('Calcular',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.indigo)
                      ),
                      onPressed: () {
                        if(_formKey.currentState.validate()) {
                          _calculate();
                        }
                      }
                      ),
                ),
              ),
              Text(_infoText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

