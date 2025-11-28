import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/exam_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/entities/subject_entity.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/use_cases/get_all_exams_use_case.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/domain/use_cases/get_all_subjects_use_case.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_events.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/cubit/explore_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ExploreTabCubit extends Cubit<ExploreTabStates>{
  ExploreTabCubit(this._getAllSubjectsUseCase,this._getAllExamsUseCase):super(ExploreTabStates());
  final GetAllSubjectsUseCase _getAllSubjectsUseCase;
  final GetAllExamsUseCase _getAllExamsUseCase;
  void doIntent(ExploreTabEvents event){
    if(isClosed) return;
    switch (event){
      
      case GetAllSubjectsEvent():
        _getAllSubjects();
      case SearchSubjectsEvent():
        _searchSubjects(event.query, event.allSubjects);
      case GetAllExamsEvent():
        _getAllExams();
    }
  }
  Future<void> _getAllSubjects()async{
    if(isClosed) return;
    emit(state.copyWith(
      gettingAllSubjects: BaseState<List<SubjectEntity>>(
        isLoading: true
      )
    ));
    BaseResponse<List<SubjectEntity>> response=await _getAllSubjectsUseCase();
    if(isClosed) return;
    switch (response){
      
      case SuccessResponse<List<SubjectEntity>>():
        emit(state.copyWith(
          gettingAllSubjects: BaseState<List<SubjectEntity>>(
            isLoading: false,
            data: response.data
          )
        ));
      case ErrorResponse<List<SubjectEntity>>():
        emit(state.copyWith(
          gettingAllSubjects: BaseState<List<SubjectEntity>>(
            isLoading: false,
            errorMessage: response.error.message
          )
        ));
    }
  }
  Future<void>_getAllExams()async{
    if(isClosed) return;
    emit(state.copyWith(
      getAllExams: BaseState<List<ExamEntity>>(
        isLoading: true
      )
    ));
    BaseResponse<List<ExamEntity>> response=await _getAllExamsUseCase();
    if(isClosed) return;
    switch(response){
      
      case SuccessResponse<List<ExamEntity>>():
        emit(state.copyWith(
          getAllExams: BaseState<List<ExamEntity>>(
            isLoading: false,
            data: response.data
          )
        ));
      case ErrorResponse<List<ExamEntity>>():
        emit(state.copyWith(
          getAllExams: BaseState<List<ExamEntity>>(
            isLoading: false,
            errorMessage: response.error.message
          )
        ));
    }
  }
  Future<void> _searchSubjects(String query,List<SubjectEntity> allSubjects)async{
    if (isClosed) return;
    final filtered=query.isEmpty?allSubjects:
    allSubjects.where((subject) =>subject.name?.toLowerCase().contains(query.toLowerCase())==true).toList();
    emit(state.copyWith(
      searchQuery: query,
      filteredSubjects: filtered,
    ));
  }
}