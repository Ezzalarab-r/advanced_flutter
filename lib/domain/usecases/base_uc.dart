import 'package:dartz/dartz.dart';

import '../../data/failures/failure.dart';

abstract class BaseUC<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
