import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:practica2/models/argumentos.dart';

class Guardados extends StatefulWidget {
  const Guardados({super.key});
  static const String routename = "/guardados";

  @override
  State<Guardados> createState() => _GuardadosState();
}

class _GuardadosState extends State<Guardados> {
  List<WordPair> saved = [];
  Map<WordPair, int> precios = {};
  int sumaTotal = 0;
  Widget suma(int sum, String numero) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: TextStyle(fontSize: 16)),
                Text(sum.toString())
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Count",
                  style: TextStyle(fontSize: 16),
                ),
                Text(numero.toString())
              ],
            )
          ],
        ),
      ),
    );
  }

  int sumaTotall(List<WordPair> saved) {
    int sum = 0;
    for (var value in saved) {
      if (!precios.containsKey(value)) {
        precios[value] = Random().nextInt(500);
      }
      sum += precios[value]!;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Argumentos;
    saved = arguments.saved;
    precios = arguments.precios;
    int sumaTotal = sumaTotall(saved);

    return Scaffold(
      appBar: AppBar(
        title: Text("Guardados"),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              Positioned(
                top: 10,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
                  constraints:
                      const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: Text(
                    saved.length.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: saved.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://www.100natural.com/delivery100/web/vistas/img/cartempty.png",
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Tu carrito está vacío",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Agrega productos y da el primer paso para iniciar tu compra.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: saved.length,
                    itemBuilder: (context, index) {
                      WordPair palabra = saved[index];
                      return ListTile(
                        title: Text(palabra.asPascalCase),
                        trailing: Text("Precio: ${precios[palabra]}"),
                        onTap: () {
                          saved.remove(palabra);
                          setState(() {
                            sumaTotal = sumaTotall(saved);
                          });
                        },
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                suma(sumaTotal, saved.length.toString()),
              ],
            ),
    );
  }
}
