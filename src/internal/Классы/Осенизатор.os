#Использовать collectionos
#Использовать annotations

#Область ОписаниеПеременных

Перем ФабрикаЖелудей;
Перем КонтейнерАннотаций;
Перем Поделка;
Перем СистемныеНапильники;
Перем ПросканированныеТипы;
Перем Рефлектор;

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ПросканироватьИзвестныеТипы() Экспорт

	ПросканироватьТипы(
		Рефлектор.ИзвестныеТипы(Новый Структура("Пользовательский", Истина))
			.ВыгрузитьКолонку("Значение")
	);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПросканироватьТипы(Типы)

	РазворачивательАннотаций = КонтейнерАннотаций.ПолучитьРазворачивательАннотаций();

	// Двойной проход по типам для предварительного добавления аннотаций, которые могут быть нужны
	// для добавления остальных типов желудей.
	Для Каждого ТипЖелудя Из Типы Цикл

		Если ПросканированныеТипы.Содержит(ТипЖелудя) Тогда
			Продолжить;
		КонецЕсли;

		Методы = Рефлектор.ПолучитьТаблицуМетодов(ТипЖелудя);

		Если РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Аннотация").Количество() > 0 Тогда
			ДобавитьАннотацию(ТипЖелудя);
			ПросканированныеТипы.Добавить(ТипЖелудя);
		КонецЕсли;

	КонецЦикла;

	Для Каждого ТипЖелудя Из Типы Цикл

		Если ПросканированныеТипы.Содержит(ТипЖелудя) Тогда
			Продолжить;
		КонецЕсли;

		Методы = Рефлектор.ПолучитьТаблицуМетодов(ТипЖелудя);

		Если РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Аннотация").Количество() > 0 Тогда
			Продолжить;
		КонецЕсли;

		РазворачивательАннотаций.РазвернутьАннотацииСвойств(Методы, ТипЖелудя);

		Если РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Желудь").Количество() > 0 Тогда
			ДобавитьЖелудь(ТипЖелудя);
		ИначеЕсли РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Дуб").Количество() > 0 Тогда
			ДобавитьДуб(ТипЖелудя);
		ИначеЕсли РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Напильник").Количество() > 0 Тогда
			ДобавитьНапильник(ТипЖелудя);
		ИначеЕсли РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Рогатка").Количество() > 0 Тогда
			ДобавитьРогатку(ТипЖелудя);
		ИначеЕсли РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Заготовка").Количество() > 0 Тогда
			ДобавитьЗаготовку(ТипЖелудя);
		Иначе // BSLLS:EmptyCodeBlock-off
			// no-op
		КонецЕсли;

		ПросканированныеТипы.Добавить(ТипЖелудя);

	КонецЦикла;

КонецПроцедуры

Процедура ДобавитьЖелудь(Тип, Имя = "")
	ФабрикаЖелудей.ДобавитьЖелудь(Тип, Имя);
КонецПроцедуры

Процедура ДобавитьДуб(Тип)
	ФабрикаЖелудей.ДобавитьДуб(Тип);
КонецПроцедуры

Процедура ДобавитьНапильник(Тип)

	Если СистемныеНапильники.Содержит(Тип) Тогда
		ФабрикаЖелудей.ДобавитьСистемныйНапильник(Тип);
	Иначе
		ФабрикаЖелудей.ДобавитьНапильник(Тип);
	КонецЕсли;

КонецПроцедуры

Процедура ДобавитьЗаготовку(Тип)

	ОпределениеЗаготовки = ФабрикаЖелудей.ДобавитьЗаготовку(Тип);

	Заготовка = Поделка.НайтиЖелудь(ОпределениеЗаготовки.Имя());
	Заготовка.ПриИнициализацииПоделки(Поделка);

КонецПроцедуры

Процедура ДобавитьРогатку(Тип)
	ФабрикаЖелудей.ДобавитьРогатку(Тип);
КонецПроцедуры

Процедура ДобавитьАннотацию(Тип)
	КонтейнерАннотаций.ДобавитьАннотацию(Тип);
КонецПроцедуры

#КонецОбласти

Процедура ПриСозданииОбъекта(пПоделка, пФабрикаЖелудей, пКонтейнерАннотаций)

	ФабрикаЖелудей     = пФабрикаЖелудей;
	КонтейнерАннотаций = пКонтейнерАннотаций;
	Поделка            = пПоделка;

	СистемныеНапильники = Новый МножествоСоответствие;
	СистемныеНапильники.Добавить(Тип("ОбработкаНапильникомПластилинаНаПолях"));
	СистемныеНапильники.Добавить(Тип("ОбработкаНапильникомФинальныйШтрих"));

	ПросканированныеТипы = Новый МножествоСоответствие;

	Рефлектор = Новый Рефлектор;

КонецПроцедуры
