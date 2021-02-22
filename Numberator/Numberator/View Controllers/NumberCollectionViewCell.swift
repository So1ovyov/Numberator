//
//  NumberCollectionViewCell.swift
//  Numberator
//
//  Created by Максим Соловьёв on 22.02.2021.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    
    private let numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with number: Decimal, color: UIColor) {
        numberLabel.text = "\(number)"
        contentView.backgroundColor = color
    }
    
    private func setupUI() {
        contentView.addSubview(numberLabel)
        contentView.backgroundColor = .white
        setupNumberLabel()
    }
    
    private func setupNumberLabel() {
        numberLabel.textColor = .black
        numberLabel.textAlignment = .center
        numberLabel.font = .systemFont(ofSize: 45, weight: .light)
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.minimumScaleFactor = 0.1
        numberLabel.numberOfLines = 1
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
