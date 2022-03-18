import 'package:shared_preferences/shared_preferences.dart';
import 'package:teamvisual/data/datasource/remote/http_remote.dart';
import 'package:teamvisual/data/datasource/remote/remote.dart';
import 'package:teamvisual/data/mapper/entity_mapper.dart';
import 'package:teamvisual/data/mapper/entity_mapper_impl.dart';
import 'package:teamvisual/data/repository/app_repository_impl.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/get_assist_types_use_case.dart';
import 'package:teamvisual/domain/usecase/get_modules_use_case.dart';
import 'package:teamvisual/domain/usecase/save_assist_use_case.dart';
import 'package:teamvisual/domain/usecase/send_assists_use_case.dart';
import 'package:teamvisual/domain/usecase/sign_in_use_case.dart';
import 'package:teamvisual/domain/usecase/val_version_use_case.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';
import 'package:teamvisual/presentation/viewmodel/assist_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:teamvisual/presentation/viewmodel/main_view_model.dart';
import '../data/datasource/local/app_database.dart';
import '../domain/usecase/sync_use_case.dart';
import '../presentation/utils/navigation_service.dart';
import '../presentation/viewmodel/login_view_model.dart';

final getIt = GetIt.I;

Future<void> initializeDI() async {
  await _data();
  await _domain();
  await _presentation();
}

Future<void> _data() async {

  ///Remote
  getIt.registerSingleton<Remote>(HttpRemote(http.Client()));

  ///Mapper to entities
  getIt.registerSingleton<EntityMapper>(EntityMapperImpl());

  ///Prefs
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPref);

  //Database
  final appDatabase = await getDbInstance();
  getIt.registerLazySingleton<AppDatabase>(() => appDatabase);

  ///Repositories
  getIt.registerLazySingleton<AppRepository>(() =>
      AppRepositoryImpl(getIt.get(), getIt.get(), getIt.get(), getIt.get()));

}

Future<void> _domain() async {

  ///Use Cases
  getIt.registerSingleton(SignInUseCase(getIt.get()));
  getIt.registerSingleton(ValVersionUseCase(getIt.get()));
  getIt.registerSingleton(SyncUseCase(getIt.get()));
  getIt.registerSingleton(GetModulesUseCase(getIt.get()));
  getIt.registerSingleton(GetAssistTypesUseCase(getIt.get()));
  getIt.registerSingleton(SaveAssistUseCase(getIt.get()));
  getIt.registerSingleton(SendAssistsUseCase(getIt.get()));

}

Future<void> _presentation() async {

  /// ViewModels
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(getIt.get(),
      getIt.get(), getIt.get()));
  getIt.registerFactory<MainViewModel>(() => MainViewModel(getIt.get(),
      getIt.get()));
  getIt.registerFactory<AssistViewModel>(() => AssistViewModel(getIt.get(),
    getIt.get(), getIt.get()));

  ///Navigator
  getIt.registerLazySingleton(() => NavigationService());

}

Future<AppDatabase> getDbInstance() async {
  return await $FloorAppDatabase.databaseBuilder(AppConstants.teamVisualDB).build();
}
