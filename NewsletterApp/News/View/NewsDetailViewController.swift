//
//  NewsDetailViewController.swift
//  NewsletterApp
//
//  Created by Flaminia Castaño on 26/12/2023.
//

import UIKit

final class NewsDetailViewController: UIViewController {
    var selectedNews: NewModel?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    private var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    private var publishedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        customizeConstraints()
        
        if let newDetail = selectedNews {
            customizeViewWithViewModel(viewModel: newDetail)
        }
    }
    
    private func customizeView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(thumbnailImageView)
        contentStack.addArrangedSubview(contentLabel)
        contentStack.addArrangedSubview(publishedAtLabel)
        self.title = "Detalle de Noticia"
    }
    
    private func customizeConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentStack.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -10),
            thumbnailImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 5),
            contentLabel.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -10),
            contentLabel.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 10),
            publishedAtLabel.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 20)
        ])
    }
    
    internal func customizeViewWithViewModel(viewModel: NewModel) {
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.content
        publishedAtLabel.text = "Fecha de publicación: \(viewModel.publishedAt)"
        
        if let url = URL(string: viewModel.thumbnail) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
