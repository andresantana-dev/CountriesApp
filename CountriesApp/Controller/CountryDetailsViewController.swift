//
//  CountryDetailsViewController.swift
//  CountriesApp
//
//  Created by André Santana on 09/06/2021.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var flagLbl: UILabel!
    
    var countryDetails: Country? {
        didSet {
            configureUI()
        }
    }
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func configureUI() {
        guard let countryDetails = countryDetails else { return }
        self.nameLbl.text = countryDetails.name
        self.flagLbl.text = countryDetails.flag.flag
    }
}
