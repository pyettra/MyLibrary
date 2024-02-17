//
//  MyButton.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 15/02/24.
//

import Foundation
import UIKit

class MyButton: UIButton {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Courier", size: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.borderWidth = 1
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override var isSelected: Bool {
        didSet {
            let color = isSelected ? UIColor.black : UIColor.white
            let backgroundColor = isSelected ? UIColor.white : UIColor.black
            
            iconImageView.tintColor = color
            textLabel.textColor = color
            layer.borderColor = color.cgColor
            
            self.backgroundColor = backgroundColor
        }
    }
    
    func configure(image: UIImage?, text: String?) {
        iconImageView.image = image
        textLabel.text = text
    }
}

private extension MyButton {
    func setUpView() {
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageConstraints = [
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            iconImageView.heightAnchor.constraint(equalToConstant: 18),
            iconImageView.widthAnchor.constraint(equalToConstant: 18),
            iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(imageConstraints)
        
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let textLabelConstraints = [
            textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(textLabelConstraints)
    }
}
