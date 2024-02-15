//
//  Interactor.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 12/02/24.
//

import Foundation
import SQLite3
import SQLite

protocol Interacting {
    func openDatabase() -> [BookModel]
}

final class Interactor: Interacting {
    private var presenter: Presenting
    
    init(presenter: Presenting) {
        self.presenter = presenter
    }
    
    func openDatabase() -> [BookModel] {
        var models = [BookModel]()
        
        var db: OpaquePointer? = nil
        let fileURL = Bundle.main.url(forResource: "LibraryDataBase", withExtension: "")

        guard let path = fileURL?.path else {
            print("Database file not found in bundle.")
            return []
        }

        if sqlite3_open(path, &db) == SQLITE_OK {
            let query = "SELECT book_id, book_name, is_read, is_wishlist, author_id, description, image FROM books"
            var statement: OpaquePointer?

            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                while sqlite3_step(statement) == SQLITE_ROW {
                    let id = Int(sqlite3_column_int(statement, 0))
                    let name = String(cString: sqlite3_column_text(statement, 1))
                    let isRead = Int(sqlite3_column_int(statement, 2))
                    let isWishList = Int(sqlite3_column_int(statement, 3))
                    let authorId = Int(sqlite3_column_int(statement, 4))
                    let description = String(cString: sqlite3_column_text(statement, 5))
                    let image = String(cString: sqlite3_column_text(statement, 6))

                    let model = BookModel(
                        bookName: name,
                        bookId: id,
                        isRead: isRead,
                        isWishlist: isWishList,
                        authorId: authorId,
                        description: description,
                        image: image
                    )
                    models.append(model)
                }
            } else {
                print("Error preparing query: \(String(cString: sqlite3_errmsg(db)))")
            }
            sqlite3_finalize(statement)
        } else {
            print("Unable to open database. Verify that the file exists at the specified path.")
            return []
        }
        sqlite3_close(db)
        
        print(models)
        presenter.presentList(books: models)
        return models
    }
}
