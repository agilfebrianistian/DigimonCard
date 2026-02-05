//
//  Extension-UIViewController.swift
//  MusicPlayerApp
//
//  Created by Agil Febrianistian on 28/06/25.
//

import Foundation
import UIKit

extension UIViewController {
    
    func standardizeBackButton(){
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    var customAccessory : UIToolbar {
        
        let _accessoryView = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        _accessoryView.barStyle = .default
        _accessoryView.barTintColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onLocationSelection))
        doneButton.tintColor = .white
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onLocationDismissed))
        cancelButton.tintColor = .white

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        _accessoryView.setItems([cancelButton,flexSpace,doneButton], animated: true)
        _accessoryView.sizeToFit()
        
        return _accessoryView
    }
    
    @objc open func onLocationSelection() {
    }
    
    @objc open func onLocationDismissed() {
    }

}
