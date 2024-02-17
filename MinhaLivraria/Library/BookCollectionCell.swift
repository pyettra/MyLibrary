//
//  LivroCollectionCell.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 12/02/24.
//

import Foundation
import UIKit

final class BookCollectionCell: UICollectionViewCell {
    private lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Image")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with book: BookModel) {
        ImageLoader.shared.load(with: book.image) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.bookImage.image = result
            }
        }
    }
}

private extension BookCollectionCell {
    func setUpView() {
        addSubview(bookImage)
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        
        let livroImagemConstraints = [
            bookImage.topAnchor.constraint(equalTo: self.topAnchor),
            bookImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bookImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bookImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(livroImagemConstraints)
        
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
        
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
    }
}
