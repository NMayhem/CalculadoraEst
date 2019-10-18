import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

void main() => runApp(timCalc());

class timCalc extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Estado();
  }
}

class Estado extends State{
  final timeFormat = DateFormat("h:mm a");
  final now = new DateTime.now();
  double cHora = 0;
  double cFraccion = 0;
  String total = "";
  TimeOfDay inicio;
  TimeOfDay fin;
  Duration diff;
  var i;
  var f;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de estacionamientos'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (cambio){
                  setState(() {
                    cHora = double.parse(cambio);
                  });
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Costo 1ra Hora',
                  hintText: '',
                  helperText: 'Introduzca el costo de la primera hora.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
              TextField(
                onChanged: (cambio){
                  setState(() {
                    cFraccion = double.parse(cambio);
                  });
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.attach_money),
                  labelText: 'Costo por fraccion',
                  hintText: '',
                  helperText: 'Introduzca el costo por cada 15 minutos.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: TimePickerFormField(
                  format: timeFormat,
                  decoration: InputDecoration(labelText: 'Inicio'),
                  onChanged: (t){
                    setState(() {
                      print(t);
                      inicio = t;
                      i.add( Duration(hours: t.hour, minutes: t.minute));
                      Duration duracion = i.difference(f);
                      tim = duracion.toString();
                    });
                  }
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TimePickerFormField(
                  format: timeFormat,
                  decoration: InputDecoration(labelText: 'Inicio'),
                  onChanged: (t) => setState(() => inicio = t),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TimePickerFormField(
                  format: timeFormat,
                  decoration: InputDecoration(labelText: 'Fin'),
                  onChanged: (t) => setState(() => fin = t),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('A pagar: \$$total', style: TextStyle(fontSize: 40),)
              ),
            ],
          )
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {

              i = new DateTime(2000, 1, 1, inicio.hour, inicio.minute);
              f = new DateTime(2000, 1, 1, fin.hour, fin.minute);
              diff = f.difference(i);

              if (!diff.isNegative) {
                if (diff.inMinutes<60) {
                  total = cHora.toStringAsFixed(2);
                }
                else {
                  total = ((((diff.inMinutes-60)/15).ceil()*cFraccion)+cHora).toStringAsFixed(2);
                }
              }
              else {
                if ((1440+diff.inMinutes)<60) {
                  total = cHora.toStringAsFixed(2);
                }
                else {
                  total = ((((1440+diff.inMinutes-60)/15).ceil()*cFraccion)+cHora).toStringAsFixed(2);
                }
              }

              print(diff.inMinutes);
            });
          },
          label: Text('Calcular'),
          icon: Icon(Icons.add)
        ),
      ),
    );
  }

}