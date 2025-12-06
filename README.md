## Лабораторна робота №3 (Class Diagram)
**Назва:** Створення Класів та Керування Об’єктами в ObjectScript
### Мета роботи

Продемонструвати роботу з об’єктами, класами та їхніми властивостями в InterSystems ObjectScript.
У межах предметної області необхідно розробити кілька взаємопов’язаних класів, що демонструють:
 - Наслідування від абстрактного класу
 - Різні типи властивостей (литеральні, посилальні, стріми)
 - Зв’язки "один-до-багатьох" і "батько-діти"
 - Колекції типу list та array (масив)
 - Вбудовані об'єкти
 - Required / Unique властивості
 - Обмеження (minlen, maxlen, minval, maxval)
 - Усі класи повинні логічно відповідати вибраній предметній області.

### 1. Library.Item — Абстрактний клас
Типи властивостей:
- Title As %String — Required, minlen=1, maxlen=200
- ItemID As %Integer — Unique
- PublishedYear As %Integer — minval=1500, maxval=$HOROLOG date year
- DescriptionStream As %Stream.GlobalCharacter — stream

### 2. Library.Book — Наслідує Library.Item
Властивості:
- Author As %String
- Pages As %Integer (minval=1, maxval=3000)
Методи:
- DisplayInfo(): %String — форматування інформації про книгу

### 3. Library.Magazine — Наслідує Library.Item
Властивості:
- IssueNumber As %Integer (minval=1, maxval=9999)

### 4. Library.Member — Клас читача
Властивості:
- Name As %String — Required
- MemberID As %Integer — Unique
- RegisteredDate As %TimeStamp
- BorrowLimit As %Integer — InitialExpression = 3
- BorrowedItems As list Of Library.Item — List collection, містить об’єкти
Методи:
- CanBorrow() As %Boolean
- BorrowItem(item As Library.Asset)

### 5. Library.Collection — Загальна бібліотечна колекція
Властивості:
- Name As %String — Required
- Items As list Of Library.Asset — Колекція матеріалів
- Members As list Of Library.Member — Колекція читачів
Методи:
- AddItem(item)
- AddMember(member)


### UML-Діаграма Класів (текстовий опис)
[Library.Asset] <|-- [Library.Book]
[Library.Asset] <|-- [Library.Magazine]

[Library.Member] "1" o-- "0..*" [Library.Asset] : BorrowedItems
[Library.Collection] "1" o-- "0..*" [Library.Asset] : Items
[Library.Collection] "1" o-- "0..*" [Library.Member] : Members

Коротко:
Наслідування: Book, Magazine ← Item
Один-до-багатьох: Member → many Item, Collection → many Items, Collection → many Members
Stream: DescriptionStream у Asset
Колекції: BorrowedItems, Items, Members
Унікальність: ItemID, MemberID
Required: Title, Name

Обмеження: PublishedYear, Pages, IssueNumberes
