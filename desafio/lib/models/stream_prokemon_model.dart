import 'package:desafio/models/evolutions.dart';
import 'package:desafio/models/pokemon.dart';
import 'package:desafio/models/species.dart';

class StreamPokemonModel {
  final PokemonModel pokemon;
  final SpeciesModel species;
  final EvolutionsModel evolutions;

  StreamPokemonModel({
    required this.pokemon,
    required this.species,
    required this.evolutions,
  });
}
