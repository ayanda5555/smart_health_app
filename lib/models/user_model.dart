class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? medicalAidNumber;
  final String? profilePicture;

  // Medical Information
  final String? bloodGroup;
  final String? allergies;
  final String? chronicConditions;
  final String? medications;
  final String? emergencyContactName;
  final String? emergencyContactNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.medicalAidNumber,
    this.profilePicture,
    this.bloodGroup,
    this.allergies,
    this.chronicConditions,
    this.medications,
    this.emergencyContactName,
    this.emergencyContactNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'medicalAidNumber': medicalAidNumber,
      'profilePicture': profilePicture,
      'bloodGroup': bloodGroup,
      'allergies': allergies,
      'chronicConditions': chronicConditions,
      'medications': medications,
      'emergencyContactName': emergencyContactName,
      'emergencyContactNumber': emergencyContactNumber,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      medicalAidNumber: json['medicalAidNumber'],
      profilePicture: json['profilePicture'],
      bloodGroup: json['bloodGroup'],
      allergies: json['allergies'],
      chronicConditions: json['chronicConditions'],
      medications: json['medications'],
      emergencyContactName: json['emergencyContactName'],
      emergencyContactNumber: json['emergencyContactNumber'],
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? medicalAidNumber,
    String? profilePicture,
    String? bloodGroup,
    String? allergies,
    String? chronicConditions,
    String? medications,
    String? emergencyContactName,
    String? emergencyContactNumber,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      medicalAidNumber: medicalAidNumber ?? this.medicalAidNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      allergies: allergies ?? this.allergies,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      medications: medications ?? this.medications,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactNumber: emergencyContactNumber ?? this.emergencyContactNumber,
    );
  }
}