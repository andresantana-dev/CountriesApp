//
//  ViewController.swift
//  CountriesApp
//
//  Created by André Santana on 09/06/2021.
//

import UIKit

class ViewController: UIViewController, AlertHelper {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    private let tableViewId = "CountryCell"
    
    private lazy var viewModel: CountryListVM = {
        let viewModel = CountryListVM()
        viewModel.set(delegate: self)
        return viewModel
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getCountries()
        setupTableView()
        configureNavigationBar(withTitle: "countries".localized, prefersLargeTitles: true)
    }
    
    // MARK: - Helpers
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UIScreen.main.bounds.width / 3
        tableView.register(UINib(nibName: "CountryViewCell", bundle: nil), forCellReuseIdentifier: tableViewId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func displayActionSheet(subregion: String, demonym: String) {
        let optionMenu = UIAlertController(title: nil, message: "country_details".localized, preferredStyle: .actionSheet)
        let subregionAction = UIAlertAction(title: "subregion".localized + subregion, style: .default)
        let demonymAction = UIAlertAction(title: "denomym".localized + demonym, style: .default)
        let cancelAction = UIAlertAction(title: "cancel".localized, style: .cancel)
        optionMenu.addAction(subregionAction)
        optionMenu.addAction(demonymAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewId, for: indexPath) as! CountryViewCell
        let vm = self.viewModel.countryAtIndex(at: indexPath.section)
        cell.countryData = CountryData(name: vm.name, capital: vm.capital, region: vm.region, flag: vm.flag)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfRows

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = self.viewModel.countryAtIndex(at: indexPath.section)
        self.displayActionSheet(subregion: vm.subregion, demonym: vm.demonym)
    }
}

// MARK: - CountryVMDelegate
extension ViewController: CountryVMDelegate {
    func handler(_ finished: Bool, _ error: ServiceError?) {
        Loader.shared.hide()
        if let error = error {
            showAlert("error".localized, message: error.localizedDescription)
            return
        }
        tableView.reloadData()
    }
}
