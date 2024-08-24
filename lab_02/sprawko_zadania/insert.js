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