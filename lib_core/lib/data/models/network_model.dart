import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/network.dart';

class NetworkModel extends Equatable {
  NetworkModel({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  String name;
  int id;
  String logoPath;
  String originCountry;

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"] == null ? "n/a" : json["logo_path"],
        originCountry: json["origin_country"],
      );

  Network toEntity() => Network(
        name: this.name,
        id: this.id,
        logoPath: this.logoPath,
        originCountry: this.originCountry,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "logo_path": logoPath,
        "origin_country": originCountry,
      };

  @override
  List<Object?> get props => [
        name,
        id,
        logoPath,
        originCountry,
      ];
}
