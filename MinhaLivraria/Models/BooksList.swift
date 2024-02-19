//
//  BooksList.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 18/02/24.
//

import Foundation

class BookLists {
    static let shared = BookLists()
    
    var alreadyRead: [BookModel] = []
    var wishList: [BookModel] = []
    
    func isInWishList(book: BookModel) -> Bool {
        return wishList.contains(book)
    }
    
    func isInAlreadyRead(book: BookModel) -> Bool {
        return alreadyRead.contains(book)
    }
    
    func addToAlreadyRead(book: BookModel) {
        alreadyRead.append(book)
    }
    
    func addToWishList(book: BookModel) {
        wishList.append(book)
    }
    
    func removeFromWishList(book: BookModel) {
        if let index = wishList.firstIndex(of: book) {
            wishList.remove(at: index)
        }
    }
    
    func removeFromAlreadyRead(book: BookModel) {
        if let index = alreadyRead.firstIndex(of: book) {
            alreadyRead.remove(at: index)
        }
    }
}
