//
//  DigimonListViewController.swift
//  DigimonCard
//
//  Created by Agil Febrianistian on 06/02/26.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

final class DigimonListViewController: UIViewController {
    
    private let viewModel = DigimonListViewModel()
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var notFoundView: UIView!
    
    private lazy var activityIndicatorView: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(
            frame: .zero,
            type: .lineScalePulseOutRapid,
            color: .systemGreen
        )
        return indicator
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.estimatedItemSize = .zero
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        reloadData()
    }
    
    private func setupUI() {
        title = "Digimon"
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicatorView.frame = view.bounds
    }
    
    private func setupCollectionView() {
        cardCollectionView.collectionViewLayout = flowLayout
        cardCollectionView.register(UINib(nibName: "DigimonCardCell", bundle: nil),
                                    forCellWithReuseIdentifier: "DigimonCardCell")
    }
    
    private func bindViewModel() {
        
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            isLoading ?  self?.activityIndicatorView.startAnimating() :  self?.activityIndicatorView.stopAnimating()
        }
        
        viewModel.onDataUpdated = { [weak self] in
            self?.notFoundView.isHidden = true
            self?.cardCollectionView.reloadData()
        }
        
        viewModel.onShowAlert = { [weak self] error in
            self?.cardCollectionView.reloadData()
            self?.showAlert(title: "", message: error.message ?? "")
        }
        
        viewModel.onEmptyResult = { [weak self] in
            self?.notFoundView.isHidden = false
        }
    }
    
    func reloadData() {
        activityIndicatorView.startAnimating()
        viewModel.fetchNext()
    }
}

extension DigimonListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DigimonCardCell", for: indexPath) as! DigimonCardCell
        cell.configure(with: viewModel.items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DigimonDetailViewController") as? DigimonDetailViewController
        vc?.name = viewModel.items[indexPath.item].name
        navigationController?.pushViewController(vc!, animated: true)
        
    }
}

extension DigimonListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.bounds.height

        if offsetY > contentHeight - height * 1.5 {
            viewModel.fetchNext()
        }
    }
}

extension DigimonListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath ) -> CGSize {

        let columns: CGFloat = 2
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let inset = flowLayout.sectionInset

        let availableWidth = collectionView.bounds.width - inset.left - inset.right - spacing * (columns - 1)

        let width = floor(availableWidth / columns)
        let height = floor(width * 1.4)

        return CGSize(width: width, height: height)
    }

}

extension DigimonListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.search(name: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        viewModel.search()
    }
}

