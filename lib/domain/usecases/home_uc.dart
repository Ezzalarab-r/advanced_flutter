import 'package:dartz/dartz.dart';

import '../../data/failures/failure.dart';
import '../entities/home_object.dart';
import '../repositories/repository.dart';
import 'base_uc.dart';

class HomeUC implements BaseUC<void, HomeObject> {
  final Repository _repository;
  HomeUC(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}
