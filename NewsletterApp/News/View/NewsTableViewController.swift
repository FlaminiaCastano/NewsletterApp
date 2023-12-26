//
//  NewsTableViewController.swift
//  NewsletterApp
//
//  Created by Flaminia Castaño on 26/12/2023.
//

import UIKit

final class NewsTableViewController: UIViewController {
    
    var newsNotes: NewsModel = []
    let newsViewModel = NewsViewModel()
    
    private let newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        customizeConstraints()
        
        Task {
            do {
                try await fetchNews()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.newsTableView.reloadData()
                }
            } catch {
                print("Error fetching news: \(error)")
            }
        }
    }
    
    func customizeView() {
        view.addSubview(newsTableView)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        
        newsTableView.backgroundColor = .white
        newsTableView.separatorStyle = .singleLine
    }
    
    func customizeConstraints() {
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchNews() async throws {
           let url = URL(string: "https://jsonplaceholder.org/posts")!
           let (data, _) = try await URLSession.shared.data(from: url)
           newsNotes = try JSONDecoder().decode(NewsModel.self, from: data)
    }
}

extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsNotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as! NewsTableViewCell

        let newsItem = newsNotes[indexPath.row]
        cell.configure(with: newsItem)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
