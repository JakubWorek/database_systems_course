# Dokumentowe bazy danych – MongoDB

ćwiczenie 2


---

**Imiona i nazwiska autorów:** Białecki Jakub, Popowski Przemysław, Worek Jakub

--- 


## Yelp Dataset

- [www.yelp.com](http://www.yelp.com) - serwis społecznościowy – informacje o miejscach/lokalach
- restauracje, kluby, hotele itd. `businesses`,
- użytkownicy odwiedzają te miejsca - "meldują się"  `check-in`
- użytkownicy piszą recenzje `reviews` o miejscach/lokalach i wystawiają oceny oceny,
- przykładowy zbiór danych zawiera dane z 5 miast: Phoenix, Las Vegas, Madison, Waterloo i Edinburgh.

# Zadanie 1 - operacje wyszukiwania danych

Dla zbioru Yelp wykonaj następujące zapytania

W niektórych przypadkach może być potrzebne wykorzystanie mechanizmu Aggregation Pipeline

[https://www.mongodb.com/docs/manual/core/aggregation-pipeline/](https://www.mongodb.com/docs/manual/core/aggregation-pipeline/)


1. Zwróć dane wszystkich restauracji (kolekcja `business`, pole `categories` musi zawierać wartość "Restaurants"), które są otwarte w poniedziałki (pole hours) i mają ocenę co najmniej 4 gwiazdki (pole `stars`).  Zapytanie powinno zwracać: nazwę firmy, adres, kategorię, godziny otwarcia i gwiazdki. Posortuj wynik wg nazwy firmy.

2. Ile każda firma otrzymała ocen/wskazówek (kolekcja `tip` ) w 2012. Wynik powinien zawierać nazwę firmy oraz liczbę ocen/wskazówek Wynik posortuj według liczby ocen (`tip`).

3. Recenzje mogą być oceniane przez innych użytkowników jako `cool`, `funny` lub `useful` (kolekcja `review`, pole `votes`, jedna recenzja może mieć kilka głosów w każdej kategorii).  Napisz zapytanie, które zwraca dla każdej z tych kategorii, ile sumarycznie recenzji zostało oznaczonych przez te kategorie (np. recenzja ma kategorię `funny` jeśli co najmniej jedna osoba zagłosowała w ten sposób na daną recenzję)

4. Zwróć dane wszystkich użytkowników (kolekcja `user`), którzy nie mają ani jednego pozytywnego głosu (pole `votes`) z kategorii (`funny` lub `useful`), wynik posortuj alfabetycznie według nazwy użytkownika.

5. Wyznacz, jaką średnia ocenę uzyskała każda firma na podstawie wszystkich recenzji (kolekcja `review`, pole `stars`). Ogranicz do firm, które uzyskały średnią powyżej 3 gwiazdek.

	a) Wynik powinien zawierać id firmy oraz średnią ocenę. Posortuj wynik wg id firmy.

	b) Wynik powinien zawierać nazwę firmy oraz średnią ocenę. Posortuj wynik wg nazwy firmy.

## Zadanie 1  - rozwiązanie

> Wyniki: 
> 
> przykłady, kod, zrzuty ekranów, komentarz ...

