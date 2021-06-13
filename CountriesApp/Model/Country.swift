//
//  Country.swift
//  CountriesApp
//
//  Created by André Santana on 09/06/2021.
//

import Foundation

struct Country: Decodable {
    let name, capital, region: String
    let subregion, demonym: String
    let flag: String
    
    enum CodingKeys: String, CodingKey {
        case name, capital, region
        case subregion, demonym
        case flag = "alpha2Code"
    }
}
