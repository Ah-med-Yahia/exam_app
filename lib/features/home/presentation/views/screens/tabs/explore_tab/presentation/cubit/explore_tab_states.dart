import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/exam_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart';

class ExploreTabStates {
  BaseState<List<SubjectEntity>>? gettingAllSubjects;
  BaseState<List<ExamEntity>>? getAllExams;
  final String searchQuery;
  final List<SubjectEntity>? filteredSubjects;
  ExploreTabStates({this.gettingAllSubjects,this.getAllExams,this.searchQuery='',this.filteredSubjects});
  ExploreTabStates copyWith({
    BaseState<List<SubjectEntity>>? gettingAllSubjects,
    BaseState<List<ExamEntity>>? getAllExams,
    String? searchQuery,
    List<SubjectEntity>? filteredSubjects
  }
  ){
    return ExploreTabStates(
      gettingAllSubjects: gettingAllSubjects??this.gettingAllSubjects,
      getAllExams: getAllExams??this.getAllExams,
      searchQuery: searchQuery??this.searchQuery,
      filteredSubjects: filteredSubjects??this.filteredSubjects
    );
  }
}