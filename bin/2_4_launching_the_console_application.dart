/// Скрипт для сборки приложения.
/// Обязательно принимает параметры в указанном порядке:
/// <os> - Платформа, для которой будет выполнена сборка приложения. Может принимать значения `ios` или `android`
/// <buildType> - Тип сборки приложения. Может принимать значения `qa` или `release`
/// <version> - Версии приложения. Принимает числа от 1 до 100
void launchingTheConsoleApplication(List<String> arguments) {
  if (arguments.length < 3) {
    print('Количество обязательных параметров 3, найдено ${arguments.length}');
    return;
  }

  final os = arguments[0];
  final buildType = arguments[1];
  final version = arguments[2];

  if (os != 'ios' && os != 'android') {
    print(
        'Не удалось выполнить операцию - не удалось распознать ОС $os. Параметр может принимать только значения `android` или `ios`');
    return;
  }

  if (buildType != 'qa' && buildType != 'release') {
    print(
        'Не удалось выполнить операцию - не удалось распознать тип сборки $buildType. Параметр может принимать только значения `qa` или `release`');
    return;
  }

  var checkVersion = int.tryParse(version);

  if (checkVersion == null || checkVersion < 0 || checkVersion > 100) {
    print(
        'Не удалось выполнить операцию - не удалось распознать версию приложения $version. Параметр может принимать только значения от `1` до `100`');
    return;
  }

  /// Если все ок, собираем сборку тут
  /// (на самом деле, не собираем. Собирать сборку мы научимся позднее 🥴)
  print('Сборка собрана!\nПлатформа: $os\nТип сборки: $buildType\nВерсия приложения: $version');
}
