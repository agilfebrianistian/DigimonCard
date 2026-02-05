//
//  DigimonCardCell.swift
//  DigimonCard
//
//  Created by Agil Febrianistian on 06/02/26.
//

import UIKit
import SDWebImage

class DigimonCardCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!

    func configure(with digimon: DigimonListItem) {
        nameLabel.text = digimon.name
        idLabel.text = "\(digimon.id)"
        imageView.sd_setImage(with: URL(string: digimon.image))
    }


}
