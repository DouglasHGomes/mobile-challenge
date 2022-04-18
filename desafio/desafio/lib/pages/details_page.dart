import 'package:desafio/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.pokemonModel}) : super(key: key);
  final PokemonModel pokemonModel;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(182),
        child: Container(
            height: 182,
            width: double.infinity,
            color: const Color(0xFFFD1A55),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 35,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                      size: 40,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  top: 90,
                  child: Container(
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                        Border.all(width: 4, color: const Color(0xFFFFFFFF)),
                       image: DecorationImage(
                        scale: 1,
                        image: NetworkImage(
                          widget.pokemonModel.sprites!.frontDefault!,
                         ),
                        ),
                      ),
                    ),
                ),
                Positioned(
                  left: 108,
                  top: 93,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.pokemonModel.name.capitalize!,
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      Text(
                        tipo(widget.pokemonModel.types!),
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Color(0xFFFFFFFF),
                        ),
                      )
                    ],
                  ),
                ),
                const Positioned(
                  right: 16,
                  bottom: 16,
                  child: Icon(
                    Icons.star_border,
                    size: 35,
                    color: Color(0xFFFFFFFF),
                  ),
                )
              ],
            ),
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Características',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF02005B),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  const Text(
                    'Peso',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF02005B),
                    ),
                  ),
                  Text(
                    widget.pokemonModel.weight.toString() + ' kg',
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFFFD1A55),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'Evoluções',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF02005B),
                    ),
                  ),
                  // ************************ INSERIR EVOLUÇÕES AQUI
                  const SizedBox(
                    height: 107,
                  ),
                  const Text(
                    'Status base',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF02005B),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            status(widget.pokemonModel.stats!)[0].toString(),
                            style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFFFD1A55),
                            ),
                          ),
                          const Text(
                            'HP',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFFFD1A55),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            status(widget.pokemonModel.stats!)[1].toString(),
                            style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFFFD1A55),
                            ),
                          ),
                          const Text(
                            'Attack',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFFFD1A55),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            status(widget.pokemonModel.stats!)[2].toString(),
                            style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFFFD1A55),
                            ),
                          ),
                          const Text(
                            'Defense',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFFFD1A55),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            status(widget.pokemonModel.stats!)[5].toString(),
                            style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFFFD1A55),
                            ),
                          ),
                          const Text(
                            'Speed',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFFFD1A55),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'Habilidades',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF02005B),
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.pokemonModel.moves!.length,
                    itemBuilder: (BuildContext context, int itemCount){
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          '• ' + moves(widget.pokemonModel.moves!)[itemCount],
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xFFFD1A55),
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String tipo (List<Types> t){

    List<String> tipos = [];
    String resultado = '';

    for (int i=0; i<t.length; i++){

      tipos.add(t[i].type!.name!.capitalize!);
    }
    resultado = tipos.join(", ");

    if(t.length == 1){
      return 'Tipo: ' + resultado;
    }else{
      return 'Tipos: ' + resultado;
    }
  }

  List<int> status (List<Stats> s){

    List<int> status = [];

    for (int i=0; i<s.length; i++){

      status.add(s[i].baseStat!);
    }
    return status;
  }

  List<String> moves (List<Moves> m){

    List<String> moves = [];

    for (int i=0; i<m.length; i++){

      moves.add(m[i].move!.name!.capitalize!);
    }
    print(moves.length);
    return moves;
  }
}
