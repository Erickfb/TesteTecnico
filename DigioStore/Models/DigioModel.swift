//
//  DigioModel.swift
//  DigioStore
//
//  Created by Erick Fernandes Batista on 17/08/24.
//

import Foundation

struct Spotlight: Codable {
    let name: String
    let bannerURL: String
    let description: String
}

struct Product: Codable, Equatable {
    let name: String
    let imageURL: String
    let description: String
}

struct Cash: Codable {
    let title: String
    let bannerURL: String
    let description: String
}

struct DigioStore: Codable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}
