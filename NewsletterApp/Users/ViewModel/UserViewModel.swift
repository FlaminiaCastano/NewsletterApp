//
//  UserViewModel.swift
//  NewsletterApp
//
//  Created by Flaminia Castaño on 27/12/2023.
//

import Foundation

protocol UsersViewModelDelegate: AnyObject {
    func didFetchUsers(data: Users)
    func didFailFetchingUsers(_ error: Error)
}

class UserViewModel {
    weak var delegate: UsersViewModelDelegate?

    func fetchUsers() async throws {
        guard let url = URL(string: JsonPlaceHolderRoutes(route: .users).url) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(Users.self, from: data)
            delegate?.didFetchUsers(data: response)
        } catch {
            delegate?.didFailFetchingUsers(error)
        }
    }
}
