#Использовать annotations
#Использовать asserts
#Использовать fluent
#Использовать reflector

#Область ОписаниеПеременных

// Поделка - Управляющий ioc-контейнер.
Перем Поделка;
// РазворачивательАннотаций - разворачиватель аннотаций свойств и методов желудей.
Перем РазворачивательАннотаций;
// ПрилепляторЧастиц - объект, который умеет прилеплять частицы к желудям.
Перем ПрилепляторЧастиц;

// Соответствие, в котором хранятся все определения желудей:
//  * Ключ - Строка - имя желудя.
//  * Значение - ОпределениеЖелудя - определение желудя.
Перем ОпределенияЖелудейПоИмени;

// Соответствие, в котором хранятся все определения желудей.
//  * Ключ - Строка - прозвище желудя
//  * Значение - Массив из ОпределениеЖелудя - определения желудей с таким прозвищем.
Перем ОпределенияЖелудейПоПрозвищу;

// Массив из ОпределениеЖелудя - Список определений желудей, являющихся напильниками.
Перем ОпределенияНапильников;

// Соответствие, в котором хранятся все определения желудей, являющихся напильниками.  
//  * Ключ - Строка - имя желудя.
//  * Значение - ОпределениеЖелудя - определение напильника.
Перем ОпределенияНапильниковПоИмени;

// Соответствие - Соответствие, в котором хранится список применяемых к конкретному
//                желудю напильников.  
//  * Ключ - Строка - имя желудя.
//  * Значение - ОпределениеЖелудя - определение напильника.
Перем КэшПрименяемыхНапильников;

// Массив из ОпределениеЖелудя - Список инициализируемых в данный момент напильников.
Перем ИнициализируемыеНапильники;

// Лог - Логгер ФабрикиЖелудей.
Перем Лог;

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ПолучитьОпределенияЖелудей() Экспорт
	Возврат Новый ФиксированноеСоответствие(ОпределенияЖелудейПоИмени);
КонецФункции

