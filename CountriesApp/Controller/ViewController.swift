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
    
    private lazy var viewModel: CountryVM = {
        let viewModel = CountryVM()
        viewModel.set(delegate: self)
        return viewModel
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureNavigationBar(withTitle: "Countries", prefersLargeTitles: true)
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
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewId, for: indexPath) as! CountryViewCell
        cell.countryData = viewModel.countries?[indexPath.section]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.countries?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CountryDetailsViewController") as? CountryDetailsViewController {
            detailsVC.countryDetails = viewModel.countries?[indexPath.section]
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

// MARK: - CountryVMDelegate
extension ViewController: CountryVMDelegate {
    func handler(_ finished: Bool, _ error: ServiceError?) {
        if let error = error {
            showAlert("ERROR", message: error.localizedDescription)
            return
        }
        tableView.reloadData()
        Loader.shared.hide()
    }
}
