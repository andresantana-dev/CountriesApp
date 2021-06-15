//
//  ModelMock.swift
//  CountriesAppTests
//
//  Created by André Santana on 14/06/2021.
//

import Foundation

struct ModelMock {
    
    var dictionary: [[String: Any]]
    
    var hasAtLeastOneRecord: Bool {
        return !dictionary[0].isEmpty
    }
    
    var hasName: Bool {
        guard let name = dictionary[0]["name"] as? String else { return false }
        return !name.isEmpty
    }
    
    var hasCapital: Bool {
        guard let capital = dictionary[0]["capital"] as? String else { return false }
        return !capital.isEmpty
    }
    
    var hasRegion: Bool {
        guard let region = dictionary[0]["region"] as? String else { return false }
        return !region.isEmpty
    }
    
    var hasFlag: Bool {
        guard let flag = dictionary[0]["alpha2Code"] as? String else { return false }
        return !flag.isEmpty
    }
}
