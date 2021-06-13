//
//  AlertHelper.swift
//  CountriesApp
//
//  Created by André Santana on 09/06/2021.
//

import UIKit

protocol AlertHelper where Self: UIViewController {
    func showAlert(_ title: String, message: String)
}

extension AlertHelper {
    func showAlert(_ title: String, message: String) {
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        self.showAlert(title, message: message, actions: [okAction])
    }

    func showAlert(_ title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
