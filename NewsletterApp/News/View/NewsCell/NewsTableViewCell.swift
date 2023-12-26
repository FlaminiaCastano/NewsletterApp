//
//  NewsTableViewCell.swift
//  NewsletterApp
//
//  Created by Flaminia Castaño on 26/12/2023.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsTableViewCell"
    
    lazy var titleAndContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customizeView()
        customizeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customizeView() {
        contentView.addSubview(titleAndContentStackView)
        titleAndContentStackView.addArrangedSubview(titleLabel)
        titleAndContentStackView.addArrangedSubview(contentLabel)
    }
    
    private func customizeConstraints() {
        NSLayoutConstraint.activate([
                titleAndContentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                titleAndContentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleAndContentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                titleAndContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                
                titleLabel.topAnchor.constraint(equalTo: titleAndContentStackView.topAnchor, constant: 8),
                titleLabel.leadingAnchor.constraint(equalTo: titleAndContentStackView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: titleAndContentStackView.trailingAnchor, constant: -16),
                
                contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                contentLabel.leadingAnchor.constraint(equalTo: titleAndContentStackView.leadingAnchor, constant: 16),
                contentLabel.trailingAnchor.constraint(equalTo: titleAndContentStackView.trailingAnchor, constant: -16),
                contentLabel.bottomAnchor.constraint(equalTo: titleAndContentStackView.bottomAnchor, constant: -8)
            ])
    }


    
    func configure(with viewModel: NewModel) {
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.content
    }
}
