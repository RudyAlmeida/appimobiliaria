import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class ApAlone extends StatefulWidget {
  @override
  _ApAloneState createState() => _ApAloneState();
  final list;
  ApAlone({this.list});

}

class _ApAloneState extends State<ApAlone> with AutomaticKeepAliveClientMixin{
  dynamic aloneView;
  Completer<GoogleMapController> _controller = Completer();
  void _getLocation() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  List<Marker> allMarkers = [];

  @override
  bool get wantKeepAlive => true;
  void initState() {
    super.initState();
    aloneView = (widget.list);
    print(aloneView);
    _getLocation();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(aloneView["latitude"], aloneView["longitude"])));
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
            title: Text('Whatsapp', style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold),),
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          var _curIndex;
          _curIndex = index;
          switch (_curIndex) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              FlutterOpenWhatsapp.sendSingleMessage(
                  "5527995131439", "Teste de Contato");
          }
        },
      ),
      body:

      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(height: 400.0),
              items: [aloneView["foto"],aloneView["foto2"],aloneView["foto3"]].map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.amber
                        ),
                        child: Image.network('$item', fit: BoxFit.cover, width: 1000)
                    );
                  },
                );
              }).toList(),
            ),
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(aloneView["edificio"],
                  style: TextStyle(color: Colors.amber[600], fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.amber[600], width: 3,
                  )),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Quartos: "),
                      VerticalDivider(color: Colors.amber[600], thickness: 3,),
                      Expanded(
                        child: Text(aloneView["quartos"],
                          ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Text("Vagas: "),
                      VerticalDivider(color: Colors.amber[600], thickness: 3,),
                      Expanded(
                        child: Text(aloneView["vagas"],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Text("Banheiros: "),
                      VerticalDivider(color: Colors.amber[600], thickness: 3,),
                      Expanded(
                        child: Text(aloneView["banheiros"],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Text("Tamanho: "),
                      VerticalDivider(color: Colors.amber[600], thickness: 3,),
                      Expanded(
                        child: Text(aloneView["tamanho"]+ " m²",
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Text("Preço: R\$"),
                      VerticalDivider(color: Colors.amber[600], thickness: 3,),
                      Expanded(
                        child: Text(aloneView["preco"],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Text("Informações:"),
                      VerticalDivider(color: Colors.amber[600], thickness: 3,),
                      Expanded(
                        child: Text(aloneView["descricao"],
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                    color: Colors.amber[600], width: 3,
                  )),
              height: 200.0,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey),
                    child: Text(
                        "Endereço: " + aloneView["endereco"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(aloneView["latitude"], aloneView["longitude"]),
                        zoom: 14.4746,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: Set.from(allMarkers),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}