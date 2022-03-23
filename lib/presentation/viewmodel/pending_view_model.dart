import 'package:teamvisual/domain/usecase/get_all_pending_use_case.dart';
import 'package:teamvisual/presentation/base/root_view_model.dart';

class PendingViewModel extends RootViewModel {

  final GetAllPendingUseCase _getAllPendingUseCase;

  PendingViewModel(
      this._getAllPendingUseCase,
  );

  @override
  initialize() {

  }

}