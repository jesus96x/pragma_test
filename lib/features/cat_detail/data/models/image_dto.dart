import '/features/cat_detail/domain/entities/image.dart';

/// Data Transfer Object Image
class ImageDTO extends Image {
  /// Constructor
  const ImageDTO({
    required this.id,
    required this.url,
  }) : super(id: id, url: url);

  /// Identify image
  final String id;

  /// Url of image
  final String url;

  /// Convert to DTO
  factory ImageDTO.fromJson(Map<String, dynamic> json) => ImageDTO(
        id: json['id'],
        url: json['url'],
      );

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
      };
}
