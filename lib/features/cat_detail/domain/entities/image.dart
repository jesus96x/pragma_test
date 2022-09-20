import 'package:equatable/equatable.dart';

import 'cat.dart';

/// Business object that contain all information of image of [Cat]
class Image extends Equatable {
  /// Constructor
  const Image({
    required this.id,
    required this.url,
  });

  /// Identification of image
  final String id;

  /// Image url with format PNG, JPG of cat
  final String url;

  @override
  List<Object?> get props => [id, url];
}
