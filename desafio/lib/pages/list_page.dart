import 'package:desafio/bloc/search_bloc.dart';
import 'package:desafio/controllers/list_controller.dart';
import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ListController list = ListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF02005B),
        ),
        title: Column(
          children: [
            Row(
              children: const [
                Text(
                  'Pokémon',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Color(0xFF02005B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ListLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.pokemon.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/details',
                              arguments: state.pokemon.elementAt(index),
                            );
                          },
                          child: ListTile(
                            leading: Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 2, color: const Color(0xFFFD1A55)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    state.pokemon
                                        .elementAt(index)
                                        .pokemon
                                        .sprites!
                                        .frontDefault!,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              state.all.results!
                                  .elementAt(index)
                                  .name!
                                  .capitalize!,
                              style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xFFFD1A55),
                              ),
                            ),
                            subtitle: Text(
                              list.tipo(state.pokemon
                                  .elementAt(index)
                                  .pokemon
                                  .types!),
                              style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFF4F4F4F),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: Color(0xFFFD1A55),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (state.all.previous == null) {
                                } else {
                                  BlocProvider.of<SearchBloc>(context)
                                      .geral
                                      .clear();
                                  BlocProvider.of<SearchBloc>(context).url =
                                      state.all.previous!;
                                  BlocProvider.of<SearchBloc>(context)
                                      .add(ListFetchList());
                                }
                              },
                              icon: const Icon(Icons.chevron_left),
                              color: state.all.previous == null
                                  ? const Color(0xFFBDBDBD)
                                  : const Color(0xFF02005B)),
                          Text(
                            'Anterior',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: state.all.previous == null
                                  ? const Color(0xFFBDBDBD)
                                  : const Color(0xFF02005B),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (state.all.next == null) {
                                } else {
                                  BlocProvider.of<SearchBloc>(context)
                                      .geral
                                      .clear();
                                  BlocProvider.of<SearchBloc>(context).url =
                                      state.all.next!;
                                  BlocProvider.of<SearchBloc>(context)
                                      .add(ListFetchList());
                                }
                              },
                              icon: const Icon(Icons.chevron_right),
                              color: state.all.next == null
                                  ? const Color(0xFFBDBDBD)
                                  : const Color(0xFF02005B)),
                          Text(
                            'Próxima',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: state.all.next == null
                                  ? const Color(0xFFBDBDBD)
                                  : const Color(0xFF02005B),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          } else if (state is SearchLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF02005B),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Lista não carregada!',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF02005B),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
