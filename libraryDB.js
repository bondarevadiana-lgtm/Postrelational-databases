use('LibraryDB');

db.items.insertMany([
  { "_id": 1, "type": "Book", "title": "The Witcher", "author": "Sapkowski", "year": 1992, "pages": 300 },
  { "_id": 2, "type": "Book", "title": "Dune", "author": "Herbert", "year": 1965, "pages": 500 },
  { "_id": 3, "type": "Magazine", "title": "National Geographic", "issue": 105, "year": 2023 },
  { "_id": 4, "type": "Magazine", "title": "Science Today", "issue": 12, "year": 2024 }
]);

db.members.insertMany([
  { "_id": 101, "name": "Ivan Mazepa", "registered": "2023-01-15", "borrowed_ids": [1, 3] },
  { "_id": 102, "name": "Anna Frank", "registered": "2024-02-10", "borrowed_ids": [2] },
  { "_id": 103, "name": "Petro Mohyla", "registered": "2022-11-20", "borrowed_ids": [] },
  { "_id": 104, "name": "Lesya Ukrainka", "registered": "2023-12-05", "borrowed_ids": [4] }
]);