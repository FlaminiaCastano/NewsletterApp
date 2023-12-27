//
//  UsersTableViewCellTest.swift
//  NewsletterAppTests
//
//  Created by Flaminia Castaño on 27/12/2023.
//

import XCTest
import SnapshotTesting
@testable import NewsletterApp

class UsersTableViewCellTest: XCTestCase {

    func testUserTableViewCell() {
        //isRecording = true
        let cell = UsersTableViewCell(style: .default, reuseIdentifier: UsersTableViewCell.reuseIdentifier)
        let user = createNewModel()
        cell.configure(with: user)
        

        assertSnapshot(matching: cell, as: .image)
    }
    
    func testConfigure() {
        let cell = UsersTableViewCell(style: .default, reuseIdentifier: UsersTableViewCell.reuseIdentifier)
        let user = createNewModel()
        cell.configure(with: user)
        
        XCTAssertEqual(cell.nameLabel.text, "Doe, John")
    }
    
    private func createNewModel() -> User {
        return User(
            id: 1,
            firstname: "John",
            lastname: "Doe",
            email: "johndoe@example.com",
            birthDate: "1973-01-22",
            login: Login(
                uuid: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
                username: "johndoe",
                password: .jsonplaceholderOrg,
                md5: .c1328472C5794A25723600F71C1B4586,
                sha1: .the35544A31Cc19Bd6520Af116554873167117F4D94,
                registered: "2023-01-10T10:03:20.022Z"
            ),
            address: Address(
                street: "123 Main Street",
                suite: "Apt. 4",
                city: .anytown,
                zipcode: .the123456789,
                geo: Geo(lat: "42.1234", lng: "-71.2345")
            ),
            phone: .the5555551234,
            website: "www.johndoe.com",
            company: Company(
                name: "ABC Company",
                catchPhrase: "Innovative solutions for all your needs",
                bs: "Marketing"
            )
        )
    }
}
