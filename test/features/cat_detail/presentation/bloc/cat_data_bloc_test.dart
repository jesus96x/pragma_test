// import 'package:app_cats/core/error/failures.dart';
// import 'package:app_cats/core/usecases/usecase.dart';
// import 'package:app_cats/features/cat_detail/domain/entities/cat.dart';
// import 'package:app_cats/features/cat_detail/domain/entities/image.dart';
// import 'package:app_cats/features/cat_detail/domain/usecases/get_cats.dart'
//     as usecase;
// import 'package:app_cats/features/cat_detail/presentation/bloc/cat_data_bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'cat_data_bloc_test.mocks.dart';

// @GenerateMocks([usecase.GetCats])
// void main() {
//   late MockGetCats mockGetCats;
//   late CatDataBloc bloc;

//   setUp(() {
//     mockGetCats = MockGetCats();
//     bloc = CatDataBloc(getCats: mockGetCats);
//   });

//   test('initialState should be Empty', () {
//     // Assert
//     expect(bloc.state, equals(Empty()));
//   });

//   group('getCats', () {
//     final tCats = [
//       const Cat(
//         id: '1',
//         name: 'test',
//         description: 'test',
//         image: Image(id: 'test', url: 'test-url-image'),
//         temperament: 'test',
//         origin: 'test',
//         adaptability: 1,
//       ),
//       const Cat(
//         id: '2',
//         name: 'test',
//         description: 'test',
//         image: Image(id: 'test', url: 'test-url-image'),
//         temperament: 'test',
//         origin: 'test',
//         adaptability: 1,
//       )
//     ];

//     test('should get data from the getCats use case', () async {
//       // Arrange
//       when(mockGetCats(any)).thenAnswer((_) async => Right(tCats));
//       // Act
//       bloc.add(GetCats());
//       await untilCalled(mockGetCats(any));
//       // Assert
//       verify(mockGetCats(NoParams()));
//     });

//     test(
//       'should emit [Loading, Data] when data is gotten successfully',
//       () async {
//         // Arrange
//         when(mockGetCats(any)).thenAnswer((_) async => Right(tCats));
//         // Assert later
//         final expected = [
//           Empty(),
//           Loading(),
//           Data(cats: tCats),
//         ];
//         expectLater(bloc.state, emitsInOrder(expected));
//         // Act
//         bloc.add(GetCats());
//       },
//     );

//     test(
//       'should emit [Loading, Error] when getting data fails',
//       () async {
//         // Arrange
//         when(mockGetCats(any)).thenAnswer((_) async => Left(ServerFailure()));
//         // Assert later
//         final expected = [
//           Empty(),
//           Loading(),
//           const Error(message: SERVER_FAILURE_MESSAGE),
//         ];
//         expectLater(bloc.state, emitsInOrder(expected));
//         // Act
//         bloc.add(GetCats());
//       },
//     );

//     test(
//       'should emit [Loading, Error] with a proper message for the error when getting data fails',
//       () async {
//         // Arrange
//         when(mockGetCats(any)).thenAnswer((_) async => Left(CacheFailure()));
//         // Assert later
//         final expected = [
//           Empty(),
//           Loading(),
//           const Error(message: CACHE_FAILURE_MESSAGE),
//         ];
//         expectLater(bloc.state, emitsInOrder(expected));
//         // Act
//         bloc.add(GetCats());
//       },
//     );
//   });
// }