```js
-- Podpunkt 1
db.business.find({
    "categories": "Restaurants",
    "hours.Monday": {$exists: true},
    "stars": {$gte: 4}
},
{
    "name": 1,
    "address": 1,
    "categories": 1,
    "hours.Monday": 1,
    "stars": 1
}).sort({"name": 1})


-- Podpunkt 2
db.tip.aggregate([
  {$match: {date: {$gte: "2012-01-01", $lte: "2012-12-31"}}},
  {$group: {_id: "$business_id", suma: {$sum: 1}}},
  {$lookup: {from: "businesses", localField: "_id", foreignField: "business_id", as: "firma"}},
  {$unwind: "$firma"},
  {$project: {_id: 0, "firma.name": 1, suma: 1}}
]).sort({suma: 1})


-- Podpunkt 3
db.reviews.aggregate([
  {$group: {_id: 0,
  		sum_funny: {$sum: {$cond: [{$gte: ["$votes.funny", 1]}, 1, 0]}},
		sum_useful: {$sum: {$cond: [{$gte: ["$votes.useful", 1]}, 1, 0]}},
      	sum_cool: {$sum: {$cond: [{$gte: ["$votes.cool", 1]}, 1, 0]}}
    }},
  {$project: {_id: 0, sum_funny: 1, sum_useful: 1, sum_cool: 1}}
])


-- Podpunkt 4
db.user.aggregate([
  {$match: {$or: [{"votes.funny": {$eq: 0}}, {"votes.useful": {$eq: 0}}]}}
]).sort({name: 1})


-- Podpunkt 5 - a)
db.reviews.aggregate([
  {$group: {_id: "$business_id", srednia: {$avg: "$stars"}}},
  {$match: {srednia: {$gt: 3}}},
  {$lookup: {from: "businesses", localField: "_id", foreignField: "business_id", as: "firma"}},
  {$unwind: "$firma"},
  {$project: {_id: 1, srednia: {$round: ["$srednia", 2]}}}
]).sort({"_id": 1})


-- Podpunkt 5 - b)
db.reviews.aggregate([
  {$group: {_id: "$business_id", srednia: {$avg: "$stars"}}},
  {$match: {srednia: {$gt: 3}}},
  {$lookup: {from: "businesses", localField: "_id", foreignField: "business_id", as: "firma"}},
  {$unwind: "$firma"},
  {$project: {_id: 0, "firma.name": 1, srednia: {$round: ["$srednia", 2]}}}
]).sort({"firma.name": 1})


```

# Zadanie 2 - modelowanie danych


Zaproponuj strukturę bazy danych dla wybranego/przykładowego zagadnienia/problemu

Należy wybrać jedno zagadnienie/problem (A lub B)

Przykład A
- Wykładowcy, przedmioty, studenci, oceny
	- Wykładowcy prowadzą zajęcia z poszczególnych przedmiotów
	- Studenci uczęszczają na zajęcia
	- Wykładowcy wystawiają oceny studentom
	- Studenci oceniają zajęcia

Przykład B
- Firmy, wycieczki, osoby
	- Firmy organizują wycieczki
	- Osoby rezerwują miejsca/wykupują bilety
	- Osoby oceniają wycieczki

a) Warto zaproponować/rozważyć różne warianty struktury bazy danych i dokumentów w poszczególnych kolekcjach oraz przeprowadzić dyskusję każdego wariantu (wskazać wady i zalety każdego z wariantów)

b) Kolekcje należy wypełnić przykładowymi danymi

c) W kontekście zaprezentowania wad/zalet należy zaprezentować kilka przykładów/zapytań/zadań/operacji oraz dla których dedykowany jest dany wariantów

W sprawozdaniu należy zamieścić przykładowe dokumenty w formacie JSON ( pkt a) i b)), oraz kod zapytań/operacji (pkt c)), wraz z odpowiednim komentarzem opisującym strukturę dokumentów oraz polecenia ilustrujące wykonanie przykładowych operacji na danych

Do sprawozdania należy kompletny zrzut wykonanych/przygotowanych baz danych (taki zrzut można wykonać np. za pomocą poleceń `mongoexport`, `mongdump` …) oraz plik z kodem operacji zapytań (załącznik powinien mieć format zip).


## Zadanie 2  - rozwiązanie

> Wyniki: 
> 
> przykłady, kod, zrzuty ekranów, komentarz ...

### Wyróżniamy dwa sposoby modelowania danych: tabelaryczny i dokumentowy (zagnieżdżanie)

### Podejście tabelaryczne:
- Zalety:
  1. Porządkowanie dokumentów w przejrzysty sposób (grupowanie w kolekcje odpowiadające kategoriom dokumentów)
  2. Szybsze aktualizowanie danych w dokumentach (szczególnie gdy częściej zapisujemy dane niż odczytujemy)
  3. Zwiększona wydajność podczas zapytań do każdego dokumentu z osobna
  4. Mniejszy rozmiar dokumentów
- Wady: 
  1. Konieczność łączenia dokumentów z różnych kolekcji gdy potrzebujemy dokumentu wraz z danymi do których referencje dany dokument posiada
  2. Konieczność tworzenia złożonych zapytań
  3. Dłuższy czas odczytu dokumentu wymagającego złączenia dokumentów z kilku kolekcji

