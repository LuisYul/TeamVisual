import 'package:flutter/foundation.dart';
import 'package:teamvisual/data/mapper/entity_mapper.dart';
import 'package:teamvisual/data/model/sync_response.dart';
import 'package:teamvisual/data/model/user_response.dart';
import 'package:teamvisual/data/model/val_version_response.dart';
import 'package:teamvisual/domain/model/alternative_entity.dart';
import 'package:teamvisual/domain/model/assist_type_entity.dart';
import 'package:teamvisual/domain/model/course_entity.dart';
import 'package:teamvisual/domain/model/evaluation_entity.dart';
import 'package:teamvisual/domain/model/file_entity.dart';
import 'package:teamvisual/domain/model/module_entity.dart';
import 'package:teamvisual/domain/model/question_entity.dart';
import 'package:teamvisual/domain/model/user_entity.dart';
import 'package:teamvisual/domain/model/video_entity.dart';
import 'package:teamvisual/presentation/utils/string_extension.dart';

class EntityMapperImpl extends EntityMapper{

  @override
  UserEntity toUserEntity(UserResponse? userResponse) {
    return UserEntity(
      idUser: userResponse?.idUser ?? "",
      name: userResponse?.name ?? "",
      docNumber: userResponse?.docNumber ?? "",
      idUserType: userResponse?.idUserType ?? "",
      userType: userResponse?.userType ?? "",
      idAssistType: userResponse?.idAssistType ?? "",
      photoUrl: userResponse?.photoUrl ?? "",
      error: userResponse?.error ?? "",
      loginStatus: userResponse?.loginStatus ?? "",
    );
  }

  @override
  bool toIsValid(ValVersionResponse? valVersionResponse) {
    final valVersion = valVersionResponse?.valVersion ?? "";
    return valVersion.equalsIgnoreCase("true");
  }

  @override
  List<AssistTypeEntity> toAssistTypeEntity(SyncResponse? syncResponse) {
    final List<AssistTypeEntity> list = [];
    try {
      (syncResponse?.assistTypes?.data.forEach((e) =>
          list.add(AssistTypeEntity(
              id: e?.id ?? 0,
              name: e?.name ?? "",
              order: e?.order ?? 0
          ))
      ));
      list.add(AssistTypeEntity(id: 99, name: "finished", order: 99));
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  @override
  List<ModuleEntity> toModuleEntity(SyncResponse? syncResponse) {
    final List<ModuleEntity> list = [];
    try {
      (syncResponse?.modules?.data.forEach((e) =>
          list.add(ModuleEntity(
            id: e?.id ?? 0,
            name: e?.name ?? "",
            required: e?.required ?? 0,
            order: e?.order ?? 0,
          ))
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  @override
  List<CourseEntity> toCourseEntity(SyncResponse? syncResponse) {
    final List<CourseEntity> list = [];
    try {
      (syncResponse?.courses?.data.forEach((e) =>
          list.add(CourseEntity(
            id: e?.courseId ?? 0,
            course: e?.course ?? "",
            author: e?.author ?? "",
            resume: e?.resume ?? "",
            userId: e?.userId ?? 0,
            startDate: e?.startDate ?? "",
            endDate: e?.endDate ?? "",
            note: e?.note ?? 0,
            advPercent: e?.advPercent ?? 0,
            specAreaId: e?.specAreaId ?? 0,
            specArea: e?.specArea ?? "",
            learningGroupId: e?.learningGroupId ?? 0,
            learningGroup: e?.learningGroup ?? "",
          ))
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  @override
  List<EvaluationEntity> toEvaluationEntity(SyncResponse? syncResponse) {
    final List<EvaluationEntity> list = [];
    try {
      (syncResponse?.evaluations?.data.forEach((e) =>
          list.add(EvaluationEntity(
            id: e?.id ?? 0,
            userId: e?.userId ?? 0,
            userCourseId: e?.userCourseId ?? 0,
            courseId: e?.courseId ?? 0,
            name: e?.name ?? "",
            maxNote: e?.maxNote ?? 0,
            minNote: e?.minNote ?? 0,
          ))
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  @override
  List<FileEntity> toFileEntity(SyncResponse? syncResponse) {
    final List<FileEntity> list = [];
    try {
      (syncResponse?.evaluations?.data.forEach((e) =>
          list.add(FileEntity(
            id: e?.id ?? 0,
          ))
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  @override
  List<VideoEntity> toVideoEntity(SyncResponse? syncResponse) {
    final List<VideoEntity> list = [];
    try {
      (syncResponse?.videos?.data.forEach((e) =>
          list.add(VideoEntity(
            id: e?.videoId ?? 0,
            userId: e?.userId ?? 0,
            courseId: e?.courseId ?? 0,
            videoFile: e?.videoFile ?? "",
            name: e?.name ?? "",
          ))
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  @override
  List<QuestionEntity> toQuestionEntity(SyncResponse? syncResponse) {
    final List<QuestionEntity> list = [];
    try {
      (syncResponse?.questions?.data.forEach((e) =>
          list.add(QuestionEntity(
            id: e?.id ?? 0,
            question: e?.question ?? "",
            evaluationId: e?.evaluationId ?? 0,
            note: e?.note ?? 0,
            questionTypeId: e?.questionTypeId ?? 0,
            questionOrder: e?.questionOrder ?? 0,
            type: e?.type ?? "",
          ))
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  @override
  List<AlternativeEntity> toAlternativeEntity(SyncResponse? syncResponse) {
    final List<AlternativeEntity> list = [];
    try {
      (syncResponse?.alternatives?.data.forEach((e) =>
          list.add(AlternativeEntity(
            id: e?.id ?? 0,
            questionId: e?.questionId ?? 0,
            alternative: e?.alternative ?? "",
            correct: e?.correct ?? 0,
            order: e?.order ?? 0,
          ))
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

}