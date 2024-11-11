// Маркерная аннотация для указания, что прилепляемая частица
// является желудем. Основной способ связывания желудей между собой.
//
// Может быть использована над параметром конструктора/метода завязи желудя, полем класса
// или методом установки значения.
//
// Параметры:
//   Значение - Строка - Имя внедряемого желудя. Если не заполнено, используется имя параметра конструктора/поля класса
//                       или часть имени метода для установки значения.
//   Тип - Строка - Тип внедряемого желудя. В случае передачи значения "Желудь", будет внедрен желудь как таковой.
//                  Так же может быть указан тип "Массив", "ТаблицаЗначений" и другие. Полный список доступных типов
//                  см. в библиотеке [autumn-collections](https://github.com/autumn-library/autumn-collections).
//   Блестяшка - Произвольный - Повторяемый параметр. Передаваемые в прилепляемый желудь произвольные значения.
//
// Пример:
//
//  1.
//  &Желудь
//  Процедура ПриСозданииОбъекта(&Пластилин ДругойЖелудь)
//
//  2.
//  &Желудь
//  Процедура ПриСозданииОбъекта(
//  .  &Пластилин(Значение = "ДругойЖелудь", Тип = "Массив", Блестяшка = "Парам1", Блестяшка = "Парам2") Зависимость
//	)
//
//  3.
//  &Пластилин
//  Перем ДругойЖелудь;
//
//  4.
//  &Завязь
//  Функция МойЖелудь(&Пластилин ДругойЖелудь) Экспорт
//
//  5.
//  &Пластилин
//  Процедура УстановитьДругойЖелудь(Зависимость) Экспорт
//
&Аннотация("Пластилин")
Процедура ПриСозданииОбъекта(Значение = "", Тип = "", &Повторяемый Блестяшка = Неопределено)

КонецПроцедуры