### Podejście dokumentowe (zagnieżdżanie):
- Zalety:
  1. Optymalizacja wydajności: Gdy potrzebujemy dostępu do całego dokumentu wraz z zagnieżdżonymi dokumentami, zagnieżdżanie pozwala na szybsze pobranie danych. Wystarczy jedno zapytanie, bez konieczności łączenia dokumentów z różnych kolekcji.
  2. Prostsze definiowanie relacji: Zagnieżdżanie dokumentów ułatwia definiowanie relacji między nimi.
  3. Szybki odczyt danych: Jeżeli operacje odczytu są częstsze niż zapisu, zagnieżdżanie może przyspieszyć odczyt danych o całym dokumencie.
- Wady:
  1. Ograniczenia w tworzeniu zapytań: Nie ma możliwości tworzenia zapytań, które bezpośrednio dotyczą zagnieżdżonych dokumentów. Trzeba „dostać się” do nich poprzez dokument, w którym są zagnieżdżone.
  2. Złożoność zapytań: Gdy potrzebujemy odwołać się do głęboko zagnieżdżonego dokumentu, zapytania stają się bardziej skomplikowane.
  3. Aktualizacje mogą być czasochłonne: Aktualizacje dokumentów są bardziej długotrwałe i skomplikowane niż w podejściu tabelarycznym. Wymagane jest przejście przez kolejno zagnieżdżone dokumenty.

### Wypełnienie kolekcji przykładowymi danymi

