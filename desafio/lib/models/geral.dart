import 'package:desafio/models/pokemon.dart';
import 'package:desafio/models/species.dart';

import 'evolutions.dart';

class GeralModel {
  final PokemonModel pokemon;
  final SpeciesModel species;
  final EvolutionsModel evolutions;

  GeralModel(
      {required this.pokemon, required this.species, required this.evolutions});
}
