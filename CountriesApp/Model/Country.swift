//
//  Country.swift
//  CountriesApp
//
//  Created by André Santana on 09/06/2021.
//

import Foundation

struct Country: Decodable {
    let name, capital, region: String
    let flag: String
    
    enum CodingKeys: String, CodingKey {
        case name, capital, region
        case flag = "alpha2Code"
    }
}
