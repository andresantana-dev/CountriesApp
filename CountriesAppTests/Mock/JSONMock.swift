//
//  JSONMock.swift
//  CountriesAppTests
//
//  Created by André Santana on 14/06/2021.
//

import Foundation

enum JSONMock: String {
    case get_countries
    var url: URL {
        return URL(string: "https://www.mocker.com/get_countries.json")!
    }
    var data: Data {
        let url = Bundle.main.url(forResource: "get_countries", withExtension: "json")!
        return try! Data(contentsOf: url, options: .mappedIfSafe)
    }
}
