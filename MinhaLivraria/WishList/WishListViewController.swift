//
//  WishListViewController.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 17/02/24.
//

import Foundation
import UIKit

protocol WishListViewControllerDisplaying {
    func displayList(bookList: [BookModel])
}

class WishListViewController: UIViewController {
    private var interactor: WishListInteracting
    private var bookList: [BookModel] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Quero Ler"
        label.font = UIFont(name: "Courier", size: 30)
        label.textColor = .black
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(BookCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "First"
        let image = UIImage(named: "favorite_black")
        tabBarItem = UITabBarItem(title: "", image: image, selectedImage: image)
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.bookList = interactor.getWishList()
        setUpView()
    }
    
    init(interactor: WishListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WishListViewController: WishListViewControllerDisplaying {
    func displayList(bookList: [BookModel]) {
        self.bookList = bookList
    }
}

private extension WishListViewController {
    func setUpView() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
}

extension WishListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let book = bookList[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BookCollectionCell else { return UICollectionViewCell() }
        cell.configure(with: book)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookVC = BookViewController(book: bookList[indexPath.row])
        navigationController?.pushViewController(bookVC, animated: true)
    }
}

