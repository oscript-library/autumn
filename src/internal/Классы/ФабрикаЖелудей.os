#Использовать asserts
#Использовать reflector

Перем ОпределенияЖелудей;
Перем ОпределенияНапильников;

Функция ПолучитьОпределенияЖелудей() Экспорт
	Возврат Новый ФиксированноеСоответствие(ОпределенияЖелудей);
КонецФункции

Функция ПолучитьОпределениеЖелудя(Имя) Экспорт
	Возврат ОпределенияЖелудей.Получить(Имя);
КонецФункции

Функция ЗарегистрироватьЖелудь(ТипЖелудя, Имя) Экспорт

	ОпределениеЖелудя = ЗарегистрироватьЖителяЛеса(ТипЖелудя, Имя, "Желудь");

	Возврат ОпределениеЖелудя;

КонецФункции

Функция ЗарегистрироватьДуб(ТипДуба) Экспорт

	ОпределениеЖелудя = ЗарегистрироватьЖителяЛеса(ТипДуба, "", "Дуб");

	РефлекторОбъекта = Новый РефлекторОбъекта(ТипДуба);

	МетодыЗавязи = РефлекторОбъекта.ПолучитьТаблицуМетодов("Завязь");

	Для Каждого МетодЗавязи Из МетодыЗавязи Цикл
		
		// todo: refactor. Выделить отдельный метод по аналогии с ЗарегистрироватьЖителяЛеса
		МаркиПластилина = ПрочитатьМаркиПластилинаВМетоде(МетодЗавязи);
		Завязь = СоздатьЗавязьЧерезМетодЗавязи(ТипДуба, МетодЗавязи);

		ТипЖелудяЗавязи = Тип(МетодЗавязи.Имя);
		ИмяЖелудяЗавязи = МетодЗавязи.Имя;

		ОпределениеЗавязи = Новый ОпределениеЖелудя(
			ТипЖелудяЗавязи,
			ИмяЖелудяЗавязи,
			ХарактерыЖелудей.Одиночка(),
			МаркиПластилина,
			Завязь
		);
		ОпределенияЖелудей.Вставить(ОпределениеЗавязи.Имя(), ОпределениеЗавязи);

	КонецЦикла;

	Возврат ОпределениеЖелудя;

КонецФункции

Функция ЗарегистрироватьНапильник(ТипНапильника) Экспорт
	ОпределениеНапильника = ЗарегистрироватьЖителяЛеса(ТипНапильника, "", "Напильник");

	ДобавитьОпределениеНапильника(ОпределениеНапильника);

	Возврат ОпределениеНапильника;
КонецФункции

Функция ЗарегистрироватьСистемныйНапильник(ТипНапильника) Экспорт
	ОпределениеНапильника = ЗарегистрироватьЖителяЛеса(ТипНапильника, "", "Напильник");

	ДобавитьОпределениеНапильника(ОпределениеНапильника, Истина);

	Возврат ОпределениеНапильника;
КонецФункции

Функция ПолучитьЖелудь(КонтекстПриложения, ИмяЖелудя) Экспорт

	ОпределениеЖелудя = КонтекстПриложения.ПолучитьОпределениеЖелудя(ИмяЖелудя);

	Ожидаем.Что(
		ОпределениеЖелудя, 
		СтрШаблон("Не удалось получить определение Желудя по имени Желудя %1", ИмяЖелудя)
	).Не_().Равно(Неопределено);

	КускиПластилина = Новый Массив;
	Для Каждого МаркиПластилина Из ОпределениеЖелудя.МаркиПластилина() Цикл
		КусокПластилина = КонтекстПриложения.ПолучитьЖелудь(МаркиПластилина);
		КускиПластилина.Добавить(КусокПластилина);
	КонецЦикла;

	Завязь = ОпределениеЖелудя.Завязь();
	
	Действие = Завязь.Действие();
	Если Завязь.ЭтоКонструктор() Тогда
		Желудь = Действие.Выполнить(ОпределениеЖелудя.ТипЖелудя(), КускиПластилина);
	Иначе
		Желудь = Действие.Выполнить(КонтекстПриложения, Завязь.Родитель(), Завязь.ИмяМетода(), КускиПластилина);
	КонецЕсли;

	ЭтоНапильник = ОпределенияНапильников.Найти(ОпределениеЖелудя.Имя(), "Имя") <> Неопределено;
	Если НЕ ЭтоНапильник Тогда
		Для Каждого ОпределениеНапильника Из ОпределенияНапильников Цикл
			
			Если ОпределениеНапильника.Имя = ИмяЖелудя Тогда
				Продолжить;
			КонецЕсли;
			
			Напильник = КонтекстПриложения.ПолучитьЖелудь(ОпределениеНапильника.Имя);
			Желудь = Напильник.ОбработатьЖелудь(Желудь, ИмяЖелудя);
		
		КонецЦикла;
	КонецЕсли;

	Возврат Желудь;
	
