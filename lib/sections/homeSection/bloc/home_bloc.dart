import 'package:morgadi/sections/homeSection/data/home_repository.dart';

class HomeBLoc {
  HomeRepository _homeRepository = HomeRepository();

  String getDisplayName() {
    return _homeRepository.fetchUerName();
  }

  String getCurrentDay() {
    _homeRepository.currentTime();
    return _homeRepository.currentDay();
  }

  getCurrentTime() {
    return _homeRepository.currentTime();
  }

  getTimeIllustration() {
    return _homeRepository.timeIllustration();
  }

  getTimeColor() {
    return _homeRepository.timeColor();
  }
}

final homeBloc = HomeBLoc();
