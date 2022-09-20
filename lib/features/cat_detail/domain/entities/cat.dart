import '/features/cat_detail/domain/entities/image.dart';
import 'package:equatable/equatable.dart';

/// Business object that contain all information about cat
class Cat extends Equatable {
  /// Constructor
  const Cat({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.temperament,
    required this.origin,
    required this.adaptability,
  });

  /// Identification of cat
  final String id;

  /// Breeds of cat
  final String name;

  /// Information basic about cat
  final String description;

  /// Object business with url image
  final Image? image;

  /// Attributes conduct of cat
  final String temperament;

  /// Code of country where cat is origin
  final String origin;

  /// Capacity adaptability
  final num adaptability;

  @override
  List<Object> get props => [
        id,
        name,
        description,
        temperament,
        origin,
        adaptability,
      ];
}
