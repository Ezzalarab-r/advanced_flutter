import 'package:advanced_flutter/domain/entities/store_details.dart';
import 'package:dartz/dartz.dart';

import '../../data/failures/failure.dart';
import '../repositories/repository.dart';
import 'base_uc.dart';

class StoreDetailsUC implements BaseUC<int, StoreDetails> {
  final Repository _repository;
  StoreDetailsUC(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(int storeId) async {
    return await _repository.getStoreDetails(storeId);
  }
}