КонецФункции

Функция ЗарегистрироватьЖителяЛеса(ТипЖителяТеля, ИмяЖителяЛеса, АннотацияНадКонструктором)

	РефлекторОбъекта = Новый РефлекторОбъекта(ТипЖителяТеля);

	Методы = РефлекторОбъекта.ПолучитьТаблицуМетодов(АннотацияНадКонструктором, Ложь);
	Ожидаем.Что(
		Методы.Количество(), 
		"Класс должен иметь ровно один метод с аннотацией &" + АннотацияНадКонструктором
	).Равно(1);

	Конструктор = Методы[0];

	ОпределениеЖелудя = СоздатьОпределениеЖелудя(ТипЖителяТеля, Конструктор, ИмяЖителяЛеса);
	ОпределенияЖелудей.Вставить(ОпределениеЖелудя.Имя(), ОпределениеЖелудя);

	Возврат ОпределениеЖелудя;

КонецФункции

Функция СоздатьОпределениеЖелудя(ТипЖелудя, Конструктор, Знач ИмяЖелудя = "")

	МаркиПластилина = ПрочитатьМаркиПластилинаВМетоде(Конструктор);
	Характер = ПрочитатьХарактерЖелудя(Конструктор);
	Завязь = СоздатьЗавязьЧерезКонструкторОбъекта(ТипЖелудя, Конструктор);

	Если Не ЗначениеЗаполнено(ИмяЖелудя) Тогда
		ИмяЖелудя = Строка(ТипЖелудя);
	КонецЕсли;

	ОпределениеЖелудя = Новый ОпределениеЖелудя(ТипЖелудя, ИмяЖелудя, Характер, МаркиПластилина, Завязь);

	Возврат ОпределениеЖелудя;

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

Функция ПрочитатьМаркиПластилинаВМетоде(Метод)

	МаркиПластилина = Новый Массив;
	Для Каждого ПараметрМетода Из Метод.Параметры Цикл

		АннотацияПластилин = РаботаСАннотациями.ПолучитьАннотацию(ПараметрМетода, "Пластилин");
		
		Ожидаем.Что(
			АннотацияПластилин,
			СтрШаблон("У параметра метода %1 не найдена аннотация ""Пластилин""", ПараметрМетода.Имя)
		).Не_().Равно(Неопределено);

		МаркаПластилина = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(
			АннотацияПластилин,
			,
			ПараметрМетода.Имя
		);

		МаркиПластилина.Добавить(МаркаПластилина);

	КонецЦикла;

	Возврат МаркиПластилина;

КонецФункции

Функция ПрочитатьХарактерЖелудя(Метод)
	ЗначениеПоУмолчанию = ХарактерыЖелудей.Одиночка();

	Аннотация = РаботаСАннотациями.ПолучитьАннотацию(Метод, "Характер");
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

Процедура ДобавитьОпределениеНапильника(ОпределениеНапильника, Системный = Ложь)

	Аннотация = РаботаСАннотациями.ПолучитьАннотацию(ОпределениеНапильника.Завязь().ДанныеМетода(), "Напильник");
	Порядок = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, "Порядок", 1);

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

	СтрокаОпределений = ОпределенияНапильников.Добавить();
	СтрокаОпределений.Порядок = Порядок;
	СтрокаОпределений.Имя = ОпределениеНапильника.Имя();
	СтрокаОпределений.ОпределениеНапильника = ОпределениеНапильника;

	ОпределенияНапильников.Сортировать("Порядок Возр");

КонецПроцедуры

Процедура ПриСозданииОбъекта()
	ОпределенияЖелудей = Новый Соответствие();
	
	ОпределенияНапильников = Новый ТаблицаЗначений();
	ОпределенияНапильников.Колонки.Добавить("Порядок", Новый ОписаниеТипов("Число"));
	ОпределенияНапильников.Колонки.Добавить("Имя", Новый ОписаниеТипов("Строка"));
	ОпределенияНапильников.Колонки.Добавить("ОпределениеНапильника", Новый ОписаниеТипов("ОпределениеЖелудя"));

	ОпределенияНапильников.Индексы.Добавить("Имя");
	ОпределенияНапильников.Индексы.Добавить("Порядок");
КонецПроцедуры