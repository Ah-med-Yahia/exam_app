import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart';

class ExploreTabStates {
  BaseState<List<SubjectEntity>>? gettingAllSubjects;
  final String searchQuery;
  final List<SubjectEntity>? filteredSubjects;
  ExploreTabStates({this.gettingAllSubjects,this.searchQuery='',this.filteredSubjects});
  ExploreTabStates copyWith({
    BaseState<List<SubjectEntity>>? gettingAllSubjects,
    String? searchQuery,
    List<SubjectEntity>? filteredSubjects
  }
  ){
    return ExploreTabStates(
      gettingAllSubjects: gettingAllSubjects??this.gettingAllSubjects,
      searchQuery: searchQuery??this.searchQuery,
      filteredSubjects: filteredSubjects??this.filteredSubjects
    );
  }
}