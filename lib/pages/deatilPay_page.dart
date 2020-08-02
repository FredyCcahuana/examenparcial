import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPayPage extends StatefulWidget {
  final String codigoAlumno;

  const DetailPayPage({Key key, this.codigoAlumno}) : super(key: key);
  @override
  _DetailPayPageState createState() => _DetailPayPageState();
}

class _DetailPayPageState extends State<DetailPayPage> {
  String icono;
  String color;
  List data;
  String concepto;
  String conceptoSgte;
  double subTotal =0;
  double total = 0;
  double aux = 0;
  List usersData;

  Color primary = Colors.indigo[900];
  final secondary = Color(0xfff29a94);
  getUsers() async {
    http.Response response = await http.get(
        'https://sigapdev2-consultarecibos-back.herokuapp.com/recaudaciones/alumno/concepto/listar_cod/'+widget.codigoAlumno);
        
    setState(() {
      data = json.decode(response.body);
      usersData = data;
    });
  }
   
  

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LISTA DE PAGOS',style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.indigo[900],

      ),
      body:ListView.builder(
        itemCount: usersData == null ? 0 : usersData.length+1,
        itemBuilder: (BuildContext context, int index){

          concepto = usersData[index]['concepto'];
          conceptoSgte = usersData[index+1]['concepto'];
          print(concepto);
          print(conceptoSgte);
          
          if(concepto == conceptoSgte){
            subTotal= subTotal + usersData[index]['importe'];
            total = total + subTotal;
            return card(usersData[index]['concepto'], usersData[index]['idRec'], usersData[index]['fecha'], usersData[index]['moneda2'], usersData[index]['importe'], usersData[index]['validado']);
          }else{
            if(concepto != null){
              subTotal= subTotal + usersData[index]['importe'];
              total = total + subTotal;
              aux = subTotal;
              subTotal = 0;
              print(total);
              return Container(
                child: Column(
                    children: <Widget>[
                      card(usersData[index]['concepto'], usersData[index]['idRec'], usersData[index]['fecha'], usersData[index]['moneda2'], usersData[index]['importe'], usersData[index]['validado']),
                      monto('SUB TOTAL', usersData[index]['concepto'], aux)
                    ]
                )
              );
              
            }else{
              print('///');
              print(total);
              return Container(
                child: Column(
                    children: <Widget>[
                      card(usersData[index]['concepto'], usersData[index]['idRec'], usersData[index]['fecha'], usersData[index]['moneda2'], usersData[index]['importe'], usersData[index]['validado']),
                      monto('TOTAL ', '', total)
                    ]
                )
              );
            }
          } 
        }
      )
    );
  }
  Widget monto(tipo,concepto, monto){
    return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        "$tipo",
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500)
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "$concepto",
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500)
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "$monto",
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500)
                      )
                    )
                  ]
                )
              )
            );

  }
  Widget card(concepto,idRec,fecha,moneda2,importe,validado){
    return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        "$concepto",
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500)
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "$idRec",
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500)
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "$fecha",
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500)
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "$moneda2",
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500)
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "$importe",
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500)
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "$validado",
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500)
                      )
                    )
                  ]
                )
              )
            );


  }
}