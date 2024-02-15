//
//  BookViewController.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 15/02/24.
//

import Foundation
import UIKit

final class BookViewController: UIViewController {
    private var book: BookModel
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var bookNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.configure(with: self.book)
        self.view.backgroundColor = .white
    }
    
    init(book: BookModel) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: BookModel) {
        bookNameLabel.text = model.bookName
        descriptionLabel.text = model.description
        authorName.text = "teste"
        
        ImageLoader.shared.load(with: model.image) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageView.image = result
            }
        }
    }
    
}

private extension BookViewController {
    func setUpView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
        stackView.addArrangedSubview(bookNameLabel)
        stackView.addArrangedSubview(authorName)
        stackView.addArrangedSubview(descriptionLabel)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewConstraint = [
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 300),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(stackViewConstraint)
    }
}


