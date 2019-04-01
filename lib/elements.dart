class ElementList {
  final List<Element> elements;

  ElementList({this.elements});

  factory ElementList.fromJson(Map<String, dynamic> json) {
    return ElementList(
      elements: List<Element>.from(json['elements']),
    );
  }
}

class Element {
  final String name;
  final String symbol;
  final int number;
  final int period;
  final String category;
  final double atomicMass;
  final String color;
  final String appearance;
  final String phase;
  final double melt;
  final double boil;
  final double density;
  final String discoveredBy;
  final double modalHeat;
  final String source;
  final String namedBy;
  final String spectralImagePath;
  final String summary;
  final int ypos;
  final int xpos;

  Element({
    this.name,
    this.symbol,
    this.number,
    this.period,
    this.category,
    this.atomicMass,
    this.color,
    this.appearance,
    this.phase,
    this.melt,
    this.boil,
    this.density,
    this.discoveredBy,
    this.modalHeat,
    this.source,
    this.namedBy,
    this.spectralImagePath,
    this.summary,
    this.ypos,
    this.xpos,
  });

  factory Element.fromJson(Map<String, dynamic> json) {
    return Element(
      name: json['name'],
      symbol: json['symbol'],
      number: json['number'],
      period: json['period'],
      category: json['category'],
//      atomicMass: json['atomic_mass'],
      color: json['color'],
      appearance: json['appearance'],
      phase: json['phase'],
//      melt: json['melt'],
//      boil: json['boil'],
//      density: json['density'],
//      discoveredBy: json['discovered_by'],
//      modalHeat: json['modal_heat'],
//      source: json['source'],
//      namedBy: json['named_by'],
//      spectralImagePath: json['spectral_img'],
//      summary: json['summary'],
      ypos: json['ypos'],
      xpos: json['xpos'],
    );
  }
}

/*
{
  "elements" : [{
		"name": "Hydrogen",
		"symbol": "H",
		"number": 1,
		"period": 1,
		"category": "diatomic nonmetal ",
		"atomic_mass": 1.008,
		"color": null,
		"appearance": "colorless gas",
		"phase": "Gas",
		"melt": 13.99,
		"boil": 20.271,
		"density": 0.08988,
		"discovered_by": "Henry Cavendish",
		"molar_heat": 28.836,
		"source":"https://en.wikipedia.org/wiki/Hydrogen",
		"named_by": "Antoine Lavoisier",
		"spectral_img": "https://en.wikipedia.org/wiki/File:Hydrogen_Spectra.jpg",
		"summary": "Hydrogen is a chemical element with chemical symbol H and atomic number 1. With an atomic weight of 1.00794 u, hydrogen is the lightest element on the periodic table. Its monatomic form (H) is the most abundant chemical substance in the Universe, constituting roughly 75% of all baryonic mass.",
		"ypos": 1,
		"xpos": 1,
		"shells": [
		    1
		],
		"electron_configuration": "1s1",
		"electron_affinity": 72.769,
		"electronegativity_pauling": 2.20,
		"ionization_energies": [
				1312.0
		]
	}
]}
 */