```js
db.companies.insertMany([
  {
    _id: new ObjectId("6263e1123ca1655ba6a4dd8f"),
    name: "Itaka",
    tours: [
      new ObjectId("5c88fa8cf4afda39709c2955"),
      new ObjectId("5c88fa8cf4afda39709c295d")
    ]
  },
  {
    _id: new ObjectId("6263e1123ca1655ba6a4dd90"),
    name: "Rainbow",
    tours: [
      new ObjectId("5c88fa8cf4afda39709c295a")
    ]
  }
])

db.people.insertMany([
  {
    _id: new ObjectId("5c8a22c62f8fb814b56fa18b"),
    name: "Dawid Luna",
    email: "luna@example.com",
    role: "lead-guide",
    active: true
  },
  {
    _id: new ObjectId("5c8a1f4e2f8fb814b56fa185"),
    name: "Womon Szyziak",
    email: "womziak@example.com",
    role: "guide",
    active: true
  },
  {
    _id: new ObjectId("5c8a21d02f8fb814b56fa189"),
    name: "Mariano Italiano",
    email: "mariano@example.com",
    role: "lead-guide",
    active: true
  },
  {
    _id: new ObjectId("5c8a23412f8fb814b56fa18c"),
    name: "Don Karlitto",
    email: "karlitto@example.com",
    role: "guide",
    active: true
  },
  {
    _id: new ObjectId("5c8a1dfa2f8fb814b56fa181"),
    name: "Adam Burger",
    email: "zyd@example.com",
    role: "user",
    active: true
  },
  {
    _id: new ObjectId("5c8a1e1a2f8fb814b56fa182"),
    name: "Cycylia Dupodajska",
    email: "dupodajska@example.com",
    role: "user",
    active: true
  },
  {
    _id: new ObjectId("5c8a1ec62f8fb814b56fa183"),
    name: "Adam Behan",
    email: "abechan@example.com",
    role: "user",
    active: true
  },
  {
    _id: new ObjectId("5c8a211f2f8fb814b56fa188"),
    name: "Patryk Vega",
    email: "vega@example.com",
    role: "user",
    active: true
  },
  {
    _id: new ObjectId("5c8a20d32f8fb814b56fa187"),
    name: "Riley Raid",
    email: "raid@example.com",
    role: "user",
    active: true
  },
  {
    _id: new ObjectId("5c8a201e2f8fb814b56fa186"),
    name: "Johny Sins",
    email: "fireman@example.com",
    role: "guide",
    active: true
  },
  {
    _id: new ObjectId("5c8a23c82f8fb814b56fa18d"),
    name: "Lana Rhodes",
    email: "anal@example.com",
    role: "user",
    active: true
  },
  {
    _id: new ObjectId("5c8a23de2f8fb814b56fa18e"),
    name: "Eva Elfie",
    email: "elfie@example.com",
    role: "user",
    active: true
  },
  {
    _id: new ObjectId("5c8a24282f8fb814b56fa18f"),
    name: "Abella Danger",
    email: "abella@example.com",
    role: "user",
    active: true
  },
  {
    _id: new ObjectId("5c8a245f2f8fb814b56fa191"),
    name: "Mia Malkova",
    email: "mia@example.com",
    role: "user",
    active: true
  },
  {
    _id: new ObjectId("5c8a24822f8fb814b56fa192"),
    name: "Anakin Skywalker",
    email: "anakin@example.com",
    role: "user",
    active: true
  }
])


db.reviews.insertMany([
  {
    _id: new ObjectId("5c8a34ed14eb5c17645c9108"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a1dfa2f8fb814b56fa181"),
    tour: new ObjectId("5c88fa8cf4afda39709c2955")
  },
  {
    _id: new ObjectId("5c8a355b14eb5c17645c9109"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 4,
    user: new ObjectId("5c8a1dfa2f8fb814b56fa181"),
    tour: new ObjectId("5c88fa8cf4afda39709c295a")
  },
  {
    _id: new ObjectId("5c8a359914eb5c17645c910a"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a1dfa2f8fb814b56fa181"),
    tour: new ObjectId("5c88fa8cf4afda39709c295d")
  },
  {
    _id: new ObjectId("5c8a36b714eb5c17645c910f"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 4,
    user: new ObjectId("5c8a1e1a2f8fb814b56fa182"),
    tour: new ObjectId("5c88fa8cf4afda39709c2955")
  },
  {
    _id: new ObjectId("5c8a37b114eb5c17645c9111"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 4,
    user: new ObjectId("5c8a24402f8fb814b56fa190"),
    tour: new ObjectId("5c88fa8cf4afda39709c295a")
  },
  {
    _id: new ObjectId("5c8a382d14eb5c17645c9116"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a1ec62f8fb814b56fa183"),
    tour: new ObjectId("5c88fa8cf4afda39709c295a")
  },
  {
    _id: new ObjectId("5c8a385614eb5c17645c9118"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a1ec62f8fb814b56fa183"),
    tour: new ObjectId("5c88fa8cf4afda39709c295d")
  },
  {
    _id: new ObjectId("5c8a38ed14eb5c17645c911d"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a211f2f8fb814b56fa188"),
    tour: new ObjectId("5c88fa8cf4afda39709c295d")
  },
  {
    _id: new ObjectId("5c8a391f14eb5c17645c911f"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a211f2f8fb814b56fa188"),
    tour: new ObjectId("5c88fa8cf4afda39709c2955")
  },
  {
    _id: new ObjectId("5c8a399014eb5c17645c9121"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 4,
    user: new ObjectId("5c8a20d32f8fb814b56fa187"),
    tour: new ObjectId("5c88fa8cf4afda39709c295d")
  },
  {
    _id: new ObjectId("5c8a3a7014eb5c17645c9124"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a23c82f8fb814b56fa18d"),
    tour: new ObjectId("5c88fa8cf4afda39709c2955")
  },
  {
    _id: new ObjectId("5c8a3a9914eb5c17645c9126"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a23c82f8fb814b56fa18d"),
    tour: new ObjectId("5c88fa8cf4afda39709c295a")
  },
  {
    _id: new ObjectId("5c8a3b7c14eb5c17645c912f"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a23de2f8fb814b56fa18e"),
    tour: new ObjectId("5c88fa8cf4afda39709c2955")
  },
  {
    _id: new ObjectId("5c8a3b9f14eb5c17645c9130"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a24282f8fb814b56fa18f"),
    tour: new ObjectId("5c88fa8cf4afda39709c295a")
  },
  {
    _id: new ObjectId("5c8a3c3b14eb5c17645c9135"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 4,
    user: new ObjectId("5c8a245f2f8fb814b56fa191"),
    tour: new ObjectId("5c88fa8cf4afda39709c295a")
  },
  {
    _id: new ObjectId("5c8a3c6814eb5c17645c9137"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 4,
    user: new ObjectId("5c8a245f2f8fb814b56fa191"),
    tour: new ObjectId("5c88fa8cf4afda39709c295d")
  },
  {
    _id: new ObjectId("5c8a3cdc14eb5c17645c913b"),
    review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eget leo a nisi auctor semper non eu felis. Morbi nec rhoncus dui.",
    rating: 5,
    user: new ObjectId("5c8a24822f8fb814b56fa192"),
    tour: new ObjectId("5c88fa8cf4afda39709c2955")
  }
])

db.tours.insertMany([
  {
    _id: new ObjectId("5c88fa8cf4afda39709c2955"),
    company: new ObjectId("6263e1123ca1655ba6a4dd8f"),
    name: "Mountains Hiking",
    duration: 4,
    maxGroupSize: 10,
    difficulty: "difficult",
    ratingsAverage: 4.83,
    ratingsQuantity: 6,
    price: 999,
    summary: "Extreme mountain climbing with magnificent views and loads of adrenaline",
    description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolorem qui dolore earum sed quo obcaecati enim unde tenetur, odio dolor dignissimos vitae labore et iste dolores nesciunt debitis aperiam assumenda aut voluptatem reprehenderit blanditiis libero? Veritatis, ullam. Dolorem facere nobis cupiditate, eveniet voluptatum voluptates minus libero iusto placeat, reiciendis odio!",
    createdAt: ISODate("2024-04-26T01:03:28.180Z"),
    startDates: [
      ISODate("2024-12-12T12:35:03.795Z"),
      ISODate("2024-12-28T05:52:32.724Z")
    ],
    locations: [
      {
        description: "Aspen Highlands",
        day: 1
      },
      {
        description: "Beaver Creek",
        day: 3
      }
    ],
    guides: [
      new ObjectId("5c8a22c62f8fb814b56fa18b"),
      new ObjectId("5c8a1f4e2f8fb814b56fa185")
    ]
  },

  {
    _id: new ObjectId("5c88fa8cf4afda39709c295a"),
    company: new ObjectId("6263e1123ca1655ba6a4dd90"),
    name: "Pleasurable Sunbathing",
    duration: 10,
    maxGroupSize: 30,
    difficulty: "easy",
    ratingsAverage: 4.5,
    ratingsQuantity: 6,
    price: 499,
    summary: "Have a rest in the sunlight",
    description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolorem qui dolore earum sed quo obcaecati enim unde tenetur, odio dolor dignissimos vitae labore et iste dolores nesciunt debitis aperiam assumenda aut voluptatem reprehenderit blanditiis libero? Veritatis, ullam. Dolorem facere nobis cupiditate, eveniet voluptatum voluptates minus libero iusto placeat, reiciendis odio!",
    createdAt: ISODate("2022-02-24T01:03:28.180Z"),
    startDates: [
      ISODate("2024-06-11T12:35:03.795Z"),
      ISODate("2024-07-21T05:52:32.724Z")
    ],
    locations: [
      {
        description: "Lummus Park Beach",
        day: 1
      },
      {
        description: "Islamorada",
        day: 2
      },
      {
        description: "Sombrero Beach",
        day: 3
      },
      {
        description: "West Key",
        day: 5
      }
    ],
    guides: [
      new ObjectId("5c8a21d02f8fb814b56fa189")
    ]
  },

  {
    _id: new ObjectId("5c88fa8cf4afda39709c295d"),
    company: new ObjectId("6263e1123ca1655ba6a4dd8f"),
    name: "Under the sea",
    duration: 3,
    maxGroupSize: 8,
    difficulty: "medium",
    ratingsAverage: 4.6,
    ratingsQuantity: 5,
    price: 1499,
    summary: "An underwater adventure full of attractions such as swimming in the azure water between a coral reef and marine life",
    description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolorem qui dolore earum sed quo obcaecati enim unde tenetur, odio dolor dignissimos vitae labore et iste dolores nesciunt debitis aperiam assumenda aut voluptatem reprehenderit blanditiis libero? Veritatis, ullam. Dolorem facere nobis cupiditate, eveniet voluptatum voluptates minus libero iusto placeat, reiciendis odio!",
    createdAt: ISODate("2024-04-26T11:03:28.180Z"),
    startDates: [
      ISODate("2024-05-14T12:35:03.795Z"),
      ISODate("2024-07-18T05:52:32.724Z")
    ],
    locations: [
      {
        description: "Islamorada",
        day: 2
      },
      {
        description: "Sombrero Beach",
        day: 3
      }
    ],
    guides: [
      new ObjectId("5c8a21d02f8fb814b56fa189"),
      new ObjectId("5c8a23412f8fb814b56fa18c")
    ]
  }
])
```

