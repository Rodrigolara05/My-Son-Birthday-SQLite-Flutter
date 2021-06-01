import 'package:flutter/material.dart';
import '../connections/startConnection.dart';
import '../Entities/SonDetailsClass.dart';
import 'editRegister.dart';

class HomeScreen extends StatefulWidget {
  @override
  Home createState() => Home();

}

class Home extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    AppBar appBar = new AppBar(
      title: const Text('Mis contactos'),
      backgroundColor: Theme.of(context).primaryColor,
    );

    _createCard(SonDetails sonDetails) {
      return new Card(
          child: new Column(
        children: [
          ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(sonDetails.name),
              subtitle: Text("Fecha de nacimiento: " +
                  sonDetails.bornYear +
                  "\n" +
                  "Edad Actual: " +
                  sonDetails.currentAge)),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("Editar"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditRegisterScreen(sonDetails)));
                  //Navigator.of(context).pushNamed('/edit',arguments: sonDetails);
                },
              ),
              FlatButton(
                child: Text("Eliminar"),
                onPressed: () {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Alerta!"),
                          content:
                              Text("¿Seguro que desea eliminar este registro?"),
                          elevation: 24.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Cancelar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text("Aceptar"),
                              onPressed: () {
                                try {
                                  db.delete(sonDetails);
                                  setState(() {});
                                  Navigator.of(context).pop();
                                } catch (exception) {}
                              },
                            ),
                          ],
                        );
                      });
                },
              )
            ],
          )
        ],
        mainAxisSize: MainAxisSize.min,
      ));
    }

    _showListCards(BuildContext context) {
      return FutureBuilder(
        future: db.getAll(),
        builder:
            (BuildContext context, AsyncSnapshot<List<SonDetails>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return (Container(
                  child: new Center(
                      child: new ListView(
                children: <Widget>[
                  for (SonDetails obj in snapshot.data) _createCard(obj)
                ],
              ))));
            } else {
              return Center(child: Text("Agrega un dato"));
            }
          } else {
            return Center(
              child: Text("Agrega un dato"),
            );
          }
        },
      );
    }

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
          future: db.initDB(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return (_showListCards(context));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/register');
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
