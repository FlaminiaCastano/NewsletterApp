//
//  UsersTableViewController.swift
//  NewsletterApp
//
//  Created by Flaminia Castaño on 27/12/2023.
//

import UIKit

final class UsersTableViewController: UIViewController, UsersViewModelDelegate {
    var users: Users = []
    var usersViewModel = UserViewModel()
    
    internal let usersTableView: UITableView = {
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
                try await usersViewModel.fetchUsers()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.usersTableView.reloadData()
                }
            } catch {
                print("Error fetching users: \(error)")
            }
        }
    }
    
    func customizeView() {
        view.addSubview(usersTableView)
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersViewModel.delegate = self
        
        usersTableView.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.reuseIdentifier)
        
        usersTableView.backgroundColor = .white
        usersTableView.separatorStyle = .singleLine
        self.title = "Lista de Usuarios"
    }
    
    func customizeConstraints() {
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: view.topAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func didFetchUsers(data: Users) {
        users = data
    }
        
    func didFailFetchingUsers(_ error: Error) {
        print("Error fetching news: \(error)")
    }
}

extension UsersTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.reuseIdentifier, for: indexPath) as! UsersTableViewCell
        
        let users = users[indexPath.row]
        cell.configure(with: users)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        openGoogleMapsWithUserAddress(user: selectedUser)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    internal func openGoogleMapsWithUserAddress(user: User) {
        let address = "\(user.address.street), \(user.address.city.rawValue), \(user.address.zipcode.rawValue)"
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let googleMapsURLString = "comgooglemaps://?q=\(encodedAddress)"

        if let googleMapsURL = URL(string: googleMapsURLString), UIApplication.shared.canOpenURL(googleMapsURL) {
            UIApplication.shared.open(googleMapsURL, options: [:], completionHandler: nil)
        } else {
            let googleMapsWebURLString = "https://www.google.com/maps?q=\(encodedAddress)"
            if let googleMapsWebURL = URL(string: googleMapsWebURLString) {
                UIApplication.shared.open(googleMapsWebURL, options: [:], completionHandler: nil)
            }
        }
    }

}
