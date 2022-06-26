part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final PokemonModel pokemon;
  final SpeciesModel species;
  final EvolutionsModel evolutions;

  const SearchLoadedState({required this.pokemon, required this.species, required this.evolutions});
}

class SearchEmptyState extends SearchState{}

class SearchErrorState extends SearchState{
  final String message;

  const SearchErrorState({required this.message});
}