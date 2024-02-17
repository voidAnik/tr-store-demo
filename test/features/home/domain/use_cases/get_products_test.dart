import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tr_store_demo/core/use_cases/use_case.dart';
import 'package:tr_store_demo/features/home/domain/entities/product.dart';
import 'package:tr_store_demo/features/home/domain/repositories/home_repository.dart';
import 'package:tr_store_demo/features/home/domain/use_cases/get_products.dart';

import 'get_products_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late GetProducts useCase;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    useCase = GetProducts(mockHomeRepository);
  });

  const tProductList = [Product(), Product()];
  test(
    'should get product list from the repository',
    () async {
      when(mockHomeRepository.getProducts())
          .thenAnswer((_) async => const Right(tProductList));

      final result = await useCase(NoParams());

      expect(result, const Right(tProductList));

      verify(mockHomeRepository.getProducts());

      verifyNoMoreInteractions(mockHomeRepository);
    },
  );
}
