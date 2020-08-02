import 'package:examenparcial/pages/deatilPay_page.dart';
import 'package:examenparcial/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:load_toast/load_toast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

const mainColor = Color(0xff2470c7);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color mainColor = Colors.indigo[900];
  String email, password;
  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            'POSGRADO',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: mainColor,
            ),
            labelText: 'Usuario'),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Contraseña',
        ),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            createAlertRecuperarContrasenia(context);
          },
          child: Text(
            "Olvide mi contraseña",
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChangePasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            showAlertDialog(context);
          },
          child: Text(
            "Cambiar mi contraseña",
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.all(2.0),
          child: RaisedButton(
            elevation: 5.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            onPressed: () async {
              var url =
                  "https://sigapdev2-consultarecibos-back.herokuapp.com/usuario/alumnoprograma/buscar/" +
                      password +
                      "/" +
                      email;
              url = url.trim();
              debugPrint(url);

              var response = await http.get(url);
              if (response.statusCode == 200) {
                debugPrint("Existe");
                //var state = Provider.of<LoginState>(context);

                //state.username = email;
                //state.password = password;
                //state.setLoggedIn(true);
                //state.perfil = json.decode(response.body);
                print(response.body);
                Map<String, dynamic> usuario = json.decode(response.body);
                print(usuario['userName']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(usuario: usuario)),
                );
              } else {
                showAlertDialog(context);
                debugPrint("NO EXISTE O ERROR EN REQUEST");
                //ocurrio un error o datos invalidos
              }
            },
            child: Text(
              "Ingresar",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            '- O -',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }


  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Iniciar Sesión",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  ],
                ),
                _buildEmailRow(),
                _buildPasswordRow(),
                _buildLoginButton(),
                _buildForgetPasswordButton(),
                _buildChangePasswordButton(),
                //SizedBox(height: 30),
                //_buildOrRow(),
                //_buildSocialBtnRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "aceptar",
        style: TextStyle(fontSize: 15.0),
      ),
      onPressed: () => Navigator.pop(context),
      color: Colors.redAccent,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("¿Error de Inicar Sesiòn?"),
      content: Text("Usuario o Contraseña Incorrecta"),
      actions: [
        okButton,
      ],
      elevation: 24.0,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogRecuperoContrasenia(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "Aceptar",
        style: TextStyle(fontSize: 15.0),
      ),
      onPressed: () => Navigator.pop(context),
      color: Colors.green,
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Restablecimiento de Contraseña"),
      content: Text("Su usuario y contraseña es su dni"),
      actions: [
        okButton,
      ],
      elevation: 24.0,
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogNoRecuperoContrasenia(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "Aceptar",
        style: TextStyle(fontSize: 15.0),
      ),
      onPressed: () => Navigator.pop(context),
      color: Colors.redAccent,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content:
          Text("No se pudo restablecer. Verifique que escribio bien los datos"),
      actions: [
        okButton,
      ],
      elevation: 24.0,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildContainer(),
                //_buildSignUpBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }

  createAlertRecuperarContrasenia(BuildContext context) {
    var recuperarUsuario, recuperarEmail;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Recuperar contraseña"),
            content: Stack(
              children: <Widget>[
                Form(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: "Ingrese Usuario"),
                      onChanged: (value) {
                        setState(() {
                          recuperarUsuario = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Ingrese Email"),
                      onChanged: (value) {
                        setState(() {
                          recuperarEmail = value;
                        });
                      },
                    ),
                  ],
                ))
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 0.5,
                child: Text('Recuperar'),
                onPressed: () async {
                  //Relizar recuperacion
                  var url =
                      "https://sigapdev2-consultarecibos-back.herokuapp.com/usuario/alumnoprograma/cambiar/" +
                          recuperarEmail +
                          "/" +
                          recuperarUsuario;
                  url = url.trim();
                  debugPrint("recuperar link: " + url);
                  var response = await http.get(url);
                  if (response.statusCode == 200) {
                    debugPrint("recupero ok");
                    Navigator.of(context).pop();

                    showAlertDialogRecuperoContrasenia(context);
                  } else {
                    debugPrint("error al recupera");
                    showAlertDialogNoRecuperoContrasenia(context);
                  }
                },
              )
            ],
          );
        });
  }
}

