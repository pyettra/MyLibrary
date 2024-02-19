//
//  BookInteractor.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 16/02/24.
//

import Foundation
import SQLite3

protocol BookInteracting {
    func updateWishList(book: BookModel, value: Int)
    func updateReadList(book: BookModel, value: Int)
}

final class BookInteractor: BookInteracting {
    func updateWishList(book: BookModel, value: Int) {
        var db: OpaquePointer? = nil
        let fileURL = Bundle.main.url(forResource: "LibraryDataBase", withExtension: "")
        var statement : OpaquePointer? = nil
        let query = "UPDATE books SET is_wishlist = ? WHERE book_id = ?;"
        
        guard let path = fileURL?.path else { 
            print("Database file not found in bundle.")
            return
        }
        
        if sqlite3_open(path, &db) == SQLITE_OK {
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                sqlite3_bind_int(statement, 1, Int32(value))
                sqlite3_bind_int(statement, 2, Int32(book.bookId))
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data updated success")
                } else {
                    print("Data is not updated in table")
                }
                
                sqlite3_finalize(statement)
            }
        }
    }
    
    func updateReadList(book: BookModel, value: Int) {
        var db: OpaquePointer? = nil
        let fileURL = Bundle.main.url(forResource: "LibraryDataBase", withExtension: "")
        var statement : OpaquePointer? = nil
        let query = "UPDATE books SET is_read = ? WHERE book_id = ?;"

        guard let path = fileURL?.path else {
            print("Database file not found in bundle.")
            return
        }
        
        if sqlite3_open(path, &db) == SQLITE_OK {
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                sqlite3_bind_int(statement, 1, Int32(value))
                sqlite3_bind_int(statement, 2, Int32(book.bookId))
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data updated success")
                } else {
                    print("Data is not updated in table")
                }
                
                sqlite3_finalize(statement)
            }
        }
    }
}