### Przykładowe użycie podejścia tabelarycznego

W zamieszczonym niżej fragmencie dokumentu, widzimy, że atrybuty `company` oraz `guides` zawierają referencje do innych dokumentów w bazie danych. Firma (`company`), a także każdy z przewodników (`guides`) jest osobnym dokumentem w odpowiedniej kolekcji (`companies` lub `people`), a taki podział przypomina rozmieszczenie danych podobne do grupowania danych w tabele.

```json
{
  "_id": {
    "$oid": "5c88fa8cf4afda39709c295a"
  },
  "company": {
    "$oid": "6263e1123ca1655ba6a4dd90"
  },
  ...
  "guides": [
    {
      "$oid": "5c8a21d02f8fb814b56fa189"
    }
  ]
}
```

### Przykładowe użycie podejścia dokumentowego (zagnieżdżanie)
Poniższy fragment dokumentu, przechowującego dane jednej z wycieczek, prezentuje podejście dokumentowe. Widzimy, że do atrybutów `startDates` i `locations` przypisane są listy obiektów.

```json
{
  "_id": {
    "$oid": "5c88fa8cf4afda39709c295a"
  },
  ...
  "startDates": [
    {
      "$date": "2024-06-11T12:35:03.795Z"
    },
    {
      "$date": "2024-07-21T05:52:32.724Z"
    }
  ],
  "locations": [
    {
      "description": "Lummus Park Beach",
      "day": 1
    },
    {
      "description": "Islamorada",
      "day": 2
    },
    {
      "description": "Sombrero Beach",
      "day": 3
    },
    {
      "description": "West Key",
      "day": 5
    }
  ],
  ...
}
```

