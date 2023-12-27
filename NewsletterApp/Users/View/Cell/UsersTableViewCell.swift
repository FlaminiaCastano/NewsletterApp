//
//  UsersTableViewCell.swift
//  NewsletterApp
//
//  Created by Flaminia Castaño on 27/12/2023.
//

import UIKit

final class UsersTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "UsersTableViewCell"
    
    internal var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
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
        contentView.addSubview(nameLabel)
    }
    
    private func customizeConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            ])
    }


    
    func configure(with viewModel: User) {
        nameLabel.text = "\(viewModel.lastname), \(viewModel.firstname)"
    }
}
