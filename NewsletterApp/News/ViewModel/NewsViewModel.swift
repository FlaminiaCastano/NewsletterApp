//
//  NewsViewModel.swift
//  NewsletterApp
//
//  Created by Flaminia Castaño on 26/12/2023.
//

import Foundation

protocol NewsViewModelDelegate: AnyObject {
    func didFetchNews(data: NewsModel)
    func didFailFetchingNews(_ error: Error)
}

class NewsViewModel {
    weak var delegate: NewsViewModelDelegate?

    func fetchNews() async throws {
        guard let url = URL(string: JsonPlaceHolderRoutes(route: .news).url) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(NewsModel.self, from: data)
            delegate?.didFetchNews(data: response)
        } catch {
            delegate?.didFailFetchingNews(error)
        }
    }
}
