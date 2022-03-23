import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/base_use_case.dart';

class DownloadFileUseCase implements BaseUseCase<String, dynamic> {

  final AppRepository _repository;

  const DownloadFileUseCase(this._repository);

  @override
  Future<String> call(params) async{
    return await _repository.downloadFile(params);
  }

}