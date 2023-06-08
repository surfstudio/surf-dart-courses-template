import 'dart:collection';

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

List<Territory> listTerritory = [];
Set<AgriculturalMachinery> setMachininery = {};

DateTime nowDate = DateTime.now();
double sumAllDays = 0.0;
double sum50PerDays = 0.0;
double avgAllDays = 0.0;
double avg50PerDays = 0.0;
int i = 0;

void main() {
  mapAfter2010.forEach((key, value) {
    listTerritory.addAll(value);
  });

  mapBefore2010.forEach((key, value) {
    listTerritory.addAll(value);
  });

  for (var item in listTerritory) {
    setMachininery.addAll(item.machineries);
  }

  // сортируем по releaseDate
  setMachininery = SplayTreeSet.from(
      setMachininery, (a, b) => a.releaseDate.compareTo(b.releaseDate));

  for (var item in setMachininery) {
    var age = nowDate.difference(item.releaseDate);

    i++;
    if (i <= setMachininery.length / 2) {
      sum50PerDays = sum50PerDays + age.inDays;
    }

    sumAllDays = sumAllDays + age.inDays;
    //вывод списка техники и возраста в днях
    //print('${item.id} - ${item.releaseDate}. age: ${age.inDays}');
  }
  avgAllDays = sumAllDays / setMachininery.length;
  // тут немного не ясно как брать 50% от 11 , я взял как 5 элементов самой старой техники
  avg50PerDays = sum50PerDays / (setMachininery.length / 2).truncate();

  print(
      'средний возраст всей техники: $avgAllDays дней, ${(avgAllDays / 365).toStringAsFixed(2)} лет');

  print(
      'средний возраст техники для 50% самой старой техники: $avg50PerDays дней, ${(avg50PerDays / 365).toStringAsFixed(2)} лет');
}
