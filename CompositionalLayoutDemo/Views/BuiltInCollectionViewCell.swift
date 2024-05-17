//
//  BuiltInCollectionViewCell.swift
//  CompositionalLayoutDemo
//
//  Created by Burkay Atar on 2.05.2024.
//

import UIKit

class BuiltInCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: BuiltInCollectionViewCell.self)
    }
    
    lazy var titleLabel: UILabel = UILabel()
    lazy var explanationLabel: UILabel = UILabel()
    
    private let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        let subViews = [titleLabel, explanationLabel]
        
        subViews.forEach { [weak self] in
            self?.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func styleViews() {
        func styleTitleLabel() {
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            //titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
            //titleLabel.backgroundColor = UIColor.clear
            //titleLabel.textColor = .label
            titleLabel.textColor = .systemRed
            titleLabel.backgroundColor = .systemYellow
        }
        
        func styleExplanationLabel() {
            explanationLabel.textAlignment = .center
            explanationLabel.numberOfLines = 0
            //explanationLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            explanationLabel.font = UIFont.preferredFont(forTextStyle: .title2)
            //explanationLabel.backgroundColor = UIColor.clear
            explanationLabel.textColor = .secondaryLabel
            explanationLabel.backgroundColor = .systemBrown
        }
        
        styleTitleLabel()
        styleExplanationLabel()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            explanationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            explanationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            explanationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
        ])
    }
}
