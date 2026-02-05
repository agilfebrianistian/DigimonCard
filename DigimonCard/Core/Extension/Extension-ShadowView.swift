//
//  Extension-ShadowView.swift
//  PertaTrackApp
//
//  Created by Agil Febrianistian on 12/09/23.
//

import Foundation
import UIKit

class ShadowView: UIView {
    @IBInspectable var shadowCornerRadius: CGFloat = 5.0 {
        didSet {
            self.updateProperties()
        }
    }

    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            self.updateProperties()
        }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 2) {
        didSet {
            self.updateProperties()
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 4.0 {
        didSet {
            self.updateProperties()
        }
    }

    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            self.updateProperties()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = false
        
        self.updateProperties()
        self.updateShadowPath()
    }

    internal override func updateProperties() {
        self.layer.cornerRadius = self.shadowCornerRadius
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOpacity = self.shadowOpacity
    }
    
    fileprivate func updateShadowPath() {
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateShadowPath()
    }
}


