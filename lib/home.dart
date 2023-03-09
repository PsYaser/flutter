import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Drawer getDrawer(BuildContext context) //devolvemos el drawer
  {
    var header = DrawerHeader(child: Text("Ajustes"));
    var info = AboutListTile(
      child: Text("Informacion APP"),
      applicationIcon: Icon(Icons.favorite),
      applicationVersion: "v1.0.0",
      icon: Icon(Icons.info),
    );
    ListTile getItem(
        Icon icon, String description, String route) //Creamos una lista
    {
      return ListTile(
        leading: icon,
        title: Text(description),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      );
    }

    ListView getList() {
      //Drawer contenedor
      return ListView(
        children: <Widget>[
          header,
          getItem(Icon(Icons.shopping_cart), "Productos", "/infinita"),
          info
        ],
      );
    }

    return Drawer(child: getList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página Principal"),
      ),
      //drawer: Drawer(
      // child: getList(),
      // ),
      drawer: getDrawer(context),
    );
  }
}
