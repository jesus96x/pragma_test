import 'package:app_cats/core/usecases/usecase.dart';
import 'package:app_cats/features/cat_detail/domain/entities/cat.dart';
import 'package:app_cats/features/cat_detail/domain/entities/image.dart';
import 'package:app_cats/features/cat_detail/domain/repositories/cat_repository.dart';
import 'package:app_cats/features/cat_detail/domain/usecases/get_cats.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_cats_test.mocks.dart';

@GenerateMocks([CatRepository])
void main() {
  late GetCats usecase;
  late MockCatRepository mockCatRepository;

  setUp(() {
    mockCatRepository = MockCatRepository();
    usecase = GetCats(mockCatRepository);
  });

  const tName1 = 'Abyssinian';
  const tName2 = 'Arabian Mau';
  final tCats = [
    const Cat(
      id: 'id',
      name: tName1,
      description: 'test',
      image: Image(id: 'test', url: 'test-url-image'),
      temperament: 'test',
      origin: 'test',
      adaptability: 1,
    ),
    const Cat(
      id: 'id',
      name: tName2,
      description: 'test',
      image: Image(id: 'test', url: 'test-url-image'),
      temperament: 'test',
      origin: 'test',
      adaptability: 1,
    ),
  ];

  test('should get list of cat from the repository', () async {
    // Arrange
    when(mockCatRepository.getCats()).thenAnswer((_) async => Right(tCats));
    // Act
    final result = await usecase(NoParams());
    // Assert
    expect(result, Right(tCats));
    // Verify that the method has been called on the Repository
    verify(mockCatRepository.getCats());
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockCatRepository);
  });
}
