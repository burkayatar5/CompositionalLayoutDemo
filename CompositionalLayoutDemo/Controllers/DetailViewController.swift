//
//  DetailViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Burkay Atar on 20.05.2024.
//

import UIKit
// - TODO: - Consider implementing a tab bar button, a menu with add, delete etc. -
class DetailViewController: UIViewController {

    var titleLabel: UILabel = UILabel()
    var detailLabel: UILabel = UILabel()
    
    let titleText: String
    let detailText: String
    
    init(titleText: String, detailText: String) {
        self.titleText = titleText
        self.detailText = detailText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViews()
        styleViews()
    }
    
    deinit {
        print("---DetailViewController removed from memory successfully.---")
    }
}

extension DetailViewController {
    private func configureViews() {
        func configureTitleLabel() {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(titleLabel)
        }
        
        func configureDetailLabel() {
            detailLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(detailLabel)
        }
        
        func configureConstraints() {
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                titleLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 40),
                titleLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -40),
                titleLabel.heightAnchor.constraint(equalToConstant: 40),
                
                detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                detailLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 10),
                detailLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -10),
                
            ])
        }
        
        configureTitleLabel()
        configureDetailLabel()
        configureConstraints()
        
        /*
         let views: [UIView] = [titleLabel, detailLabel]
         views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
         }
         Also similar logic can be applied to a UIViewController extension for app-wide use.
         */
    }
    
    private func styleViews() {
        func styleTitleLabel() {
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
            titleLabel.textColor = .label
            titleLabel.text = titleText
        }
        
        func styleDetailLabel() {
            detailLabel.textAlignment = .left
            detailLabel.numberOfLines = 0
            detailLabel.font = UIFont.preferredFont(forTextStyle: .body)
            detailLabel.textColor = .secondaryLabel
            detailLabel.text = detailText
        }
        
        styleTitleLabel()
        styleDetailLabel()
    }
}
