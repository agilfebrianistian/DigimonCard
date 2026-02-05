//
//  DigimonListResponse.swift
//  DigimonCard
//
//  Created by Agil Febrianistian on 05/02/26.
//


struct DigimonListResponse: Codable {
    let content: [DigimonListItem]?
    let pageable: Pageable
}

struct DigimonListItem: Codable {
    let id: Int
    let name: String
    let href: String
    let image: String
}

struct Pageable: Codable {
    let currentPage: Int
    let elementsOnPage: Int
    let totalElements: Int
    let totalPages: Int
    let previousPage: String?
    let nextPage: String?
}
