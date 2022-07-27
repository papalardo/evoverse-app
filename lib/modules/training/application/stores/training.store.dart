import 'package:app/modules/training/infra/datasources/training.datasource.dart';
import 'package:app/modules/training/infra/models/training-data.model.dart';
import 'package:app/stores/base.store.dart';
import 'package:get/get.dart';

class TrainingStore extends BaseStore<TrainingStore, TrainingDataModel> {

  static TrainingStore get to => Get.find();

  @override
  Future<TrainingDataModel> fetch() => TrainingDatasource().fetchData();

}