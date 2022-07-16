import 'package:flutter/material.dart';
import 'package:marvelapi/controller/heroi_controller.dart';

class HomeListHerois extends StatelessWidget {
  HomeListHerois({required this.controller});

  late HeroiController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado Busca Heróis'),
        leading: IconButton(
            onPressed: () {
              _voltarMenu(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: GridView.builder(
        itemCount: controller.listaHerois.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          var heroiDaVez = controller.listaHerois[index];
          return _constroiHeroiVez(heroiDaVez, index, context);
        },
      ),
    );
  }

  Container _constroiHeroiVez(heroiDaVez, index, context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.all(5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            '${heroiDaVez.thumbnail.path}.${heroiDaVez.thumbnail.extension}',
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(321))),
              child: Text(
                textAlign: TextAlign.center,
                controller.listaHerois[index].name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _voltarMenu(context) {
    controller.zerarLista();
    Navigator.pop(context);
  }
}
