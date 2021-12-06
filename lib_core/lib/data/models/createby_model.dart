import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/createdby.dart';

class CreatedByModel extends Equatable {
  CreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  int id;
  String creditId;
  String name;
  int gender;
  String profilePath;

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"] ?? "n/a",
      );

  CreatedBy toEntity() => CreatedBy(
        id: this.id,
        creditId: this.creditId,
        name: this.name,
        gender: this.gender,
        profilePath: this.profilePath,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "gender": gender,
        "profile_path": profilePath,
      };

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        gender,
        profilePath,
      ];
}
