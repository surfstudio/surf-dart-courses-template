enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  int areaInHectare;
  List<String> crops;
  List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  // Переопределяем оператор "==", что бы сравнивать объекты по значению
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

void main() {
  final mapBefore2010 = <Countries, List<Territory>>{
    Countries.brazil: [
      Territory(
        34,
        ['Кукуруза'],
        [
          AgriculturalMachinery(
            'Трактор Степан',
            DateTime(2001),
          ),
          AgriculturalMachinery(
            'Культиватор Сережа',
            DateTime(2007),
          ),
        ],
      ),
    ],
    Countries.russia: [
      Territory(
        14,
        ['Картофель'],
        [
          AgriculturalMachinery(
            'Трактор Гена',
            DateTime(1993),
          ),
          AgriculturalMachinery(
            'Гранулятор Антон',
            DateTime(2009),
          ),
        ],
      ),
      Territory(
        19,
        ['Лук'],
        [
          AgriculturalMachinery(
            'Трактор Гена',
            DateTime(1993),
          ),
          AgriculturalMachinery(
            'Дробилка Маша',
            DateTime(1990),
          ),
        ],
      ),
    ],
    Countries.turkish: [
      Territory(
        43,
        ['Хмель'],
        [
          AgriculturalMachinery(
            'Комбаин Василий',
            DateTime(1998),
          ),
          AgriculturalMachinery(
            'Сепаратор Марк',
            DateTime(2005),
          ),
        ],
      ),
    ],
  };

  final mapAfter2010 = {
    Countries.turkish: [
      Territory(
        22,
        ['Чай'],
        [
          AgriculturalMachinery(
            'Каток Кирилл',
            DateTime(2018),
          ),
          AgriculturalMachinery(
            'Комбаин Василий',
            DateTime(1998),
          ),
        ],
      ),
    ],
    Countries.japan: [
      Territory(
        3,
        ['Рис'],
        [
          AgriculturalMachinery(
            'Гидравлический молот Лена',
            DateTime(2014),
          ),
        ],
      ),
    ],
    Countries.spain: [
      Territory(
        29,
        ['Арбузы'],
        [
          AgriculturalMachinery(
            'Мини-погрузчик Максим',
            DateTime(2011),
          ),
        ],
      ),
      Territory(
        11,
        ['Табак'],
        [
          AgriculturalMachinery(
            'Окучник Саша',
            DateTime(2010),
          ),
        ],
      ),
    ],
  };

  final mapAllTime = <Countries, List<Territory>>{}
    ..addAll(mapBefore2010)
    ..addAll(mapAfter2010);

  // Получаем все единицы техники
  final allMachineries = getAllMachinery(mapAllTime);

  // Сортируем технику по возрасту
  final sortedMachineries = sortMachineriesByAge(allMachineries);

  // Вычисляем средний возраст техники
  final averageAge = calculateAverageAge(sortedMachineries);
  print('Средний возраст техники: $averageAge');

  // Вычисляем средний возраст для 50% самой старой техники
  final medianAge = calculateMedianAge(sortedMachineries);
  print('Средний возраст для 50% самой старой техники: $medianAge');
}

//функция получения List всех машин
List<AgriculturalMachinery> getAllMachinery(
    Map<Countries, List<Territory>> alltime) {
  final allMachineries = <AgriculturalMachinery>[];
  alltime.values.forEach((alltimeList) {
    alltimeList.forEach((alltime) {
      allMachineries.addAll(alltime.machineries);
    });
  });
  return allMachineries;
}

//Функция сортировки
List<AgriculturalMachinery> sortMachineriesByAge(
    List<AgriculturalMachinery> machineries) {
  final sortedMachineries = List<AgriculturalMachinery>.from(machineries);
  sortedMachineries.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
  return sortedMachineries;
}

// Функция для вычисления среднего возраста техники
double calculateAverageAge(List<AgriculturalMachinery> machineries) {
  final totalAge = machineries
      .map((machinery) => machinery.releaseDate.year)
      .reduce((a, b) => a + b);
  return totalAge / machineries.length;
}

// Функция для вычисления среднего возраста для 50% самой старой техники
double calculateMedianAge(List<AgriculturalMachinery> machineries) {
  final sortedMachineries = List<AgriculturalMachinery>.from(machineries);
  sortedMachineries.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));

  final middleIndex = sortedMachineries.length ~/ 2;
  final medianMachineries = sortedMachineries.sublist(0, middleIndex);

  return calculateAverageAge(medianMachineries);
}
