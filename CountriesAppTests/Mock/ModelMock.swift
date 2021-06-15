//
//  ModelMock.swift
//  CountriesAppTests
//
//  Created by André Santana on 14/06/2021.
//

import Foundation

struct ModelMock {
    
    var countries: [[String: Any]]
    
    var hasAtLeastOneRecord: Bool {
        return !countries[0].isEmpty
    }
    
    var hasName: Bool {
        guard let name = countries[0]["name"] as? String else { return false }
        return !name.isEmpty
    }
    
    var hasCapital: Bool {
        guard let capital = countries[0]["capital"] as? String else { return false }
        return !capital.isEmpty
    }
    
    var hasRegion: Bool {
        guard let region = countries[0]["region"] as? String else { return false }
        return !region.isEmpty
    }
    
    var hasFlag: Bool {
        guard let flag = countries[0]["alpha2Code"] as? String else { return false }
        return !flag.isEmpty
    }
}
