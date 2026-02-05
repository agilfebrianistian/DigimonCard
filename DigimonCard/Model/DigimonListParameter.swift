//
//  DigimonListParameter.swift
//  DigimonCard
//
//  Created by Agil Febrianistian on 06/02/26.
//


struct DigimonListParameter : Codable {
    var name: String?
    var exact: Bool?
    var attribute: String?
    var xAntibody: Bool?
    var level: String?
    var page: Int
    var pageSize: Int
    
    init(
        name: String? = nil,
        exact: Bool? = nil,
        attribute: String? = nil,
        xAntibody: Bool? = nil,
        level: String? = nil,
        page: Int = 0,
        pageSize: Int = 8
    ) {
        self.name = name
        self.exact = exact
        self.attribute = attribute
        self.xAntibody = xAntibody
        self.level = level
        self.page = page
        self.pageSize = pageSize
    }
}
