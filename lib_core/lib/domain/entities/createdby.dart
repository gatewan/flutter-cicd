import 'package:equatable/equatable.dart';

class CreatedBy extends Equatable {
  CreatedBy({
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

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        gender,
        profilePath,
      ];
}
