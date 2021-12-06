import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/production_country.dart';

class ProductionCountryModel extends Equatable {
  ProductionCountryModel({
    required this.iso31661,
    required this.name,
  });

  String iso31661;
  String name;

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) => ProductionCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  ProductionCountry toEntity() => ProductionCountry(
        iso31661: this.iso31661,
        name: this.name,
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
      };

  @override
  List<Object?> get props => [
        iso31661,
        name,
      ];
}
