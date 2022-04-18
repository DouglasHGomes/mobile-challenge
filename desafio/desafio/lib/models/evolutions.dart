class EvolutionsModel {
  int? id;
  Null? babyTriggerItem;
  Chain? chain;

  EvolutionsModel({this.id, this.babyTriggerItem, this.chain});

  EvolutionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    babyTriggerItem = json['baby_trigger_item'];
    chain = json['chain'] != null ? new Chain.fromJson(json['chain']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['baby_trigger_item'] = this.babyTriggerItem;
    if (this.chain != null) {
      data['chain'] = this.chain!.toJson();
    }
    return data;
  }
}

class Chain {
  bool? isBaby;
  Species? species;
  Null? evolutionDetails;
  List<EvolvesTo>? evolvesTo;

  Chain({this.isBaby, this.species, this.evolutionDetails, this.evolvesTo});

  Chain.fromJson(Map<String, dynamic> json) {
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
    evolutionDetails = json['evolution_details'];
    if (json['evolves_to'] != null) {
      evolvesTo = <EvolvesTo>[];
      json['evolves_to'].forEach((v) {
        evolvesTo!.add(new EvolvesTo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species!.toJson();
    }
    data['evolution_details'] = this.evolutionDetails;
    if (this.evolvesTo != null) {
      data['evolves_to'] = this.evolvesTo!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class EvolvesTo {
  bool? isBaby;
  Species? species;
  List<EvolutionDetails>? evolutionDetails;
  List<EvolvesTo>? evolvesTo;

  EvolvesTo({this.isBaby, this.species, this.evolutionDetails, this.evolvesTo});

  EvolvesTo.fromJson(Map<String, dynamic> json) {
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
    if (json['evolution_details'] != null) {
      evolutionDetails = <EvolutionDetails>[];
      json['evolution_details'].forEach((v) {
        evolutionDetails!.add(new EvolutionDetails.fromJson(v));
      });
    }
    if (json['evolves_to'] != null) {
      evolvesTo = <EvolvesTo>[];
      json['evolves_to'].forEach((v) {
        evolvesTo!.add(new EvolvesTo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species!.toJson();
    }
    if (this.evolutionDetails != null) {
      data['evolution_details'] =
          this.evolutionDetails!.map((v) => v.toJson()).toList();
    }
    if (this.evolvesTo != null) {
      data['evolves_to'] = this.evolvesTo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EvolutionDetails {
  Null? item;
  Species? trigger;
  Null? gender;
  Null? heldItem;
  Null? knownMove;
  Null? knownMoveType;
  Null? location;
  int? minLevel;
  Null? minHappiness;
  Null? minBeauty;
  Null? minAffection;
  bool? needsOverworldRain;
  Null? partySpecies;
  Null? partyType;
  Null? relativePhysicalStats;
  String? timeOfDay;
  Null? tradeSpecies;
  bool? turnUpsideDown;

  EvolutionDetails(
      {this.item,
      this.trigger,
      this.gender,
      this.heldItem,
      this.knownMove,
      this.knownMoveType,
      this.location,
      this.minLevel,
      this.minHappiness,
      this.minBeauty,
      this.minAffection,
      this.needsOverworldRain,
      this.partySpecies,
      this.partyType,
      this.relativePhysicalStats,
      this.timeOfDay,
      this.tradeSpecies,
      this.turnUpsideDown});

  EvolutionDetails.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    trigger =
        json['trigger'] != null ? new Species.fromJson(json['trigger']) : null;
    gender = json['gender'];
    heldItem = json['held_item'];
    knownMove = json['known_move'];
    knownMoveType = json['known_move_type'];
    location = json['location'];
    minLevel = json['min_level'];
    minHappiness = json['min_happiness'];
    minBeauty = json['min_beauty'];
    minAffection = json['min_affection'];
    needsOverworldRain = json['needs_overworld_rain'];
    partySpecies = json['party_species'];
    partyType = json['party_type'];
    relativePhysicalStats = json['relative_physical_stats'];
    timeOfDay = json['time_of_day'];
    tradeSpecies = json['trade_species'];
    turnUpsideDown = json['turn_upside_down'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    if (this.trigger != null) {
      data['trigger'] = this.trigger!.toJson();
    }
    data['gender'] = this.gender;
    data['held_item'] = this.heldItem;
    data['known_move'] = this.knownMove;
    data['known_move_type'] = this.knownMoveType;
    data['location'] = this.location;
    data['min_level'] = this.minLevel;
    data['min_happiness'] = this.minHappiness;
    data['min_beauty'] = this.minBeauty;
    data['min_affection'] = this.minAffection;
    data['needs_overworld_rain'] = this.needsOverworldRain;
    data['party_species'] = this.partySpecies;
    data['party_type'] = this.partyType;
    data['relative_physical_stats'] = this.relativePhysicalStats;
    data['time_of_day'] = this.timeOfDay;
    data['trade_species'] = this.tradeSpecies;
    data['turn_upside_down'] = this.turnUpsideDown;
    return data;
  }
}