Функция ПолучитьОпределениеЖелудя(Имя) Экспорт
	НайденноеОпределение = ОпределенияЖелудейПоИмени.Получить(Имя);
	Если НайденноеОпределение <> Неопределено Тогда
		Возврат НайденноеОпределение;
	КонецЕсли;

	НайденныеОпределения = ОпределенияЖелудейПоПрозвищу.Получить(Имя);
	Если НайденныеОпределения = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	Если НайденныеОпределения.Количество() = 1 Тогда
		Возврат НайденныеОпределения[0];
	КонецЕсли;

	НайденноеОпределение = НайтиОпределениеВерховного(НайденныеОпределения);
	
	Если НайденноеОпределение = Неопределено Тогда
		ВызватьИсключение "Найдено несколько желудей с именем/прозвищем """ + Имя + """";
	КонецЕсли;

	Возврат НайденноеОпределение;
КонецФункции

Функция ПолучитьСписокОпределенийЖелудей(Имя) Экспорт

	Результат = Новый Массив;

	НайденноеОпределение = ОпределенияЖелудейПоИмени.Получить(Имя);
	Если НайденноеОпределение <> Неопределено Тогда
		Результат.Добавить(НайденноеОпределение);
		Возврат Новый ФиксированныйМассив(Результат);
	КонецЕсли;

	Результат = Новый ТаблицаЗначений();
	Результат.Колонки.Добавить("Порядок");
	Результат.Колонки.Добавить("ОпределениеЖелудя");

	НайденныеОпределения = ОпределенияЖелудейПоПрозвищу.Получить(Имя);
	
	Если НайденныеОпределения <> Неопределено Тогда
		Для Каждого Определение Из НайденныеОпределения Цикл
			Строка = Результат.Добавить();
			Строка.ОпределениеЖелудя = Определение;
			Строка.Порядок = Определение.Порядок();
		КонецЦикла;
	КонецЕсли;

	Результат.Сортировать("Порядок Возр");
	КопияРезультат = Результат.ВыгрузитьКолонку("ОпределениеЖелудя");

	Возврат Новый ФиксированныйМассив(КопияРезультат);

КонецФункции

Процедура ПроинициализироватьНапильники() Экспорт

	Для Каждого ОпределениеНапильника Из ОпределенияНапильников Цикл
		Поделка.НайтиЖелудь(ОпределениеНапильника.Имя());
	КонецЦикла;

КонецПроцедуры

Функция ДобавитьДуб(ТипДуба) Экспорт

	ИмяКорневойАннотации = "Завязь";
	ОпределениеЖелудя = ДобавитьЖителяЛеса(ТипДуба, "", "Дуб");
	МетодыЗавязи = ОпределениеЖелудя.НайтиМетодыСАннотациями(ИмяКорневойАннотации);

	Для Каждого МетодЗавязи Из МетодыЗавязи Цикл
		
		ИмяЖелудя = ПрочитатьИмяЖелудя(МетодЗавязи.Аннотации, ИмяКорневойАннотации, МетодЗавязи.Имя);
		ТипЖелудя = ПрочитатьТипЖелудя(МетодЗавязи, МетодЗавязи.Аннотации);

		ОпределениеЗавязи = СоздатьОпределениеЖелудя(
			ИмяЖелудя,
			ТипЖелудя,
			ТипДуба, 
			МетодЗавязи,
			МетодЗавязи.Аннотации,
			ИмяКорневойАннотации
		);
		СохранитьОпределениеЖелудя(ОпределениеЗавязи);

	КонецЦикла;

	Возврат ОпределениеЖелудя;

КонецФункции

Функция ДобавитьНапильник(ТипНапильника) Экспорт
	ОпределениеНапильника = ДобавитьЖителяЛеса(ТипНапильника, "", "Напильник");

	ДобавитьОпределениеНапильника(ОпределениеНапильника);

	Возврат ОпределениеНапильника;
КонецФункции

Функция ДобавитьСистемныйНапильник(ТипНапильника) Экспорт
	ОпределениеНапильника = ДобавитьЖителяЛеса(ТипНапильника, "", "Напильник");

	ДобавитьОпределениеНапильника(ОпределениеНапильника, Истина);

	Возврат ОпределениеНапильника;
КонецФункции

Функция НайтиЖелудь(ИмяЖелудя, ПрилепляемыеЧастицы) Экспорт

	ОпределениеЖелудя = Поделка.ПолучитьОпределениеЖелудя(ИмяЖелудя);

	Если ОпределениеЖелудя = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Не удалось получить определение Желудя по имени Желудя %1", ИмяЖелудя);
	КонецЕсли;

	ЭтоНапильник = ОпределенияНапильниковПоИмени.Получить(ОпределениеЖелудя.Имя()) <> Неопределено;

	Если ЭтоНапильник Тогда
		Если ИнициализируемыеНапильники.Найти(ОпределениеЖелудя.Имя()) = Неопределено Тогда
			ИнициализируемыеНапильники.Добавить(ОпределениеЖелудя.Имя());
		КонецЕсли;
	КонецЕсли;

	ПереданныеПрилепляемыеЧастицы = ПрилепляемыеЧастицы;
	Если ПереданныеПрилепляемыеЧастицы = Неопределено Тогда
		ПереданныеПрилепляемыеЧастицы = Новый Массив;
	КонецЕсли;

	Если ПереданныеПрилепляемыеЧастицы.Количество() = ОпределениеЖелудя.ПрилепляемыеЧастицы().Количество() Тогда
		ПередаваемыеПрилепляемыеЧастицы = ПереданныеПрилепляемыеЧастицы;
	Иначе
		
		КоличествоБлестяшек = ПосчитатьКоличествоБлестяшек(ОпределениеЖелудя.ПрилепляемыеЧастицы());

		Если КоличествоБлестяшек <> ПереданныеПрилепляемыеЧастицы.Количество() Тогда
			ВызватьИсключение СтрШаблон(
				"При поиске желудя %1 количество переданных произвольных параметров отличается от количества параметров не-желудей/не-деталек.",
				ИмяЖелудя
			);
		КонецЕсли;

		СчетчикИспользованияБлестяшек = 0;
		ПередаваемыеПрилепляемыеЧастицы = Новый Массив;
		Для Каждого ДанныеОПрилепляемойЧастице Из ОпределениеЖелудя.ПрилепляемыеЧастицы() Цикл
			
			Если ДанныеОПрилепляемойЧастице.ТипЧастицы() = ТипыПрилепляемыхЧастиц.Блестяшка() Тогда
				ПрилепляемаяЧастица = ПереданныеПрилепляемыеЧастицы[СчетчикИспользованияБлестяшек];
				СчетчикИспользованияБлестяшек = СчетчикИспользованияБлестяшек + 1;
			Иначе
				ПрилепляемаяЧастица = ПрилепляторЧастиц.НайтиПрилепляемуюЧастицу(ДанныеОПрилепляемойЧастице);
			КонецЕсли;

			ПередаваемыеПрилепляемыеЧастицы.Добавить(ПрилепляемаяЧастица);
		КонецЦикла;
	КонецЕсли;

	Завязь = ОпределениеЖелудя.Завязь();
	
	Действие = Завязь.Действие();
	Если Завязь.ЭтоКонструктор() Тогда
		Желудь = Действие.Выполнить(ОпределениеЖелудя.ТипЖелудя(), ПередаваемыеПрилепляемыеЧастицы);
	ИначеЕсли Не ЗначениеЗаполнено(Завязь.Родитель()) Тогда
		Рефлектор = Новый Рефлектор();
		Желудь = Рефлектор.ВызватьМетод(Действие, "Выполнить", ПередаваемыеПрилепляемыеЧастицы);		
	Иначе
		Желудь = Действие.Выполнить(Поделка, Завязь.Родитель(), Завязь.ИмяМетода(), ПередаваемыеПрилепляемыеЧастицы);
	КонецЕсли;

	Если ЭтоНапильник Тогда
		ИндексНапильника = ИнициализируемыеНапильники.Найти(ОпределениеЖелудя.Имя());
		ИнициализируемыеНапильники.Удалить(ИндексНапильника);
	Иначе
		Если НЕ ОпределениеЖелудя.Спецификация() = СостоянияПриложения.Инициализация() Тогда
			
			ПрименяемыеНапильники = ОпределитьПрименяемыеНапильники(ОпределениеЖелудя);

			Для Каждого ОпределениеНапильника Из ПрименяемыеНапильники Цикл
				
				Если ОпределениеНапильника.Имя() = ОпределениеЖелудя.Имя() Тогда
					ТекстСообщения = СтрШаблон(
						"Напильник %1 не может быть применен сам к себе",
						ОпределениеНапильника.Имя()
					);
					Лог.Отладка(ТекстСообщения);

					Продолжить;
				КонецЕсли;

				Если ИнициализируемыеНапильники.Найти(ОпределениеНапильника.Имя()) <> Неопределено Тогда
					ТекстСообщения = СтрШаблон(
						"Напильник %1 не может быть применен к желудю %2, так как он уже инициализируется.",
						ОпределениеНапильника.Имя(),
						ОпределениеЖелудя.Имя()
					);
					Лог.Отладка(ТекстСообщения);

					Продолжить;
				КонецЕсли;
				
				Напильник = Поделка.НайтиЖелудь(ОпределениеНапильника.Имя());
				Желудь = Напильник.ОбработатьЖелудь(Желудь, ОпределениеЖелудя);
			
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;

	Возврат Желудь;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция НайтиОпределениеВерховного(Коллекция)
	Для Каждого Элемент Из Коллекция Цикл
		Если Элемент.Верховный() = Истина Тогда
			Возврат Элемент; 
		КонецЕсли;
	КонецЦикла;
	Возврат Неопределено;
КонецФункции

Функция ПосчитатьКоличествоБлестяшек(ПрилепляемыеЧастицы)
	Количество = 0;
	Для Каждого Элемент Из ПрилепляемыеЧастицы Цикл
		Если Элемент.ТипЧастицы() = ТипыПрилепляемыхЧастиц.Блестяшка() Тогда
			Количество = Количество + 1;	
		КонецЕсли;
	КонецЦикла;
	Возврат Количество;
КонецФункции

Функция ДобавитьЖителяЛеса(ТипЖителяЛеса, ИмяЖителяЛеса, АннотацияНадКонструктором) Экспорт

	РефлекторОбъекта = Новый РефлекторОбъекта(ТипЖителяЛеса);
	АннотацияНадКонструкторомКаноническая = НРег(АннотацияНадКонструктором);
	УсловияПоиска = Новый Структура("Имя", АннотацияНадКонструкторомКаноническая);

	Методы = РефлекторОбъекта.ПолучитьТаблицуМетодов(Неопределено, Ложь);
	Конструктор = Неопределено;
	Аннотации = Неопределено;
	
	Для Каждого Метод Из Методы Цикл
		РазворачивательАннотаций.РазвернутьАннотацииСвойства(Метод, ТипЖителяЛеса);
		Аннотации = Метод.Аннотации;

		НайденныеСтроки = Аннотации.НайтиСтроки(УсловияПоиска);
		Если НайденныеСтроки.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;

		Если НайденныеСтроки.Количество() > 1 Тогда
			ВызватьИсключение СтрШаблон(
				"Над методом ""%1"" жителя леса с типом ""%2"" найдено более одной аннотации ""%3"".",
				Метод.Имя,
				ТипЖителяЛеса,
				АннотацияНадКонструктором
			);
		КонецЕсли;
		
		Конструктор = Метод;
		Прервать;
	КонецЦикла;

	Если Конструктор = Неопределено Тогда
		ВызватьИсключение СтрШаблон(
			"Не найден метод жителя леса типа ""%1"" с аннотацией ""%2"".",
			ТипЖителяЛеса,
			АннотацияНадКонструктором
		);
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ИмяЖителяЛеса) Тогда
		ИмяЖителяЛеса = ПрочитатьИмяЖелудя(Аннотации, АннотацияНадКонструктором, Строка(ТипЖителяЛеса));
	КонецЕсли;

	ОпределениеЖелудя = СоздатьОпределениеЖелудя(
		ИмяЖителяЛеса,
		ТипЖителяЛеса,
		ТипЖителяЛеса,
		Конструктор,
		Аннотации,
		АннотацияНадКонструктором
	);
	СохранитьОпределениеЖелудя(ОпределениеЖелудя);

	ПараметрыСобытия = Новый Массив;
	ПараметрыСобытия.Добавить(ОпределениеЖелудя);
	ВызватьСобытие("ПриДобавленииОпределенияЖелудя", ПараметрыСобытия);

	Возврат ОпределениеЖелудя;

КонецФункции

Функция СоздатьОпределениеЖелудя(
	ИмяЖелудя,
	ТипЖелудя,
	ТипВладельцаСвойств,
	Конструктор,
	Аннотации,
	ИмяКорневойАннотации
)

	Завязь = СоздатьЗавязь(ТипВладельцаСвойств, Конструктор);
	
	ПрилепляемыеЧастицы = ПрочитатьПрилепляемыеЧастицыВМетоде(Конструктор, ТипВладельцаСвойств);
	Характер = ПрочитатьХарактерЖелудя(Аннотации);
	Прозвища = ПрочитатьПрозвища(Аннотации, ИмяЖелудя);
	Порядок = ПрочитатьПорядок(Аннотации);
	Верховный = ПрочитатьПризнакВерховногоЖелудя(Аннотации);
	Спецификация = ПрочитатьСпецификацию(Аннотации);
	КорневаяАннотация = ПрочитатьКорневуюАннотацию(Аннотации, ИмяКорневойАннотации);

	// TODO: Унести в Приемку &Дуб
	// Если Спецификация = СостоянияПриложения.Инициализация() 
	// 	И НЕ ОпределениеЖелудя.Спецификация() = СостоянияПриложения.Инициализация() Тогда
	// 	ТекстСообщения = СтрШаблон(
	// 		"Дуб %1 имеет завязь %2, которая имеет &Спецификацию ""Инициализация"", но сам дуб не имеет этой спецификации.",
	// 		ОпределениеЖелудя.Имя(),
	// 		Конструктор.Имя
	// 	);
	// 	ВызватьИсключение ТекстСообщения;
	// КонецЕсли;

	Если ТипЗнч(ТипЖелудя) <> Тип("Тип") Тогда
		ТипЖелудяДляОпределения = ПрочитатьТипЖелудя(Конструктор, Конструктор.Аннотации);;
	Иначе
		ТипЖелудяДляОпределения = ТипЖелудя;
	КонецЕсли;

	ОпределениеЖелудя = Новый ОпределениеЖелудя(
		РазворачивательАннотаций,
		ТипЖелудяДляОпределения,
		ИмяЖелудя,
		Характер,
		ПрилепляемыеЧастицы,
		Завязь,
		Прозвища,
		Порядок,
		Верховный,
		Спецификация,
		КорневаяАннотация
	);

	Возврат ОпределениеЖелудя;

КонецФункции

#Область СозданиеЗавязи

Функция СоздатьЗавязь(ТипВладельцаСвойств, Конструктор)

	Если НРег(Конструктор.Имя) = НРег("ПриСозданииОбъекта")
		ИЛИ НРег(Конструктор.Имя) = НРег("OnObjectCreation") Тогда

		Возврат СоздатьЗавязьЧерезКонструкторОбъекта(ТипВладельцаСвойств, Конструктор);
	
	ИначеЕсли ТипЗнч(ТипВладельцаСвойств) = Тип("Сценарий") Тогда

		Возврат СоздатьЗавязьЧерезМетодЛямбды(ТипВладельцаСвойств, Конструктор);

	Иначе

		Возврат СоздатьЗавязьЧерезМетодЗавязи(ТипВладельцаСвойств, Конструктор);

	КонецЕсли;

КонецФункции

Функция СоздатьЗавязьЧерезКонструкторОбъекта(ТипЖелудя, Конструктор)
	
	Действие = Новый Действие(ФабричныеМетоды, "КонструкторОбъекта");
	Завязь = Новый Завязь(Строка(ТипЖелудя), Конструктор.Имя, Конструктор, Действие, Истина);

	Возврат Завязь;

КонецФункции

Функция СоздатьЗавязьЧерезМетодЗавязи(ТипДуба, МетодЗавязи)

	Действие = Новый Действие(ФабричныеМетоды, "МетодЗавязи");
	Завязь = Новый Завязь(Строка(ТипДуба), МетодЗавязи.Имя, МетодЗавязи, Действие, Ложь);

	Возврат Завязь;

КонецФункции

Функция СоздатьЗавязьЧерезМетодЛямбды(Сценарий, МетодЗавязи)

	Действие = Новый Действие(Сценарий, МетодЗавязи.Имя);
	Завязь = Новый Завязь("", МетодЗавязи.Имя, МетодЗавязи, Действие, Ложь);

	Возврат Завязь;

КонецФункции

#КонецОбласти

#Область ЧтениеПараметровЖелудя

Функция ПрочитатьИмяЖелудя(Аннотации, АннотацияНадМетодом, ЗначениеПоУмолчанию)

	Аннотация = РаботаСАннотациями.НайтиАннотацию(Аннотации, АннотацияНадМетодом);
	ИмяЖелудя = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, , ЗначениеПоУмолчанию);

	Возврат ИмяЖелудя;

КонецФункции

Функция ПрочитатьТипЖелудя(Метод, Аннотации)

	Аннотация = РаботаСАннотациями.НайтиАннотацию(Аннотации, "Завязь");
	ТипЖелудя = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(
		Аннотация,
		"Тип",,
		Истина
	);

	Если ТипЖелудя = Неопределено Тогда
		ТипЖелудя = Метод.Имя;
	КонецЕсли;

	Попытка
		РеальныйТип = Тип(ТипЖелудя);
	Исключение
		ВызватьИсключение СтрШаблон(
			"Тип желудя в Завязи %1 не известен. Укажите тип желудя в аннотации или переименуйте метод завязи.",
			Метод.Имя
		);
	КонецПопытки;

	Возврат РеальныйТип;
КонецФункции

Функция ПрочитатьПрилепляемыеЧастицыВМетоде(Метод, ТипВладельцаСвойств)

	ПрилепляемыеЧастицы = Новый Массив;
	Для Каждого ПараметрМетода Из Метод.Параметры Цикл

		РазворачивательАннотаций.РазвернутьАннотацииСвойства(ПараметрМетода, ТипВладельцаСвойств);

		ПрилепляемаяЧастица = ПрилепляторЧастиц.ДанныеОПрилепляемойЧастице(ПараметрМетода);
		ПрилепляемыеЧастицы.Добавить(ПрилепляемаяЧастица);

	КонецЦикла;

	Возврат ПрилепляемыеЧастицы;

КонецФункции

Функция ПрочитатьХарактерЖелудя(Аннотации)
	ЗначениеПоУмолчанию = ХарактерыЖелудей.Одиночка();

	Аннотация = РаботаСАннотациями.НайтиАннотацию(Аннотации, "Характер");
	Если Аннотация = Неопределено Тогда
		Возврат ЗначениеПоУмолчанию;
	КонецЕсли;

	ХарактерЖелудя = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(
		Аннотация,
		,
		ЗначениеПоУмолчанию
	);

	Если НЕ ХарактерыЖелудей.ЭтоХарактерЖелудя(ХарактерЖелудя) Тогда
		ВызватьИсключение "Неизвестный характер желудя " + ХарактерЖелудя;
	КонецЕсли;

	Возврат ХарактерЖелудя;
КонецФункции

Функция ПрочитатьПрозвища(Аннотации, ЗначениеПоУмолчанию)
	
	Результат = Новый Массив;
	Результат.Добавить(ЗначениеПоУмолчанию);
		
	Прозвища = РаботаСАннотациями.НайтиАннотации(Аннотации, "Прозвище");
	Для Каждого Аннотация Из Прозвища Цикл
		Прозвище = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация);
		
		Результат.Добавить(Прозвище);
	КонецЦикла;

	Возврат Результат;

КонецФункции

Функция ПрочитатьПорядок(Аннотации)
	
	Аннотация = РаботаСАннотациями.НайтиАннотацию(Аннотации, "Порядок");

	ОпределениеАннотации = Поделка.ПолучитьОпределениеАннотации("Порядок");
	ОбъектАннотации = ОпределениеАннотации.СоздатьОбъектАннотации(Аннотация);

	Возврат ОбъектАннотации.Значение();

КонецФункции

Функция ПрочитатьПризнакВерховногоЖелудя(Аннотации)

	Возврат РаботаСАннотациями.НайтиАннотацию(Аннотации, "Верховный") <> Неопределено;

КонецФункции

Функция ПрочитатьСпецификацию(Аннотации)

	Аннотация = РаботаСАннотациями.НайтиАннотацию(Аннотации, "Спецификация");

	ОпределениеАннотации = Поделка.ПолучитьОпределениеАннотации("Спецификация");
	ОбъектАннотации = ОпределениеАннотации.СоздатьОбъектАннотации(Аннотация);

	Возврат ОбъектАннотации.Значение();

КонецФункции

Функция ПрочитатьКорневуюАннотацию(Аннотации, ИмяКорневойАннотации)

	КорневаяАннотация = РаботаСАннотациями.НайтиАннотацию(Аннотации, ИмяКорневойАннотации);
	ОпределениеАннотации = Поделка.ПолучитьОпределениеАннотации(КорневаяАннотация.Имя);

	ОбъектАннотации = ОпределениеАннотации.СоздатьОбъектАннотации(КорневаяАннотация);

	Возврат ОбъектАннотации;

КонецФункции

#КонецОбласти

Процедура ДобавитьОпределениеНапильника(ОпределениеНапильника, Системный = Ложь)

	Порядок = ОпределениеНапильника.Порядок();

	МинимальныйПорядок = 0;
	Если Порядок < МинимальныйПорядок Тогда
		ВызватьИсключение "Неверное значение параметра ""Порядок"". Порядок не может быть меньше, чем " + МинимальныйПорядок;
	КонецЕсли;

	МаксимальныйПорядок = 999999;
	Если Порядок > МаксимальныйПорядок Тогда
		ВызватьИсключение "Неверное значение параметра ""Порядок"". Порядок не может быть больше, чем " + МаксимальныйПорядок;
	КонецЕсли;

	Если НЕ Системный Тогда
		Если Порядок = МинимальныйПорядок ИЛИ Порядок = МаксимальныйПорядок Тогда
			ВызватьИсключение "Неверное значение параметра ""Порядок"". Использовано зарезервированное значение " + Порядок;
		КонецЕсли;
	КонецЕсли;

	// Реинициализация сортированного списка напильников для возможности их использования в заготовках.
	ОпределенияНапильников = ПолучитьСписокОпределенийЖелудей("Напильник");
	КэшПрименяемыхНапильников.Очистить();
	ОпределенияНапильниковПоИмени.Вставить(ОпределениеНапильника.Имя(), ОпределениеНапильника);

КонецПроцедуры

Процедура СохранитьОпределениеЖелудя(ОпределениеЖелудя)

	СохраненноеОпределениеЖелудя = ОпределенияЖелудейПоИмени.Получить(ОпределениеЖелудя.Имя());
	Если СохраненноеОпределениеЖелудя <> Неопределено Тогда
		Если ОпределениеЖелудя.Верховный() И СохраненноеОпределениеЖелудя.Верховный() Тогда
			ВызватьИсключение "Определение верховного желудя с именем """ + ОпределениеЖелудя.Имя() + """ уже существует";
		ИначеЕсли ОпределениеЖелудя.Верховный() И НЕ СохраненноеОпределениеЖелудя.Верховный() Тогда
			// no-op: Допустимая ситуация переопределения.
			// todo: Логирование
		ИначеЕсли НЕ ОпределениеЖелудя.Верховный() И СохраненноеОпределениеЖелудя.Верховный() Тогда
			// no-op: Допустимая ситуация непереопределения.
			// todo: Логирование
			Возврат;
		Иначе
			ВызватьИсключение "Определение желудя с именем """ + ОпределениеЖелудя.Имя() + """ уже существует";
		КонецЕсли;
	КонецЕсли;

	ОпределенияЖелудейПоИмени.Вставить(ОпределениеЖелудя.Имя(), ОпределениеЖелудя);

	Прозвища = ОпределениеЖелудя.Прозвища();
	Для Каждого Прозвище Из Прозвища Цикл

		СуществующиеИмена = ОпределенияЖелудейПоПрозвищу.Получить(Прозвище);
		Если СуществующиеИмена = Неопределено Тогда
			СуществующиеИмена = Новый Массив;
		КонецЕсли;
		СуществующиеИмена.Добавить(ОпределениеЖелудя);
		ОпределенияЖелудейПоПрозвищу.Вставить(Прозвище, СуществующиеИмена);	

	КонецЦикла;

КонецПроцедуры

Функция ОпределитьПрименяемыеНапильники(ОпределениеЖелудя)

	ИмяЖелудя = ОпределениеЖелудя.Имя();

	ПрименяемыеНапильники = КэшПрименяемыхНапильников.Получить(ИмяЖелудя);
	Если ПрименяемыеНапильники <> Неопределено Тогда
		Возврат ПрименяемыеНапильники;
	КонецЕсли;

	Лог.Отладка("Кэш применяемых напильников для желудя %1 пуст. Выполняется расчет...", ИмяЖелудя);

	ПрименяемыеНапильники = Новый Массив;
	
	АннотацииЗавязи = ОпределениеЖелудя.Завязь().ДанныеМетода().Аннотации;
	АннотацияОсобоеОбращение = РаботаСАннотациями.НайтиАннотацию(АннотацииЗавязи, "ОсобоеОбращение");
	ОпределениеАннотацииОсобоеОбращение = Поделка.ПолучитьОпределениеАннотации("ОсобоеОбращение");
	Если АннотацияОсобоеОбращение <> Неопределено Тогда
		ОбъектАннотацииОсобоеОбращение = ОпределениеАннотацииОсобоеОбращение.СоздатьОбъектАннотации(АннотацияОсобоеОбращение);
	КонецЕсли;

	Для Каждого ОпределениеНапильника Из ОпределенияНапильников Цикл
		
		ИмяНапильника = ОпределениеНапильника.Имя();
		Лог.Отладка("Проверка применения напильника %1", ИмяНапильника);

		КорневаяАннотация = ОпределениеНапильника.КорневаяАннотация();

		НапильникМожетПрименяться = КорневаяАннотация.МожетПрименятьсяНа(ОпределениеЖелудя);		
		
		Лог.Отладка("Напильник %1 может применяться на желуде %2: %3",
			ИмяНапильника,
			ИмяЖелудя,
			НапильникМожетПрименяться
		);

		Если НапильникМожетПрименяться И ОбъектАннотацииОсобоеОбращение <> Неопределено Тогда
			НапильникМожетПрименяться = ОбъектАннотацииОсобоеОбращение.НапильникМожетПрименяться(ИмяНапильника);

			Лог.Отладка(
				"Желудь %1 требует особого обращения. Напильник %2 применяется: %3",
				ИмяЖелудя,
				ИмяНапильника,
				НапильникМожетПрименяться
			);
		КонецЕсли;

		Если НапильникМожетПрименяться Тогда
			ПрименяемыеНапильники.Добавить(ОпределениеНапильника);
		КонецЕсли;

	КонецЦикла;

	КэшПрименяемыхНапильников.Вставить(ИмяЖелудя, ПрименяемыеНапильники);

	Возврат ПрименяемыеНапильники;

КонецФункции

#КонецОбласти

#Область Инициализация

Процедура ПриСозданииОбъекта(пПоделка, пРазворачивательАннотаций, пПрилепляторЧастиц)

	Поделка = пПоделка;
	РазворачивательАннотаций = пРазворачивательАннотаций;
	ПрилепляторЧастиц = пПрилепляторЧастиц;

	ОпределенияЖелудейПоИмени = Новый Соответствие();
	ОпределенияЖелудейПоПрозвищу = Новый Соответствие();

	ИнициализируемыеНапильники = Новый Массив();
	
	ОпределенияНапильниковПоИмени = Новый Соответствие();
	ОпределенияНапильников = Новый Массив();
	КэшПрименяемыхНапильников = Новый Соответствие();

	Лог = Логирование.ПолучитьЛог("oscript.lib.autumn.core.ФабрикаЖелудей");

КонецПроцедуры

#КонецОбласти
