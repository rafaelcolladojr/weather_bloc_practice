import 'package:dartz/dartz.dart';
import 'package:weather_bloc_practice/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
