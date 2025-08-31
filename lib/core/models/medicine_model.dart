class Medicine {
  final int id;
  final int slNumber;
  final String manufacturerName;
  final String brandName;
  final String genericNameStrength;
  final String dosageForm;
  final String useFor;
  final String darNumber;
  final String? indication;
  final double? price;
  final String? adultDose;
  final String? childDose;
  final String? renalDose;
  final String? administration;
  final String? sideEffects;
  final String? precautionsWarnings;
  final String? pregnancyLactation;
  final String? modeOfAction;
  final String? interaction;
  final String? category;
  final String? drugCode;
  final String? countryCode;
  final String? packSize;
  final String? specialCategory;
  final String? shelfLife;
  final String? temperatureCondition;
  final String? therapeuticClass;
  final DateTime createdAt;
  final DateTime updatedAt;

  Medicine({
    required this.id,
    required this.slNumber,
    required this.manufacturerName,
    required this.brandName,
    required this.genericNameStrength,
    required this.dosageForm,
    required this.useFor,
    required this.darNumber,
    this.indication,
    this.price,
    this.adultDose,
    this.childDose,
    this.renalDose,
    this.administration,
    this.sideEffects,
    this.precautionsWarnings,
    this.pregnancyLactation,
    this.modeOfAction,
    this.interaction,
    this.category,
    this.drugCode,
    this.countryCode,
    this.packSize,
    this.specialCategory,
    this.shelfLife,
    this.temperatureCondition,
    this.therapeuticClass,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      slNumber: json['sl_number'],
      manufacturerName: json['manufacturer_name'],
      brandName: json['brand_name'],
      genericNameStrength: json['generic_name_strength'],
      dosageForm: json['dosage_form'],
      useFor: json['use_for'],
      darNumber: json['dar_number'],
      indication: json['indication'],
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
      adultDose: json['adult_dose'],
      childDose: json['child_dose'],
      renalDose: json['renal_dose'],
      administration: json['administration'],
      sideEffects: json['side_effects'],
      precautionsWarnings: json['precautions_warnings'],
      pregnancyLactation: json['pregnancy_lactation'],
      modeOfAction: json['mode_of_action'],
      interaction: json['interaction'],
      category: json['category'],
      drugCode: json['drug_code'],
      countryCode: json['country_code'],
      packSize: json['pack_size'],
      specialCategory: json['special_category'],
      shelfLife: json['shelf_life'],
      temperatureCondition: json['temperature_condition'],
      therapeuticClass: json['therapeutic_class'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sl_number': slNumber,
      'manufacturer_name': manufacturerName,
      'brand_name': brandName,
      'generic_name_strength': genericNameStrength,
      'dosage_form': dosageForm,
      'use_for': useFor,
      'dar_number': darNumber,
      'indication': indication,
      'price': price,
      'adult_dose': adultDose,
      'child_dose': childDose,
      'renal_dose': renalDose,
      'administration': administration,
      'side_effects': sideEffects,
      'precautions_warnings': precautionsWarnings,
      'pregnancy_lactation': pregnancyLactation,
      'mode_of_action': modeOfAction,
      'interaction': interaction,
      'category': category,
      'drug_code': drugCode,
      'country_code': countryCode,
      'pack_size': packSize,
      'special_category': specialCategory,
      'shelf_life': shelfLife,
      'temperature_condition': temperatureCondition,
      'therapeutic_class': therapeuticClass,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class MedicineListResponse {
  final List<Medicine> items;
  final int total;
  final int page;
  final int size;
  final int pages;

  MedicineListResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.size,
    required this.pages,
  });

  factory MedicineListResponse.fromJson(Map<String, dynamic> json) {
    return MedicineListResponse(
      items: (json['items'] as List)
          .map((item) => Medicine.fromJson(item))
          .toList(),
      total: json['total'],
      page: json['page'],
      size: json['size'],
      pages: json['pages'],
    );
  }
}
