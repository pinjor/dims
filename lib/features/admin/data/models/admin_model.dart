class AdminUser {
  final int id;
  final String username;
  final String email;
  final bool isActive;
  final bool isSuperuser;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AdminUser({
    required this.id,
    required this.username,
    required this.email,
    required this.isActive,
    required this.isSuperuser,
    required this.createdAt,
    this.updatedAt,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      isActive: json['is_active'],
      isSuperuser: json['is_superuser'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'is_active': isActive,
      'is_superuser': isSuperuser,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class AdminLoginResponse {
  final String accessToken;
  final String tokenType;
  final AdminUser adminUser;

  AdminLoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.adminUser,
  });

  factory AdminLoginResponse.fromJson(Map<String, dynamic> json) {
    return AdminLoginResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      adminUser: AdminUser.fromJson(json['admin_user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'admin_user': adminUser.toJson(),
    };
  }
}

class Medicine {
  final int id;
  final int? slNumber;
  final String? manufacturerName;
  final String? brandName;
  final String? genericNameStrength;
  final String? dosageForm;
  final String? useFor;
  final String? darNumber;
  final String? category;
  final String? drugCode;
  final String? countryCode;
  final String? packSize;
  final String? specialCategory;
  final String? shelfLife;
  final String? temperatureCondition;
  final String? therapeuticClass;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Medicine({
    required this.id,
    this.slNumber,
    this.manufacturerName,
    this.brandName,
    this.genericNameStrength,
    this.dosageForm,
    this.useFor,
    this.darNumber,
    this.category,
    this.drugCode,
    this.countryCode,
    this.packSize,
    this.specialCategory,
    this.shelfLife,
    this.temperatureCondition,
    this.therapeuticClass,
    required this.createdAt,
    this.updatedAt,
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
      category: json['category'],
      drugCode: json['drug_code'],
      countryCode: json['country_code'],
      packSize: json['pack_size'],
      specialCategory: json['special_category'],
      shelfLife: json['shelf_life'],
      temperatureCondition: json['temperature_condition'],
      therapeuticClass: json['therapeutic_class'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
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
      'category': category,
      'drug_code': drugCode,
      'country_code': countryCode,
      'pack_size': packSize,
      'special_category': specialCategory,
      'shelf_life': shelfLife,
      'temperature_condition': temperatureCondition,
      'therapeutic_class': therapeuticClass,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'sl_number': slNumber,
      'manufacturer_name': manufacturerName,
      'brand_name': brandName,
      'generic_name_strength': genericNameStrength,
      'dosage_form': dosageForm,
      'use_for': useFor,
      'dar_number': darNumber,
      'category': category,
      'drug_code': drugCode,
      'country_code': countryCode,
      'pack_size': packSize,
      'special_category': specialCategory,
      'shelf_life': shelfLife,
      'temperature_condition': temperatureCondition,
      'therapeutic_class': therapeuticClass,
    };
  }
}
