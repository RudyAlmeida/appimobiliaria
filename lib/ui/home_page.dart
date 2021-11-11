import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imobiliaria_gigante/ui/apartamentos_view.dart';
import 'package:imobiliaria_gigante/ui/casas_view.dart';
import 'package:imobiliaria_gigante/ui/terrenos_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: Image(image: AssetImage('images/logo.jpg'),),
          title: Text('Imóveis Gigante',
            style: TextStyle(color: Colors.amber[600], fontWeight: FontWeight.bold),
          ),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.amber[600], width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0, // soften the shadow
                      spreadRadius: 8.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.account_balance, color: Colors.amber[600],size: 90),
                    Divider(color: Colors.amber[600], thickness: 3,),
                    SizedBox(height: 08,),
                    Text('Apartamentos', style: TextStyle(color: Colors.amber[600], fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ApView()));
              },
            ),
            GestureDetector(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.amber[600], width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0, // soften the shadow
                      spreadRadius: 8.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.home, color: Colors.amber[600],size: 90),
                    Divider(color: Colors.amber[600], thickness: 3,),
                    SizedBox(height: 08,),
                    Text('Casas', style: TextStyle(color: Colors.amber[600], fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CasasView()));
              },
            ),
            GestureDetector(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.amber[600], width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0, // soften the shadow
                      spreadRadius: 8.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.landscape, color: Colors.amber[600],size: 90),
                    Divider(color: Colors.amber[600], thickness: 3,),
                    SizedBox(height: 08,),
                    Text('Terrenos', style: TextStyle(color: Colors.amber[600], fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TerrenosView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
