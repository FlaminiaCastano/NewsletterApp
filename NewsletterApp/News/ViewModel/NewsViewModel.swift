//
//  NewsViewModel.swift
//  NewsletterApp
//
//  Created by Flaminia Castaño on 26/12/2023.
//

import Foundation

protocol NewsViewModelDelegate: AnyObject {
    func didFetchNews()
    func didFailFetchingNews(_ error: Error)
}

class NewsViewModel {
    weak var delegate: NewsViewModelDelegate?

    func fetchNews() async throws {
        guard let url = URL(string: "https://jsonplaceholder.org/posts") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            _ = try JSONDecoder().decode([NewsModel].self, from: data)
            delegate?.didFetchNews()
        } catch {
            delegate?.didFailFetchingNews(error)
        }
    }
}
