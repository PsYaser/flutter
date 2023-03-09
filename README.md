# flutter
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'package:practica2/models/argumentos.dart';

class Infinita extends StatefulWidget {
  static const String routename = "/infinita";
  const Infinita({super.key});

  @override
  State<Infinita> createState() => _InfinitaState();
}

class _InfinitaState extends State<Infinita> {
  //suggestions:Sugerencias de tipo lista
  //Wordpair: Class de combinacion de 2 palabras(English words)
  //Para guardar los elementos hacemos click
  List<WordPair> saved = [];
  List<WordPair> suggestions = [];
  final precio = <WordPair, int>{};
  Widget suma(String numero, int sum) {
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
      if (!precio.containsKey(value)) {
        precio[value] = Random().nextInt(500);
      }
      sum += precio[value]!;
    }
    return sum;
  }

  ListTile builRow(WordPair pair, int i) {
    final bool alreadySaved = saved.contains(pair);
    if (!precio.containsKey(pair)) {
      precio[pair] = Random().nextInt(500);
    }
    return ListTile(
      trailing: Icon(
        alreadySaved
            ? Icons.shopping_cart
            : Icons.shopping_cart_checkout_rounded,
        color: Colors.redAccent,
      ),
      title: Text(pair.asCamelCase),
      subtitle: Text("indice:$i " + " Precio: " + precio[pair].toString()),
      onTap: () {
        if (alreadySaved) {
          saved.remove(pair);
        } else {
          saved.add(pair);
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void pushSaved() {
      //ir a una ruta especifica
      /*Navigator.push(context, MaterialPageRoute(builder: (context) {
        final title = saved
            .map(
              (pair) => ListTile(
                title: Text(pair.asPascalCase),
                trailing: Text("Precio: " + precio[pair].toString()),
              ),
            )
            .toList();
        return Scaffold(
          appBar: AppBar(
            title: Text("Guardados"),
          ),
          body: Column(children: [
            ...title,
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Divider(color: Colors.black),
            ),
            suma(title.length.toString(), sumaTotal(saved))
          ]),
        );
      }));*/
      Argumentos argumentos = Argumentos(saved, precio);
      Navigator.pushNamed(context, "/guardados", arguments: argumentos);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista Infinita"),
        actions: <Widget>[
          //Creacion de un icono para acceder a la otra pantalla
          IconButton(
            icon: Icon(Icons.list),
            onPressed: pushSaved,
          )
        ],
      ),
      body: ListView.builder(itemBuilder: (context, i) {
        //si es impar llamar al widget dividir
        if (i.isOdd) ;

        //si el indice es mayor igual a la cantidad de datos de la variable
        if (i >= suggestions.length) {
          //Funcion addAll: puede agregar mas de 1 elemento a una lista
          //Funcion generateWordPairs: tomamos 10 elementos del tipo WordPairs
          //Y agregamos a la coleccion de datos
          suggestions.addAll(generateWordPairs().take(10));
        }
        return builRow(suggestions[i], i);
      }),
    );
  }
}
