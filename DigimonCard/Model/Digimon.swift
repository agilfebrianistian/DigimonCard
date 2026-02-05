//
//  Digimon.swift
//  DigimonCard
//
//  Created by Agil Febrianistian on 05/02/26.
//

import Foundation

struct Digimon: Codable {
    let digimonID: Int
    let name: String?
    let images: [Image]?
    let levels: [Level]?
    let types: [TypeElement]?
    let attributes: [Attribute]?
    let fields: [Field]?
    
    enum CodingKeys: String, CodingKey {
        case digimonID = "id"
        case name, images
        case levels
        case types
        case attributes
        case fields
    }
}

struct Attribute: Codable {
    let id: Int?
    let attribute: String?
}

struct Field: Codable {
    let id: Int?
    let field: String?
    let image: String?
}

struct Image: Codable {
    let href: String?
    let transparent: Bool?
}

struct Level: Codable {
    let id: Int?
    let level: String?
}

struct TypeElement: Codable {
    let id: Int?
    let type: String?
}

