//
//  CountryViewCell.swift
//  CountriesApp
//
//  Created by André Santana on 09/06/2021.
//

import UIKit

struct CountryData {
    var name: String
    var capital: String
    var region: String
    var flag: String
}

class CountryViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var capitalLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var flagLbl: UILabel!
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    @IBOutlet weak var nameInfoLbl: UILabel!
    @IBOutlet weak var capitalInfoLbl: UILabel!
    @IBOutlet weak var regionInfoLbl: UILabel!
    
    var countryData: CountryData? {
        didSet {
            configureUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helpers

    private func configureUI() {
        guard let countryData = countryData else { return }
        self.nameLbl.text = countryData.name
        self.capitalLbl.text = countryData.capital
        self.regionLbl.text = countryData.region
        self.flagLbl.text = countryData.flag.flag
        
        self.nameInfoLbl.text = "name".localized
        self.capitalInfoLbl.text = "capital".localized
        self.regionInfoLbl.text = "region".localized
                        
        self.horizontalStackView.customize(backgroundColor: .systemBlue, radiusSize: 25)
        self.horizontalStackView.backgroundColor = .clear
    }
}
