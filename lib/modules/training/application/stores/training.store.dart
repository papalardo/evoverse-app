import 'package:app/modules/training/infra/datasources/training.datasource.dart';
import 'package:app/modules/training/infra/models/training-data.model.dart';
import 'package:app/stores/base.store.dart';

class TrainingStore extends BaseStore<TrainingStore, TrainingDataModel> {
  @override
  Future<TrainingDataModel> fetch() => TrainingDatasource().fetchData();

}