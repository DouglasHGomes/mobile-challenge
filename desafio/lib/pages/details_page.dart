import 'package:desafio/models/geral.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:desafio/controllers/details_controller.dart';
import 'package:desafio/controllers/favorites_controller.dart';
import 'package:desafio/controllers/graphs_controller.dart';
import 'dart:math';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.geralModel}) : super(key: key);
  final GeralModel geralModel;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DetailsController details = DetailsController();
  GraphsController graphs = GraphsController();
  bool isFavorited = false;
  bool graphEnable = true;

  @override
  void initState() {
    super.initState();
    details.allEvolutions(widget.geralModel.evolutions.chain!);

    verifyFavorite();
  }

  Future<void> verifyFavorite() async {
    isFavorited = await FavoritesController.instance
        .readPokemon(widget.geralModel.pokemon.id!);
    setState(() {});
  }

  void changeGraph() {
    setState(() {
      graphEnable = !graphEnable;
    });
  }

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
                    Navigator.pushNamed(context, '/history');
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
                        widget.geralModel.pokemon.sprites!.frontDefault!,
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
                      widget.geralModel.pokemon.name.capitalize!,
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    Text(
                      details.tipo(widget.geralModel.pokemon.types!),
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
              Positioned(
                right: 16,
                bottom: 16,
                child: IconButton(
                    onPressed: () async {
                      if (isFavorited) {
                        await FavoritesController.instance
                            .delete(widget.geralModel.pokemon.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            elevation: 0,
                            content: const Text(
                              'Pokémon desfavoritado!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.black.withOpacity(0.6),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      } else {
                        await FavoritesController.instance
                            .create(widget.geralModel.pokemon);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            elevation: 0,
                            content: const Text(
                              'Pokémon favoritado!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.black.withOpacity(0.6),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                      isFavorited = !isFavorited;
                      setState(() {});
                    },
                    icon: Icon(
                      isFavorited == true ? Icons.star : Icons.star_border,
                      size: 35,
                      color: const Color(0xFFFFFFFF),
                    )),
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
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    (widget.geralModel.pokemon.weight! / 10).toString() + ' kg',
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFFFD1A55),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                  const SizedBox(
                    height: 5,
                  ),
                  for (int i = 0; i < details.evolucoes!.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
                      child: Text(
                        details.evolucoes![i].capitalize! +
                            " (" +
                            details.tipoEvo(widget.geralModel.pokemon.types!) +
                            ")",
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFFFD1A55),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
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
                  AnimatedCrossFade(
                    crossFadeState: graphEnable
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(seconds: 1),
                    firstChild: GestureDetector(
                      onTap: changeGraph,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                details
                                    .stats(widget.geralModel.pokemon.stats!)[0]
                                    .toString(),
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
                                  fontSize: 14,
                                  color: Color(0xFFFD1A55),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                details
                                    .stats(widget.geralModel.pokemon.stats!)[1]
                                    .toString(),
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
                                details
                                    .stats(widget.geralModel.pokemon.stats!)[2]
                                    .toString(),
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
                                details
                                    .stats(widget.geralModel.pokemon.stats!)[3]
                                    .toString(),
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
                    ),
                    secondChild: GestureDetector(
                      onTap: changeGraph,
                      child: SizedBox(
                        height: 100,
                        child: BarChart(BarChartData(
                          barTouchData: graphs.barTouchData,
                          titlesData: graphs.titlesData,
                          borderData: graphs.borderData,
                          barGroups: graphs.barGroups(
                              details.stats(widget.geralModel.pokemon.stats!)),
                          gridData: FlGridData(show: false),
                          alignment: BarChartAlignment.spaceAround,
                          maxY: details
                              .stats(widget.geralModel.pokemon.stats!)
                              .reduce(max),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.geralModel.pokemon.moves!.length,
                      itemBuilder: (BuildContext context, int itemCount) {
                        return Padding(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            '•  ' +
                                details.moves(widget.geralModel.pokemon.moves!)[
                                    itemCount],
                            style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFFFD1A55),
                            ),
                          ),
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
