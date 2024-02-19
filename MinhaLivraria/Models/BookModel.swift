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

struct BookModel: Decodable, Equatable {
    let bookName: String
    let bookId: Int
    let isRead: Int
    let isWishlist: Int
    let author: AuthorModel?
    let description: String
    let image: String
}
