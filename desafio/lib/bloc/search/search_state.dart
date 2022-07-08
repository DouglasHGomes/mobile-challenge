part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<StreamPokemonModel> pokemons;

  const SearchLoadedState({required this.pokemons});
}

class SearchEmptyState extends SearchState {}

class SearchErrorState extends SearchState {
  final String message;

  const SearchErrorState({required this.message});
}
