import 'package:flutter/material.dart';
import 'package:marvelapi/controller/heroi_controller.dart';
import 'package:marvelapi/home/home_list_herois.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final heroiController = HeroiController();
  final _textPesquisaController = TextEditingController();

  @override
  void initState() {
    heroiController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MARVEL'),
      ),
      body: _constroiBody(),
    );
  }

  Center _constroiBody() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            fit: BoxFit.contain,
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3pN7VUVX74D4gFY6N4UA9ATfWbaSUqg9b5F61BkzrRoEEVgiFJVqSl5Mnm710qn1d7SM&usqp=CAU',
          ),
          const Text(
            'Pesquisar heróis',
            style: TextStyle(fontSize: 25),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 175, 179, 175),
                  blurRadius: 5,
                  offset: Offset(0.0, 0.1),
                ),
              ],
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: _textPesquisaController,
              decoration: const InputDecoration(
                hintText: 'Digite herói a ser pesquisado',
              ),
            ),
          ),
          _constroiBotao(),
        ],
      ),
    );
  }

  Widget _constroiBotao() {
    if (!heroiController.carregando) {
      return SizedBox(
        height: 40,
        width: 140,
        child: ElevatedButton(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.redAccent),
          ),
          onPressed: () {
            buscarHerois();
          },
          child: Text(_controiTituloBotao()),
        ),
      );
    }
    return _constroiCarregando();
  }

  String _controiTituloBotao() {
    if (heroiController.listaHerois.isEmpty) {
      return 'BUSCAR';
    } else if (heroiController.carregando) {
      return 'CARREGANDO';
    }
    return 'AVANÇAR';
  }

  SizedBox _constroiCarregando() {
    if (heroiController.carregando) {
      return const SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(),
      );
    }
    return const SizedBox();
  }

  void buscarHerois() {
    if (heroiController.listaHerois.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HomeListHerois(
                    controller: heroiController,
                  )));
    }
    if (_textPesquisaController.text.isEmpty) {
      heroiController.buscarHerois();
    } else {
      heroiController.buscarHeroisPesquisa(_textPesquisaController.text);
    }
  }
}
