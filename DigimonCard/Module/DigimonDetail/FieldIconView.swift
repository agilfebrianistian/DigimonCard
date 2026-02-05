//
//  FieldIconView.swift
//  DigimonCard
//
//  Created by Agil Febrianistian on 06/02/26.
//

import UIKit
import SDWebImage

class FieldIconView: UIImageView {

    init(url: URL?) {
        super.init(frame: .zero)
        setup()
        if let url {
            sd_setImage(with: url)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setup() {
        contentMode = .scaleAspectFit
        layer.cornerRadius = 6
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 36),
            heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}
