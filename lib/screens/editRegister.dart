import 'package:flutter/material.dart';
import '../connections/startConnection.dart';
import '../Entities/SonDetailsClass.dart';

// ignore: must_be_immutable
class EditRegisterScreen extends StatefulWidget {
  SonDetails argsEdit;
  EditRegisterScreen(this.argsEdit);

  @override
  EditRegister createState() => EditRegister();
}

class EditRegister extends State<EditRegisterScreen> {
  int id = 0;
  String labelDate = "Seleccione la fecha de nacimiento";
  String name = "";
  String bornYear = "";
  String currentAge = "";
  DateTime initialDate = DateTime.now();
  final myTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  currentAgeFunction (DateTime onValue) {
    var edad = DateTime.now().year - onValue.year; // 21
    var mes = DateTime.now().month - onValue.month; // 0
    if (mes < 0 || (mes == 0 && DateTime.now().day < onValue.day)) {
      edad--;
    }
    currentAge =  edad.toString();
    //Año de Nacimiento

    String day = onValue.day.toString().length==2 ? onValue.day.toString() : "0" + onValue.day.toString();
    String month = onValue.month.toString().length == 2 ? onValue.month.toString() : "0" + onValue.month.toString();

    bornYear = day  +
        "/" + month +
        "/" +
        onValue.year.toString();

  }

  changeDateOrder(bornYearArgs){
    String datetime="";
    List<int> list= bornYearArgs.codeUnits.reversed.toList();
    List<int>partOfDate= new List<int>();
    int cont = 0;
    for (int i in list){
      if(i!=47){
        partOfDate.add(i);
        if(cont==list.length-1){
          datetime = datetime + String.fromCharCodes(partOfDate.reversed.toList());
        }
      }
      else {
        List<int> partOfDateAux = partOfDate.reversed.toList();
        datetime = datetime + String.fromCharCodes(partOfDateAux);
        partOfDate = new List<int>();
        if (cont != list.length - 1) {
          datetime = datetime + "-";
        }
      }
      cont ++;
    }
    return datetime + " 00:00:00.000";
  }

  @override
  Widget build(BuildContext context) {

    if (widget.argsEdit != null) {
      this.id = widget.argsEdit.id;
      // Colocar nombre en Input
      myTextController.text = widget.argsEdit.name;

      DateTime dateTime = DateTime.parse(changeDateOrder(widget.argsEdit.bornYear));

      // Colocar fecha de nacimiento en Input
      initialDate = dateTime;
      labelDate =  "Fecha de nacimiento : (${widget.argsEdit.bornYear})";
      currentAgeFunction(dateTime);
      widget.argsEdit = null;
    }

    AppBar appBar = new AppBar(
      title: const Text('Editar registro'),
      backgroundColor: Colors.blueAccent[400],
    );

    TextFormField nombreInput = new TextFormField(
      decoration: InputDecoration(
          icon: Icon(Icons.account_circle), hintText: 'Escriba el nombre aquí'),
      controller: myTextController,
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty) {
          return "Campo nombre obligatorio";
        }
        if ((value.contains(new RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')))) {
          return "Solo se admiten letras";
        }
      },
    );



    FlatButton flatButton = new FlatButton(
        child: new Text(
          labelDate,
          style: TextStyle(color: Colors.blueAccent[400]),
        ),
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(DateTime.now().year - 60),
            lastDate: DateTime.now(),
          ).then((onValue) {
            if (onValue != null) {
              currentAgeFunction(onValue);

              //Actualizar
              setState(() {
                labelDate = "Fecha de nacimiento : ($bornYear)";
                initialDate = onValue;
              });
            }
          });
        });

    Row fechaRow = new Row(
      children: <Widget>[
        Icon(
          Icons.date_range,
          color: Colors.black45,
        ),
        flatButton
      ],
    );

    _buttonSave(BuildContext context) {
      RaisedButton raisedButton = new RaisedButton(
          child: Text(
            "Actualizar",
            style: TextStyle(color: Colors.blueAccent[400]),
          ),
          color: Colors.white,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              bool resultInsert = false;
              try {
                SonDetails sonDetails = new SonDetails.parameters(
                    myTextController.text,
                    bornYear,
                    currentAge,
                    (int.parse(currentAge) + 1).toString());
                sonDetails.id = this.id;
                db.update(sonDetails);
                resultInsert = true;
              } catch (e) {
                resultInsert = false;
              }
              Text insertText =
                  new Text(resultInsert ? "Editado" : "Error al editar");
              Icon insertIcon =
                  new Icon(resultInsert ? Icons.thumb_up : Icons.thumb_down);
              SnackBar snackbar = new SnackBar(
                  content: Row(children: [
                insertIcon,
                SizedBox(
                  width: 20,
                ),
                insertText
              ]));
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(snackbar);
            }
          });
      return raisedButton;
    }

    _container(BuildContext context) {
      return (new Container(
          //width: MediaQuery.of(context).size.width / 2,
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    nombreInput,
                    fechaRow,
                    Center(child: _buttonSave(context))
                  ],
                ),
              ))));
    }

    Scaffold scaffold = new Scaffold(
      appBar: appBar,
      body: Builder(
        builder: (BuildContext context) {
          return _container(context);
        },
      ),
    );

    return scaffold;
  }
}
