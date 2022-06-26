class SpeciesModel {
  EvolutionChain? evolutionChain;
  String? evolvesFromSpecies;
  int? id;

  SpeciesModel(
      {
      this.evolutionChain,
      this.evolvesFromSpecies,
      this.id,});

  SpeciesModel.fromJson(Map<String, dynamic> json) {

    evolutionChain = json['evolution_chain'] != null
        ? new EvolutionChain.fromJson(json['evolution_chain'])
        : null;
    evolvesFromSpecies = json['evolves_from_species'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolutionChain != null) {
      data['evolution_chain'] = this.evolutionChain!.toJson();
    }
    data['evolves_from_species'] = this.evolvesFromSpecies;
    
    data['id'] = this.id;
    return data;
  }
}

class EvolutionChain {
  String? url;

  EvolutionChain({this.url});

  EvolutionChain.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}