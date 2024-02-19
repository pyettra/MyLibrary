//
//  MyButton.swift
//  MinhaLivraria
//
//  Created by Pyettra Ferreira on 15/02/24.
//

import Foundation
import UIKit

class MyButton: UIButton {
    private var identifier: String
    
    var buttonTappedHandler: ((Bool) -> Void)?
    
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
        self.identifier = UUID().uuidString
        super.init(frame: frame)
        setUpButton()
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.identifier = UUID().uuidString
        super.init(coder: aDecoder)
        setUpButton()
        setUpView()
    }
    
    override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
            saveState()
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
    
    func setUpButton() {
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.borderWidth = 1
        isSelected = UserDefaults.standard.bool(forKey: identifier)
        updateBackgroundColor()
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func saveState() {
        UserDefaults.standard.set(isSelected, forKey: identifier)
    }
    
    func updateBackgroundColor() {
        backgroundColor = isSelected ? .black : .white
        
        iconImageView.tintColor = isSelected ? .white : .black
        textLabel.textColor = isSelected ? .white : .black
        layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.black.cgColor
    }
    
    @objc func buttonTapped() {
        isSelected = !isSelected
        
        buttonTappedHandler?(isSelected)
    }
}
