part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchFetchList extends SearchEvent{
  
  final dio = Dio();
  final String pokemonName;

  SearchFetchList(this.pokemonName);

  Future<PokemonModel> getPokemon(String name) async {
    try {
      Response response =
        await dio.get("https://pokeapi.co/api/v2/pokemon/" + name);
      return PokemonModel.fromJson(response.data);
    } on DioError catch (e) {
      throw (e.message);
    }
  }

}