### Przykładowe operacje na danych

1. Pobieranie listy uczestników który wystawili recenzje wycieczek według ilości wystawionych opinii (malejąco)
```js
db.reviews.aggregate([
  {
    $group: {
      _id: "$user",
      count: { $sum: 1 }
    }
  },
  {
    $sort: { count: -1 }
  }
])
```
wynik:
```js
...
{
  _id: ObjectId('5c8a23c82f8fb814b56fa18d'),
  count: 2
}
...
```

2. Lista wycieczek które zaczynają się w wakacje roku 2024 (od początku lipca do końca sierpnia)
```js
db.tours.aggregate([
  {
    $match: {
      startDates: {
        $gte: new Date('2024-07-01'),
        $lte: new Date('2024-08-31')
      }
    }
  },
  {
    $project: {
      name: 1,
      startDates: 1
    }
  }
])
```
wynik:
```js
{
  _id: ObjectId('5c88fa8cf4afda39709c295a'),
  name: 'Pleasurable Sunbathing',
  startDates: [
    2024-06-11T12:35:03.795Z,
    2024-07-21T05:52:32.724Z
  ]
}
{
  _id: ObjectId('5c88fa8cf4afda39709c295d'),
  name: 'Under the sea',
  startDates: [
    2024-05-14T12:35:03.795Z,
    2024-07-18T05:52:32.724Z
  ]
}
```

3. Statystyka o wycieczkach które mają średnią ocenę większą niż 4.5 zawierająca ilość takich wycieczek, ilość ocen, średnią ocenę, cenę średnią, minimalną i maksymalną
```js
db.tours.aggregate([
  { $match: { ratingsAverage: { $gte: 4.5 } } },
  {
    $group: {
      _id: null,
      noTours: { $sum: 1 },
      noRatings: { $sum: '$ratingsQuantity' },
      avgRating: { $avg: '$ratingsAverage' },
      avgPrice: { $avg: '$price' },
      minPrice: { $min: '$price' },
      maxPrice: { $max: '$price' },
    }
  }
])
```
wynik:
```js
{
  _id: null,
  noTours: 3,
  noRatings: 17,
  avgRating: 4.6433333333333335,
  avgPrice: 999,
  minPrice: 499,
  maxPrice: 1499
}
```
---

Punktacja:

|         |     |
| ------- | --- |
| zadanie | pkt |
| 1       | 0,6 |
| 2       | 1,4 |
| razem   | 2   |



