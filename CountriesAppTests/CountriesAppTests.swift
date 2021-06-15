//
//  CountriesAppTests.swift
//  CountriesAppTests
//
//  Created by André Santana on 14/06/2021.
//

import Mocker
import Quick
import Nimble

class CountryAppTests: QuickSpec {
        
    override func spec() {
        Nimble.AsyncDefaults.timeout = .seconds(5)
        describe("Get All Countries") {
            context("status code is 200") {
                var model: ModelMock?
                it("the response needs to have name, capital, region and flag without error") {
                    self.request(mock:  .get_countries, statusCode: 200) { dictionary in
                        model = ModelMock(dictionary: dictionary)
                    }
                    
                    expect(model?.hasName).toEventually(beTrue())
                    expect(model?.hasCapital).toEventually(beTrue())
                    expect(model?.hasRegion).toEventually(beTrue())
                    expect(model?.hasFlag).toEventually(beTrue())
                    expect(model?.hasAtLeastOneRecord).toEventually(beTrue())
                }
            }
        }
    }
}

extension QuickSpec {
    
    func request(mock: JSONMock, statusCode: Int, handler: @escaping (_ dictionary: [[String: Any]]) -> Void) {
        Mock(url: mock.url, dataType: .json, statusCode: statusCode, data: [
            .get : mock.data
        ]).register()
        URLSession.shared.dataTask(with: mock.url) { (data, response, error) in
            let dictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
            handler(dictionary)
        }.resume()
    }
}
