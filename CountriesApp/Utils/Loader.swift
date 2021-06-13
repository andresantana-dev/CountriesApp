//
//  Loader.swift
//  CountriesApp
//
//  Created by André Santana on 13/06/2021.
//

import UIKit

class Loader {
    
    static let shared = Loader()
    
    private var window: UIWindow {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            fatalError("Could not instantiate UIApplication window")
        }
        return window
    }
    
    private lazy var view: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: self.window.frame.width, height: self.window.frame.height)
        view.center = CGPoint(x: self.window.frame.size.width/2, y: self.window.frame.size.height/2)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.cornerRadius = 8
        
        
        let activityView = UIView()
        activityView.frame.size = CGSize(width: 60, height: 60)
        activityView.center = CGPoint(x: self.window.frame.size.width/2, y: self.window.frame.size.height/2)
        activityView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        activityView.cornerRadius = 8
        
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        activity.startAnimating()
        activity.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        
        view.addSubview(activityView)
        view.addSubview(activity)
        self.window.addSubview(view)
        return view
    }()
    
    func show() {
        DispatchQueue.main.async {
            self.view.isHidden = false
            self.window.isUserInteractionEnabled = false
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.view.isHidden = true
            self.window.isUserInteractionEnabled = true
        }
    }
    
    func isAnimating() -> Bool {
        return !self.view.isHidden
    }
    
}
