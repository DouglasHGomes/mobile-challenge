import 'package:bloc/bloc.dart';
import 'package:desafio/models/pokemon.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  late PokemonModel data;
  final dio = Dio();
  //final HomePageRepo homePageRepo;

  SearchBloc(SearchState initialState) : super(SearchLoadingState()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchFetchList) {
        emit(SearchLoadingState());
        try {
          Response response = await dio.get("https://pokeapi.co/api/v2/pokemon/" + event.pokemonName);
          data = PokemonModel.fromJson(response.data);
          emit(SearchLoadedState(pokemon: data));
        } on DioError catch (e) {
          emit(const SearchErrorState(message: 'Não foi possível carregar os dados'));
        }
      }
    });
  }
}
