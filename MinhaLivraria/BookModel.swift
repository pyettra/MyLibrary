//
//  BookModel.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 15/02/24.
//

import Foundation

struct BookList: Decodable {
    let books: [BookModel]
}

struct BookModel: Decodable {
    let bookName: String
    let bookId: Int
    let isRead: Int
    let isWishlist: Int
    let authorId: Int
    let description: String
    let image: String
}
