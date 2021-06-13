//
//  CountryVM.swift
//  CountriesApp
//
//  Created by André Santana on 09/06/2021.
//

import Foundation

protocol CountryVMDelegate: AnyObject {
    func handler(_ finished: Bool, _ error: ServiceError?)
}

class CountryVM: NSObject {
    
    // MARK: - Properties
    
    private weak var delegate: CountryVMDelegate? = nil
    
    private var isSuccess = true
    private var fetchError: ServiceError? = nil
    
    public var countries: [Country]? = nil
            
    override init() {
        super.init()
        Loader.shared.show()
        getCountries()
    }
        
    public func set(delegate: CountryVMDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - API Methods
    
    private func getCountries() {
        ServiceAPI.shared.getCountries { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.handler(false, error)
            case .success(let countries):
                self?.countries = countries
                self?.delegate?.handler(true, nil)
            }
        }
    }
}
