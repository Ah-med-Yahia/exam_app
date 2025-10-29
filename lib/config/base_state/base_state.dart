class BaseState<T> {
  bool? isLoading;
  T? data;
  String? errorMessage;
  BaseState({this.isLoading=false,this.data,this.errorMessage});
}