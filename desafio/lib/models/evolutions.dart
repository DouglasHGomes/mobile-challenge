class EvolutionsModel {
  Chain? chain;

  EvolutionsModel({this.chain});

  EvolutionsModel.fromJson(Map<String, dynamic> json) {
    chain = json['chain'] != null ? new Chain.fromJson(json['chain']) : null;
  }
}

class Chain {
  Species? species;
  List<EvolvesTo>? evolvesTo;

  Chain({this.species, this.evolvesTo});

  Chain.fromJson(Map<String, dynamic> json) {
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
    if (json['evolves_to'] != null) {
      evolvesTo = <EvolvesTo>[];
      json['evolves_to'].forEach((v) {
        evolvesTo!.add(new EvolvesTo.fromJson(v));
      });
    }
  }
}

class Species {
  String? name;
  String? url;

  Species({this.name, this.url});

  Species.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

class EvolvesTo {
  Species? species;
  List<EvolvesTo>? evolvesTo;

  EvolvesTo({this.species, this.evolvesTo});

  EvolvesTo.fromJson(Map<String, dynamic> json) {
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
    if (json['evolves_to'] != null) {
      evolvesTo = <EvolvesTo>[];
      json['evolves_to'].forEach((v) {
        evolvesTo!.add(new EvolvesTo.fromJson(v));
      });
    }
  }
}
