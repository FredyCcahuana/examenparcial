import 'package:examenparcial/pages/deatilPay_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> usuario;

  const HomePage({Key key, this.usuario}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;
  List usersData;
  Color primary = Colors.indigo[900];
  final secondary = Color(0xfff29a94);
  getUsers() async {
    http.Response response = await http.get(
        'https://sigapdev2-consultarecibos-back.herokuapp.com/alumnoprograma/buscard/'+widget.usuario['dniM']);
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
        title: Text('Programas Cursados'),
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView.builder(
        itemCount: usersData == null ? 0 : usersData.length,
        itemBuilder: (BuildContext context, int index) {
          return buildList(context, index);
        },
      ),
    );
  }
  
  Widget buildList(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: Colors.indigo[900]),
              
            ),
            child: Image.asset('assets/diploma.png'),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${usersData[index]['nom_programa']}",
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.vpn_key,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("${usersData[index]['codAlumno']}",
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.school,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("${usersData[index]['siglaProg']}",
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.today,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("${usersData[index]['anioIngreso']}",
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                )
              ],
            ),
          ),
          Center(
            
            child:RawMaterialButton(
            
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPayPage(codigoAlumno: usersData[index]['codAlumno'])),
              );
            },
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              Icons.remove_red_eye,
              size: 20.0,
              color: primary,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          )
          )
        ],
      ),
    );
  }
}
