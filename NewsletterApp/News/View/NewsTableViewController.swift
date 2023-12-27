//
//  NewsTableViewController.swift
//  NewsletterApp
//
//  Created by Flaminia Castaño on 26/12/2023.
//

import UIKit

final class NewsTableViewController: UIViewController, NewsViewModelDelegate {
    var newsNotes: NewsModel = []
    var filteredNews: NewsModel = []
    let newsViewModel = NewsViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    internal let newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        customizeConstraints()
        customizeSearchController()
        
        Task {
            do {
                try await newsViewModel.fetchNews()
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
        newsViewModel.delegate = self
        
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        
        newsTableView.backgroundColor = .white
        newsTableView.separatorStyle = .singleLine
        self.title = "Lista de Noticias"
    }
    
    func customizeConstraints() {
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func customizeSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search News"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func didFetchNews(data: NewsModel) {
        newsNotes = data
    }
    
    func didFailFetchingNews(_ error: Error) {
        print("Error fetching news: \(error)")
    }
}

extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchBarActive ? filteredNews.count : newsNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as! NewsTableViewCell
        
        let newsItem = isSearchBarActive ? filteredNews[indexPath.row] : newsNotes[indexPath.row]
        cell.configure(with: newsItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    var isSearchBarActive: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = isSearchBarActive ? filteredNews[indexPath.row] : newsNotes[indexPath.row]

        let detailViewController = NewsDetailViewController()
        detailViewController.selectedNews = selectedNews

        navigationController?.pushViewController(detailViewController, animated: true)
    }

}

extension NewsTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredNews = newsNotes.filter { $0.title.lowercased().contains(searchText.lowercased()) || $0.content.lowercased().contains(searchText.lowercased()) }
        } else {
            filteredNews = []
        }

        newsTableView.reloadData()
    }

}
