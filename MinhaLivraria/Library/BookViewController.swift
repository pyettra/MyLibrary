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
    private var interactor: BookInteractor = BookInteractor()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var isWishlistButton: MyButton = {
        let button = MyButton()
        button.addTarget(self, action: #selector(didTapWishlistButton), for: .touchUpInside)
        button.configure(image: UIImage(named: "bookmark_black"), text: "quero ler")
        return button
    }()
    
    private lazy var isReadButton: MyButton = {
        let button = MyButton()
        button.buttonTappedHandler = { isSelected in
            print("estado do botao: \(isSelected)")
            self.didTapReadButton()
        }
//        button.addTarget(self, action: #selector(didTapReadButton), for: .touchUpInside)
        button.configure(image: UIImage(named: "favorite_black"), text: "lido")
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var bookNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier", size: 22)
        return label
    }()
    
    private lazy var authorName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier", size: 18)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier", size: 15)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.configure(with: self.book)
        self.view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
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
        authorName.text = model.author?.authorName
        
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
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(buttonStackView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
            
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        buttonStackView.addArrangedSubview(isWishlistButton)
        buttonStackView.addArrangedSubview(isReadButton)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 280),
            buttonStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 14)
        ])
        
        stackView.addArrangedSubview(bookNameLabel)
        stackView.addArrangedSubview(authorName)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 14),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    @objc func didTapWishlistButton() {
        if BookLists.shared.isInWishList(book: book) {
            BookLists.shared.removeFromWishList(book: book)
            interactor.updateWishList(book: book, value: 0)
        } else {
            BookLists.shared.addToWishList(book: book)
            interactor.updateWishList(book: book, value: 1)
        }
    }
    
    func didTapReadButton() {
        if BookLists.shared.isInAlreadyRead(book: book) {
            BookLists.shared.removeFromAlreadyRead(book: book)
            interactor.updateReadList(book: book, value: 0)
        } else {
            BookLists.shared.addToAlreadyRead(book: book)
            interactor.updateReadList(book: book, value: 1)
        }
    }
}
