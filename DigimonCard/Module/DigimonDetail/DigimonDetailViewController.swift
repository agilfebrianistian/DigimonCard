//
//  DigimonDetailViewController.swift
//  DigimonCard
//
//  Created by Agil Febrianistian on 06/02/26.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

class DigimonDetailViewController: UIViewController {
    
    private let viewModel = DigimonDetailViewModel()
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var fieldsStackView: UIStackView!
    
    var name:String?

    private lazy var activityIndicatorView: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(
            frame: .zero,
            type: .lineScalePulseOutRapid,
            color: .systemGreen
        )
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        title = "Digimon Detail"
        viewModel.fetchDetail(name: name ?? "")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicatorView.frame = view.bounds
    }

    private func bindViewModel() {
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            isLoading ?  self?.activityIndicatorView.startAnimating() :  self?.activityIndicatorView.stopAnimating()
        }

        viewModel.onDataUpdated = { [weak self] in
            self?.updateUI()
        }

        viewModel.onShowAlert = { [weak self] error in
            self?.showAlert(title: "", message: error.message ?? "")
        }
    }
    
    private func updateUI() {
        
        let digimon = viewModel.digimon
        
        idLabel.text = "\(digimon?.digimonID ?? 0)"
        nameLabel.text = digimon?.name
        imageView.sd_setImage(with: URL(string: digimon?.images?.first?.href ?? ""))
        levelLabel.text = digimon?.levels?.first?.level
        attributeLabel.text = digimon?.attributes?.first?.attribute
        typeLabel.text = digimon?.types?.first?.type

        configureFields(digimon?.fields ?? [])
    }
    
    func configureFields(_ fields: [Field]) {

        fieldsStackView.arrangedSubviews.forEach {
            fieldsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        fields.forEach {
            let iconView = FieldIconView(url: URL(string: $0.image ?? ""))
            fieldsStackView.addArrangedSubview(iconView)
        }
    }


}
