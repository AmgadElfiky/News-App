// ignore: camel_case_types
abstract class newsState {}

// ignore: camel_case_types
class newsInitailState extends newsState {}

// ignore: camel_case_types
class newsBottomNavState extends newsState {}

// ignore: camel_case_types
class newsLoadingState extends newsState {}

// ignore: camel_case_types
class newsGetBusinessSuccessState extends newsState {}

// ignore: camel_case_types
class newsGetBusinessErrorState extends newsState {
  final String error;

  newsGetBusinessErrorState(this.error);
}

// ignore: camel_case_types
class newsSprotsLoadingState extends newsState {}

// ignore: camel_case_types
class newsGetSportsSuccessState extends newsState {}

// ignore: camel_case_types
class newsGetSportsErrorState extends newsState {
  final String error;

  newsGetSportsErrorState(this.error);
}

// ignore: camel_case_types
class newsScienceLoadingState extends newsState {}

// ignore: camel_case_types
class newsGetScienceSuccessState extends newsState {}

// ignore: camel_case_types
class newsGetScienceErrorState extends newsState {
  final String error;

  newsGetScienceErrorState(this.error);
}

// ignore: camel_case_types
class newsSearchLoadingState extends newsState {}

// ignore: camel_case_types
class newsGetSearchSuccessState extends newsState {}

// ignore: camel_case_types
class newsGetSearchErrorState extends newsState {
  final String error;

  newsGetSearchErrorState(this.error);
}