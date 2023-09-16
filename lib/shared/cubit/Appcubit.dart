import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/network/local/cache_helper.dart';
import 'Appstates.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit(super.AppInitialState);

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode([bool? fromShared]) {
    if (fromShared != null) {
      isDark = fromShared;
    }
    else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: "isDark", value: isDark).then((value) {
        emit(changeAppModeState());
      });
    }
  }
}
