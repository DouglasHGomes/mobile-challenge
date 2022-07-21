class SpeciesModel {
  EvolutionChain? evolutionChain;
  int? id;

  SpeciesModel({
    this.evolutionChain,
    this.id,
  });

  SpeciesModel.fromJson(Map<String, dynamic> json) {
    evolutionChain = json['evolution_chain'] != null
        ? EvolutionChain.fromJson(json['evolution_chain'])
        : null;
    id = json['id'];
  }
}

class EvolutionChain {
  String? url;

  EvolutionChain({this.url});

  EvolutionChain.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }
}
