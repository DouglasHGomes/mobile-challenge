import 'package:desafio/bloc/search_bloc.dart';
import 'package:desafio/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  bool _enabled = false;
  String _pokemonName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFD1A55),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
              ),
              Image.asset(
                'assets/images/logo.png'
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.046875,
                width: MediaQuery.of(context).size.width * 0.867,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE6245C),
                            border: Border.all(
                              width: 2, color: const Color(0xFF052595)
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 14,
                          width: 14,                        
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFF1EE71),
                            border: Border.all(
                              width: 2, color: const Color(0xFF052595)
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF7AFC90),
                            border: Border.all(
                              width: 2, color: const Color(0xFF052595)
                            ),
                          ),
                        ),
                      ]
                    ),
                  ]
                )
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.682,
                    width: MediaQuery.of(context).size.width * 0.867,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.071875,
                    left: MediaQuery.of(context).size.height * 0.025,
                    child: const Text(
                      'Conheça a Pokédex',
                      style: TextStyle(
                        color: Color(0xFF02005B),
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1375,
                    left: MediaQuery.of(context).size.height * 0.025,
                    right: MediaQuery.of(context).size.height * 0.025,
                    child: const Text(
                      'Utilize a pokedéx para encontrar mais informações sobre os seus pokemons.',
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(0xFF02005B),
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.278125,
                    left: MediaQuery.of(context).size.height * 0.025,
                    right: MediaQuery.of(context).size.height * 0.025,
                    height: 41,
                    child: TextField(
                      onChanged:(value) {
                        _pokemonName = value;
                        if(value.isEmpty){
                          setState(() {_enabled = false;});
                        }else{
                          setState(() {_enabled = true;});
                        }
                      },
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          ),
                        hintStyle: TextStyle(
                          color: Color(0xFFBDBDBD),
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        hintText: 'Digite o nome do pokémon...',
                        border: OutlineInputBorder(                        
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.080091,                    
                    child: SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.867) * 0.897435,
                      child: FloatingActionButton.extended(
                        backgroundColor: _enabled? const Color(0xFF02005B) : const Color(0xFFBDBDBD),
                        onPressed: ()
                          {
                            if(_enabled){                              
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(value: BlocProvider.of<SearchBloc>(context)..add(SearchFetchList(_pokemonName)), child: SearchPage(pokemonName: _pokemonName,))));
                            }
                          },
                        label: 
                          const Text('PESQUISAR')
                        ),
                    )
                  )
                ],
              )
            ]
          )
        ),
      )
    );
  }
}
