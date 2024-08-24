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