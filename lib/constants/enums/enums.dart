enum AudioState { PLAYING, STOPPED }
enum AvailableProfessions { doctor, midwife }
enum ChatPopMenu { NewGroup, NewBroadcast, Settings }
enum ChatGroupPopMenu { GroupInfo, MuteNotification, ExitGroup, ClearChat }

enum Type { checkpoint, line }
enum TodoTask { COMPLETED, INCOMPLETE, INCOMING }
enum TodoTaskCategory { Clinic, Suppliments, Diet, Others }

enum TtsState { playing, stopped, paused, continued }
enum Level { low, normal }
enum Status { veryWeak, weak, good, veryGood, excellent }

enum Configuration {
  Onboarding,
  SignUp,
  Profile,
  Non,
  Done,
  Terms,
  NameScreenStepDone,
  WeeksPregnancyScreenStepDone,
  YearOfBirthScreenStepDone,
  MotherhoodInfoScreenStepDone,
  MoreInfoScreenStepDone
}

enum ConfigTerms { NON, ALL, PARTIAL }

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
