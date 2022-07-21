part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchFetchList extends SearchEvent {
  final dio = Dio();

  Future<PokemonModel> getPokemon(String name) async {
    try {
      Response response =
          await dio.get("https://pokeapi.co/api/v2/pokemon/" + name);
      return PokemonModel.fromJson(response.data);
    } catch (e) {
      throw (const SearchErrorState(
          message: 'Não foi possível carregar os dados do Pokémon!'));
    }
  }

  Future<List<String>> searchAllPokemon(String name) async {
    try {
      Response response = await dio
          .get('https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1154');

      ListModel all = ListModel.fromJson(response.data);
      List<String> result = [];

      for (int i = 0; i < all.results!.length; i++) {
        if (all.results!.elementAt(i).name!.contains(name)) {
          result.add(all.results!.elementAt(i).name!);
        }
      }
      return result;
    } catch (e) {
      throw (const SearchErrorState(message: 'Pokémon não encontrado!'));
    }
  }

  Future<SpeciesModel> getSpecies(String url) async {
    try {
      Response response = await dio.get(url);
      return SpeciesModel.fromJson(response.data);
    } catch (e) {
      throw (const SearchErrorState(message: 'Pokémon não encontrado!'));
    }
  }

  Future<EvolutionsModel> getEvolutions(String url) async {
    try {
      Response response = await dio.get(url);
      return EvolutionsModel.fromJson(response.data);
    } catch (e) {
      throw (const SearchErrorState(
          message: 'Não foi possível carregar os dados de evoluções!'));
    }
  }
}

class ListFetchList extends SearchEvent {
  final dio = Dio();

  Future<ListModel> getList(String url) async {
    try {
      Response response = await dio.get(url);

      return ListModel.fromJson(response.data);
    } catch (e) {
      throw (const SearchErrorState(
          message: 'Não foi possível carregar a lista de Pokémon!'));
    }
  }

  Future<PokemonModel> getPokemon(String name) async {
    try {
      Response response =
          await dio.get("https://pokeapi.co/api/v2/pokemon/" + name);
      return PokemonModel.fromJson(response.data);
    } catch (e) {
      throw (const SearchErrorState(
          message: 'Não foi possível carregar os dados do Pokémon!'));
    }
  }

  Future<SpeciesModel> getSpecies(int id) async {
    try {
      Response response = await dio
          .get("https://pokeapi.co/api/v2/pokemon-species/" + id.toString());
      return SpeciesModel.fromJson(response.data);
    } catch (e) {
      throw (const SearchErrorState(
          message: 'Não foi possível carregar os dados das espécies!'));
    }
  }

  Future<EvolutionsModel> getEvolutions(String url) async {
    try {
      Response response = await dio.get(url);
      return EvolutionsModel.fromJson(response.data);
    } catch (e) {
      throw (const SearchErrorState(
          message: 'Não foi possível carregar os dados de evoluções!'));
    }
  }
}
