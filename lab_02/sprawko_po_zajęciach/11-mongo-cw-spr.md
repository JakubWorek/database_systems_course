
# Dokumentowe bazy danych – MongoDB

ćwiczenie 1


---

**Imiona i nazwiska autorów:** Jakub Worek

--- 

# Zadanie 1 - połączenie z serwerem bazy danych

Połącz się serwerem MongoDB

Można skorzystać z własnego/lokanego serwera MongoDB
Można stworzyć własny klaster/bazę danych w serwisie MongoDB Atlas
- [https://www.mongodb.com/atlas/database](https://www.mongodb.com/atlas/database)

Połącz za pomocą konsoli mongsh

Ewentualnie zdefiniuj połączenie w wybranym przez siebie narzędziu

Stwórz bazę danych/kolekcję/dokument
- może to być dowolna kolekcja, dowolny dokument – o dowolnej strukturze, chodzi o przetestowanie działania połączenia


---

## Zadanie 1  - rozwiązanie

> Wyniki: 
> 
> przykłady, kod, zrzuty ekranów, komentarz ...

```js
Używam compasa i będą screenki
```
<img src="images/zad1.png">

---


# Zadanie 2 - przykładowe zbiory danych

Zaimportuj przykładowe zbory danych

MongoDB Atlas Sample Dataset
- [https://docs.atlas.mongodb.com/sample-data](https://docs.atlas.mongodb.com/sample-data)
- w przypadku importu z lokalnych plików można wykorzystać polecenie `mongorestore`
	- [https://www.mongodb.com/docs/database-tools/mongorestore/](https://www.mongodb.com/docs/database-tools/mongorestore/)

```
mongorestore <data-dump-folder>
```

np.  

```
mongorestore samples
```

- Oczywiście, w przypadku łączenia się zdalnym serwerem należy podać parametry połączenia oraz dane logowania

Yelp Dataset

- wykorzystaj komendę `mongoimport`
- [https://www.mongodb.com/docs/database-tools/mongoimport](https://www.mongodb.com/docs/database-tools/mongoimport)

```
mongoimport --db <db-name> --collection <coll-name> --type json --file <file>
```


np.

```
mongoimport --db yelp --collection business --type json --file ./yelp_academic_dataset_business.json
```

- można też wykorzystać np.  narzędzie MongoDB Compass


Zapoznaj się ze strukturą przykładowych zbiorów danych/kolekcji
- W bazach danych: MongoDB Atlas Sample Dataset
	- Skomentuj struktury użyte w dokumentach dla dwóch wybranych zbiorów (takich które wydają ci się najciekawsze)
	- np. Sample Analitics Dataset i Sampe Traning Dataset

- W bazie Yelp
	- Skomentuj struktury użyte w dokumentach bazy Yelp

Przetestuj działanie operacji
- `mongodump`
	- [https://www.mongodb.com/docs/database-tools/mongodump/](https://www.mongodb.com/docs/database-tools/mongodump/)
- `mongoexport`
	- [https://www.mongodb.com/docs/database-tools/mongoexport/](https://www.mongodb.com/docs/database-tools/mongoexport/)

---

## Zadanie 2  - rozwiązanie

> Wyniki: 
> 
> przykłady, kod, zrzuty ekranów, komentarz ...

```js
--  ...
```

Import
<img src="images/import.png">

Widok zaimportowanych baz danych
<img src="images/sample.png">

Komentarz

<img src="images/training.png">
<img src="images/analyt.png">

Baza danych sample_analytics z MongoDB Atlas Sample Dataset skupia się na finansach i obejmuje trzy kolekcje: konta użytkowników, informacje o klientach oraz transakcje. Każda kolekcja prezentuje swoją unikalną strukturę:

Konta (accounts): Zawiera szczegóły kont klientów, w tym identyfikatory kont, limity i zakupione produkty. Kolekcja ta wykorzystuje podstawowy indeks na polu _id.

Klienci (customers): Skupia się na informacjach o klientach, jednak konkretna struktura tej kolekcji nie jest szczegółowo opisana w dostępnym źródle.

Transakcje (transactions): Używa wzorca Bucket Pattern do przechowywania zestawów transakcji z danego okresu. Taka struktura pozwala na redukcję rozmiaru indeksów i potencjalne uproszczenie zapytań, a także umożliwia korzystanie z wstępnie zagregowanych danych w dokumentach.

---

# Zadanie 3 - operacje CRUD, operacje wyszukiwania danych

[https://www.mongodb.com/docs/manual/crud/](https://www.mongodb.com/docs/manual/crud/)

Stwórz nową bazę danych
- baza danych będzie przechowywać informacje o klientach, produktach, zamowieniach tych produktów. itp.
- w nazwie bazy danych użyj swoich inicjałów
	- np. `AB-orders`
- zaproponuj strukturę kolekcji/dokumentów (dwie, maksymalnie 3 kolekcje)
	- wykorzystaj typy proste/podstawowe, dokumenty zagnieżdżone, tablice itp.
	- wprowadź kilka przykładowych dokumentów
	- przetestuj operacje wstawiania, modyfikacji/usuwania dokumentów
	- przetestuj operacje wyszukiwania dokumentów

## Zadanie 3  - rozwiązanie

> Wyniki: 
> 
> przykłady, kod, zrzuty ekranów, komentarz ...


Read
```js
db.users.find()
[
  {
    _id: ObjectId('660d41ff28f3d71eddb9b7bf'),
    user_name: 'Jan',
    user_surname: 'Kowalski'
  },
  {
    _id: ObjectId('660d435b28f3d71eddb9b7c0'),
    user_name: 'Dawid',
    user_surname: 'Luna'
  }
]

db.products.find()
[
  {
    _id: ObjectId('660d442628f3d71eddb9b7c5'),
    product_name: 'Jabłka',
    product_price: 10
  },
  {
    _id: ObjectId('660d446c28f3d71eddb9b7c6'),
    product_name: 'Banany',
    product_price: '5'
  }
]

db.orders.find()
[
  {
    _id: ObjectId('660d483a28f3d71eddb9b7d9'),
    user_id: ObjectId('660d41ff28f3d71eddb9b7bf'),
    products: [
      ObjectId('660d442628f3d71eddb9b7c5'),
      ObjectId('660d446c28f3d71eddb9b7c6')
    ]
  },
  {
    _id: ObjectId('660d493328f3d71eddb9b7e2'),
    user_id: ObjectId('660d435b28f3d71eddb9b7c0'),
    products: [ ObjectId('660d442628f3d71eddb9b7c5') ]
  }
]


```
Create
<img src="images/create.png">

Update
<img src="images/update.png">

Delete
<img src="images/delete.png">

---

Ćwiczenie przeznaczone jest do wykonania podczas zajęć. Pod koniec zajęć należy przesłać wyniki prac

Punktacja:

|         |     |
| ------- | --- |
| zadanie | pkt |
| 1       | 0,1 |
| 2       | 0,2 |
| 3       | 0,7 |
| razem   | 1   |
