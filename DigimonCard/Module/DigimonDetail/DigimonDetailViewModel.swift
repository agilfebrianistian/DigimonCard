//
//  DigimonDetailViewModel.swift
//  DigimonCard
//
//  Created by Agil Febrianistian on 06/02/26.
//

import Foundation
import PromiseKit

final class DigimonDetailViewModel {

    var digimon: Digimon?

    var onDataUpdated: (() -> Void)?
    var onShowAlert: ((NetworkError) -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    
    private var isLoading = false

    func fetchDetail(name: String) {
        guard !isLoading else { return }
        isLoading = true
        onLoadingStateChanged?(true)

        let target = NetworkAPI.getDigimonDetail(name: name)
        let future = NetworkFuture<Data>()

        future.request(target: target)
            .done { [weak self] data in
                guard let self = self else { return }

                let decoder = JSONDecoder()
                let result = try decoder.decode(Digimon.self, from: data)

                self.digimon = result
                self.isLoading = false

                DispatchQueue.main.async {
                    self.onLoadingStateChanged?(false)
                    self.onDataUpdated?()
                }
            }
            .catch { [weak self] error in
                self?.isLoading = false

                DispatchQueue.main.async {
                    self?.onLoadingStateChanged?(false)
                    self?.onShowAlert?(error as? NetworkError ?? NetworkError())
                }
            }
    }
}
