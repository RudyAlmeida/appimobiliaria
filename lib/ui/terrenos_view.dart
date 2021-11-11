import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:imobiliaria_gigante/ui/terreno_alone.dart';

class TerrenosView extends StatefulWidget {
  @override
  _TerrenosViewState createState() => _TerrenosViewState();
}

class _TerrenosViewState extends State<TerrenosView> {
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("terrenos");
  List list =  List();

  @override
  void initState()  {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: Image(
          image: AssetImage('images/logo.jpg'),
        ),
        title: Text(
          'Imóveis Gigante',
          style:
          TextStyle(color: Colors.amber[600], fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            title: Text('Voltar'),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
            title: Text('Whatsapp', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
          ),
        ],
        /*currentIndex: _selectedIndex,*/
        selectedItemColor: Colors.amber[800],
        /*onTap: _onItemTapped,*/
        onTap: (index) {
          var _curIndex;
          _curIndex = index;
          switch (_curIndex) {
            case 0: Navigator.pop(context);
            break;
            case 1: FlutterOpenWhatsapp.sendSingleMessage("5527995131439", "Teste de Contato");

          }
        },
      ),
      body:
      FutureBuilder(
          future: dbRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              list.clear();
              Map<dynamic, dynamic> values = snapshot.data.value;
              if (snapshot.data.value != null) {
                values.forEach((key, values) {
                  list.add(values);
                });
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildGesture(index, context);
                    });
              }} else {
              Text('Sem Terrenos no momento');
            }
            return  Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(08.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: Text("Sem Terrenos no momento",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
  GestureDetector buildGesture(int index, BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => TerrenoAlone(
                  list: list[index],
                )));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.amber[600], width: 3,
            )),
//        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(08.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(list[index]["foto"]),
                      fit: BoxFit.cover),
                ),

//                            Image(image: NetworkImage(list[index]["foto"]),)
              ),
              SizedBox(width: 10.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 02.0,),
                    Text("Endereço: " + list[index]["endereco"],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 03.0,),
                    Row(
                      children: <Widget>[
                        Text("Preço: R\$ "+ list[index]["preco"],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.0),
                        ),
                        SizedBox(width: 05.0,),
                        Text("Tamanho: "+ list[index]["tamanho"]+" m²",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 05.0,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}