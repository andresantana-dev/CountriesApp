//
//  CountryViewCell.swift
//  CountriesApp
//
//  Created by André Santana on 09/06/2021.
//

import UIKit

class CountryViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var capitalLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var flagLbl: UILabel!
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    var countryData: Country? {
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
                        
        self.horizontalStackView.customize(backgroundColor: .systemBlue, radiusSize: 25)
        self.horizontalStackView.backgroundColor = .clear
    }
}
