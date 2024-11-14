// Задает способ управления жизненным циклом желудя.
//
// ОСень содержит два базовых характера желудя: "Одиночка" и "Компанейский".
//
// По умолчанию все желуди имеют характер "Одиночка", означающий, что желудь
// инициализируется один раз. При каждом запросе желудя будет возвращаться один и тот же
// экземпляр.
//
// Характер "Компанейский" означает, что каждый раз при запросе желудя будет создаваться
// новый экземпляр.
//
// Размещается над конструктором класса или над методом `&Завязи`.
//
// Параметры:
//   Значение - Строка - Характер желудя.
//
// Пример:
//  1. &Характер("Одиночка")
//  2. &Характер("Компанейский")
//
&Аннотация("Характер")
Процедура ПриСозданииОбъекта(Значение)

КонецПроцедуры
