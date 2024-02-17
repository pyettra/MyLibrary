//
//  BookInteractor.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 16/02/24.
//

import Foundation
import SQLite3

protocol BookInteracting {
    func updateWishlist(book: BookModel)
    func updateReadList(book: BookModel)
}

final class BookInteractor: BookInteracting {
    func updateWishlist(book: BookModel) {
        var db: OpaquePointer? = nil
        let fileURL = Bundle.main.url(forResource: "LibraryDataBase", withExtension: "")
        
        print("valor antes: \(book.bookId) é \(book.isRead)")
        // Assuming you have a SQLite database connection named `db`
        guard let path = fileURL?.path else {
            print("Database file not found in bundle.")
            return
        }
        
        if sqlite3_open(path, &db) == SQLITE_OK {
            let query = "UPDATE books SET is_wishlist = \(2) WHERE book_id = \(book.bookId)"
            var statement: OpaquePointer?
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            
            
            // Prepare the query
            guard sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK else {
                print("Error preparing query:", String(cString: sqlite3_errmsg(db)))
                sqlite3_close(db)
                return
            }

            // Bind the new values for the columns
            guard sqlite3_bind_int(statement, 0, Int32(book.bookId)) == SQLITE_OK &&
                    sqlite3_bind_int(statement, 3, Int32(book.isWishlist)) == SQLITE_OK else {
                print("Error binding parameters:", String(cString: sqlite3_errmsg(db)))
                sqlite3_finalize(statement)
                sqlite3_close(db)
                return
            }

            // Execute the statement
            guard sqlite3_step(statement) == SQLITE_DONE else {
                print("Error updating row:", String(cString: sqlite3_errmsg(db)))
                sqlite3_finalize(statement)
                sqlite3_close(db)
                return
            }
            print("valor depois: \(book.bookId) é \(book.isRead)")
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        
        // Finalize the statement and close the database connection

        print("Row updated successfully")
    }
    
    func updateReadList(book: BookModel) {
        var db: OpaquePointer? = nil
        let fileURL = Bundle.main.url(forResource: "LibraryDataBase", withExtension: "")
        
        print("valor antes: \(book.bookId) é \(book.isRead)")

        guard let path = fileURL?.path else {
            print("Database file not found in bundle.")
            return
        }
        
        if sqlite3_open(path, &db) == SQLITE_OK {
            let updateStatementString = "UPDATE books SET is_read = \(3) WHERE book_id = \(book.bookId)"
            var updateStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
                if sqlite3_step(updateStatement) == SQLITE_DONE {
                    print("Successfully updated row.")
                    print("valor depois: \(book.bookId) é \(book.isRead)")
                } else {
                    print("Could not update row.")
                }
            } else {
                print("UPDATE statement could not be prepared")
            }
            sqlite3_finalize(updateStatement)
        }
        sqlite3_close(db)
    }
}
