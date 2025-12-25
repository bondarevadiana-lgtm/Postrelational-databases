package com.library;

import com.mongodb.client.*;
import com.mongodb.client.model.*;
import org.bson.Document;
import java.util.Arrays;

public class App {
    public static void main(String[] args) {
     
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
            MongoDatabase database = mongoClient.getDatabase("LibraryDB");
            MongoCollection<Document> items = database.getCollection("items");
            MongoCollection<Document> members = database.getCollection("members");

            System.out.println("=== Всі документи в системі ===");
            for (Document doc : items.find()) {
                System.out.println(doc.toJson());
            }


            System.out.println("\n=== Фільтр: Книги після 1990 року ===");
            Document query = new Document("type", "Book")
                                .append("year", new Document("$gt", 1990));
            items.find(query).forEach(doc -> System.out.println(doc.getString("title")));

  
            System.out.println("\n=== Агрегація: Статистика запозичень ===");
            members.aggregate(Arrays.asList(
                Aggregates.match(Filters.exists("borrowed_ids.0")), // 1. Match: Тільки ті, хто має книги
                Aggregates.lookup("items", "borrowed_ids", "_id", "books"), // 2. Lookup: Join з предметами
                Aggregates.unwind("$books"), // 3. Unwind: Розгортання масиву книг
                Aggregates.group("$name", Accumulators.sum("totalPages", "$books.pages")) // 4. Group: Сума сторінок за ім'ям
            )).forEach(doc -> System.out.println(doc.toJson()));
        }
    }
}