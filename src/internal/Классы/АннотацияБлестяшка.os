// Маркерная аннотация для указания, что прилепляемая частица
// является произвольным значением, передавамым кодом.
//
// Может быть использована только над параметром конструктора/метода завязи желудя.
//
// Пример:
//
// 1.
// &Желудь
// Процедура ПриСозданииОбъекта(&Блестяшка ПроизвольноеЗначение)
//
// 2.
// &Завязь
// Функция МойЖелудь(&Блестяшка ПроизвольноеЗначение) Экспорт
//
&Аннотация("Блестяшка")
Процедура ПриСозданииОбъекта()

КонецПроцедуры
