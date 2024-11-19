// Помечает функцию как функцию, создающую желудь.
//
// Может иметь параметры, каждый из которых должен быть промаркирован как &Пластилин, &Деталька или &Блестяшка.
// В указанные параметры автоматически будут прилеплены соответствующие частицы при создании желудя.
//
// Может размещаться над экспортной функцией в классе, проаннотированном как `&Дуб`, или над методом-лямбдой,
// передаваемой в качестве параметра в `Поделка.ДобавитьЗавязь()`.
//
// Параметры:
//   Значение - Строка - Имя создаваемого желудя. По умолчанию будет использовано имя метода.
//   Тип - Строка - Тип создаваемого желудя. 
//                  Требуется если по имени желудя не получается однозначного определить его тип.
//
// Пример:
// &Завязь
// Функция ПользовательскийЖелудь(&Пластилин Зависимость, &Деталька ВажнаяНастройка) Экспорт
// .   Возврат Новый ПользовательскийЖелудь(Зависимость, ВажнаяНастройка);
// КонецФункции
//
&Аннотация("Завязь")
Процедура ПриСозданииОбъекта(Значение = "", Тип = "")

КонецПроцедуры
