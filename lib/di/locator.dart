import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teamvisual/data/datasource/remote/http_remote.dart';
import 'package:teamvisual/data/datasource/remote/remote.dart';
import 'package:teamvisual/data/mapper/entity_mapper.dart';
import 'package:teamvisual/data/mapper/entity_mapper_impl.dart';
import 'package:teamvisual/data/repository/app_repository_impl.dart';
import 'package:teamvisual/domain/repository/app_repository.dart';
import 'package:teamvisual/domain/usecase/delete_tables_use_case.dart';
import 'package:teamvisual/domain/usecase/download_file_use_case.dart';
import 'package:teamvisual/domain/usecase/get_all_pending_use_case.dart';
import 'package:teamvisual/domain/usecase/get_alternatives_by_question_use_case.dart';
import 'package:teamvisual/domain/usecase/get_assist_types_use_case.dart';
import 'package:teamvisual/domain/usecase/get_courses_use_case.dart';
import 'package:teamvisual/domain/usecase/get_evaluations_by_course_use_case.dart';
import 'package:teamvisual/domain/usecase/get_files_by_course_use_case.dart';
import 'package:teamvisual/domain/usecase/get_modules_use_case.dart';
import 'package:teamvisual/domain/usecase/get_question_by_evaluation_use_case.dart';
import 'package:teamvisual/domain/usecase/get_total_evaluations_use_case.dart';
import 'package:teamvisual/domain/usecase/save_assist_use_case.dart';
import 'package:teamvisual/domain/usecase/save_evaluations_use_case.dart';
import 'package:teamvisual/domain/usecase/send_assists_pending_use_case.dart';
import 'package:teamvisual/domain/usecase/send_assists_use_case.dart';
import 'package:teamvisual/domain/usecase/send_evaluations_pending_use_case.dart';
import 'package:teamvisual/domain/usecase/send_evaluations_use_case.dart';
import 'package:teamvisual/domain/usecase/sign_in_use_case.dart';
import 'package:teamvisual/domain/usecase/update_courses_use_case.dart';
import 'package:teamvisual/domain/usecase/update_videos_use_case.dart';
import 'package:teamvisual/domain/usecase/val_version_use_case.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';
import 'package:teamvisual/presentation/viewmodel/assist_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:teamvisual/presentation/viewmodel/course_detail_view_model.dart';
import 'package:teamvisual/presentation/viewmodel/main_view_model.dart';
import 'package:teamvisual/presentation/viewmodel/module_view_model.dart';
import 'package:teamvisual/presentation/viewmodel/course_view_model.dart';
import 'package:teamvisual/presentation/viewmodel/pending_view_model.dart';
import '../data/datasource/local/app_database.dart';
import '../domain/usecase/get_videos_by_course_use_case.dart';
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
  getIt.registerSingleton<Remote>(HttpRemote(http.Client(), Dio()));

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
      AppRepositoryImpl(getIt(), getIt(), getIt(), getIt()));

}

Future<void> _domain() async {

  ///Use Cases
  getIt.registerSingleton(SignInUseCase(getIt()));
  getIt.registerSingleton(ValVersionUseCase(getIt()));
  getIt.registerSingleton(SyncUseCase(getIt()));
  getIt.registerSingleton(GetModulesUseCase(getIt()));
  getIt.registerSingleton(GetAssistTypesUseCase(getIt()));
  getIt.registerSingleton(SaveAssistUseCase(getIt()));
  getIt.registerSingleton(SendAssistsUseCase(getIt()));
  getIt.registerSingleton(DeleteTablesUseCase(getIt()));
  getIt.registerSingleton(GetCoursesUseCase(getIt()));
  getIt.registerSingleton(GetVideosByCourseUseCase(getIt()));
  getIt.registerSingleton(GetFilesByCourseUseCase(getIt()));
  getIt.registerSingleton(GetEvaluationByCourseUseCase(getIt()));
  getIt.registerSingleton(GetQuestionByEvaluationUseCase(getIt()));
  getIt.registerSingleton(GetAlternativesByQuestionUseCase(getIt()));
  getIt.registerSingleton(SendEvaluationsUseCase(getIt()));
  getIt.registerSingleton(DownloadFileUseCase(getIt()));
  getIt.registerSingleton(GetAllPendingUseCase(getIt()));
  getIt.registerSingleton(UpdateVideosUseCase(getIt()));
  getIt.registerSingleton(SaveEvaluationsUseCase(getIt()));
  getIt.registerSingleton(UpdateCoursesUseCase(getIt()));
  getIt.registerSingleton(SendAssistsPendingUseCase(getIt()));
  getIt.registerSingleton(SendEvaluationsPendingUseCase(getIt()));
  getIt.registerSingleton(GetTotalEvaluationsUseCase(getIt()));

}

Future<void> _presentation() async {

  /// ViewModels
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(getIt(),
      getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<MainViewModel>(() => MainViewModel(getIt()));
  getIt.registerFactory<AssistViewModel>(() => AssistViewModel(getIt(),
    getIt(), getIt()));
  getIt.registerFactory<ModuleViewModel>(() => ModuleViewModel(getIt(),
      getIt(), getIt()));
  getIt.registerFactory<CourseViewModel>(() => CourseViewModel(getIt(),
    getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<CourseDetailViewModel>(() => CourseDetailViewModel(
      getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<PendingViewModel>(() => PendingViewModel(getIt(),
      getIt(), getIt()));

  ///Navigator
  getIt.registerLazySingleton(() => NavigationService());

}

Future<AppDatabase> getDbInstance() async {
  return await $FloorAppDatabase.databaseBuilder(AppConstants.teamVisualDB).build();
}
