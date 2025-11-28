import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart';

sealed class ExploreTabEvents {}
class GetAllSubjectsEvent extends ExploreTabEvents{}
class GetAllExamsEvent extends ExploreTabEvents{}
class SearchSubjectsEvent extends ExploreTabEvents {
  final String query;
  final List<SubjectEntity> allSubjects;

  SearchSubjectsEvent(this.query, this.allSubjects);
}