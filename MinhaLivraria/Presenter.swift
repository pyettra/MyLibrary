//
//  Presenter.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 15/02/24.
//

import Foundation
protocol Presenting {
    func presentList(books: [BookModel])
}

final class Presenter: Presenting {
    weak var viewController: ViewController?
    
    func presentList(books: [BookModel]) {
        viewController?.displayList(bookList: books)
    }
}
