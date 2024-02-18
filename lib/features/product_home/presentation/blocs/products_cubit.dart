import 'dart:developer' as dev;
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store_demo/core/blocs/api_state.dart';
import 'package:tr_store_demo/core/constants/app_strings.dart';
import 'package:tr_store_demo/core/error/failures.dart';
import 'package:tr_store_demo/core/use_cases/use_case.dart';
import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';
import 'package:tr_store_demo/features/product_home/domain/use_cases/get_products.dart';

class ProductsCubit extends Cubit<ApiState> {
  final GetProducts getProducts;
  final List<Product> _allData = [];
  int _currentPage = 0;
  static const int _pageSize = 10;
  ProductsCubit({required this.getProducts}) : super(ApiInitial());

  Future<void> getProductList() async {
    final Either<Failure, List<Product>> failureOrResponse =
        await getProducts(NoParams());

    failureOrResponse.fold((failure) {
      dev.log(
        'Api call failure: $failure',
      );
      if (failure is ServerFailure) {
        emit(const ApiError(message: AppStrings.serverFailure));
      } else if (failure is CacheFailure) {
        emit(const ApiError(message: AppStrings.cacheFailure));
      } else {
        emit(const ApiError(message: AppStrings.unknownFailure));
      }
    }, (response) {
      _allData.addAll(response);
      emit(ApiSuccess<List<Product>>(response: _paginateData()));
    });
  }

  Future<void> loadMoreData() async {
    _currentPage++;
    emit(ApiSuccess(response: _paginateData()));
  }

  List<Product> _paginateData() {
    int startIndex = 0;
    int endIndex = min(_currentPage * _pageSize + _pageSize, _allData.length);
    return List.from(_allData.getRange(startIndex, endIndex));
  }
}
