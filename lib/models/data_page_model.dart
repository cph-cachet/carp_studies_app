part of carp_study_app;

class DataPageModel {
  int get samplingSize => bloc.data.samplingSize;
  Map<String, int> get samplingTable => bloc.data.samplingTable;

  DataPageModel();
}
