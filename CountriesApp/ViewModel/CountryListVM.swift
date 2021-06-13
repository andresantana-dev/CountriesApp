//
//  CountryListVM.swift
//  CountriesApp
//
//  Created by André Santana on 09/06/2021.
//

import Foundation

protocol CountryVMDelegate: AnyObject {
    func handler(_ finished: Bool, _ error: ServiceError?)
}

class CountryListVM: NSObject {
    
    // MARK: - Properties
    
    private weak var delegate: CountryVMDelegate? = nil
    
    private var isSuccess = true
    private var fetchError: ServiceError? = nil
        
    public var countries: [CountryVM]
            
    override init() {
        self.countries = [CountryVM]()
        Loader.shared.show()
    }

    public func set(delegate: CountryVMDelegate) {
        self.delegate = delegate
    }
    
    var numberOfSections: Int {
        return 1
    }

    var numberOfRows: Int {
        return self.countries.count
    }
    
    func countryAtIndex(at index: Int) -> CountryVM {
        return self.countries[index]
    }
    
    // MARK: - API Methods
    
    public func getCountries() {
        ServiceAPI.shared.getCountries { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.handler(false, error)
            case .success(let countries):
                self?.countries = countries.map(CountryVM.init)
                self?.delegate?.handler(true, nil)
            }
        }
    }
}

struct CountryVM {
    let country: Country
}

extension CountryVM {
    
    var name: String {
        return !self.country.name.isEmpty ? self.country.name : "no_data".localized
    }
    
    var capital: String {
        return !self.country.capital.isEmpty ? self.country.capital : "no_data".localized
    }
    
    var region: String {
        return !self.country.region.isEmpty ? self.country.region : "no_data".localized
    }
    
    var flag: String {
        return self.country.flag
    }
    
    var subregion: String {
        return !self.country.subregion.isEmpty ? self.country.subregion : "no_data".localized
    }
    
    var demonym: String {
        return !self.country.demonym.isEmpty ? self.country.demonym : "no_data".localized
    }
}
