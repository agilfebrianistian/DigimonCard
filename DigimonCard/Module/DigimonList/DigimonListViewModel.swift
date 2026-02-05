//
//  DigimonListViewModel.swift
//  DigimonCard
//
//  Created by Agil Febrianistian on 06/02/26.
//

import Foundation
import PromiseKit

class DigimonListViewModel {
    
    var items: [DigimonListItem] = []
    private var currentQuery = DigimonListParameter()
    private var isLoading = false
    private var hasMorePages = true
    
    var onDataUpdated: (() -> Void)?
    var onShowAlert: ((NetworkError) -> Void)?
    var onEmptyResult: (() -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?

    func search( name: String? = nil, attribute: String? = nil, level: String? = nil, exact: Bool? = nil) {
        items.removeAll()
        currentQuery = DigimonListParameter(
            name: name,
            exact: exact,
            attribute: attribute,
            level: level,
            page: 0
        )
        
        hasMorePages = true
        isLoading = false
        
        fetchNext()
    }
    
    func fetchNext() {
        
        guard !isLoading, hasMorePages else { return }
        
        isLoading = true
        onLoadingStateChanged?(true)
        
        let target = NetworkAPI.getDigimonList(param: currentQuery)
        let future = NetworkFuture<Data>()
        future.request(target: target)
            .done { [weak self] dic in
                self?.isLoading = false
                let decoder = JSONDecoder()
                let result = try decoder.decode(DigimonListResponse.self, from: dic)

                self?.hasMorePages = result.pageable.currentPage + 1 < result.pageable.totalPages
                
                if result.pageable.totalElements == 0 {

                    DispatchQueue.main.async {
                        self?.onLoadingStateChanged?(false)
                        self?.onEmptyResult?()
                    }
                    return
                }
                
                self?.items.append(contentsOf: result.content ?? [])
                self?.currentQuery.page += 1
                
                DispatchQueue.main.async {
                    self?.onLoadingStateChanged?(false)
                    self?.onDataUpdated?()
                }
            }.catch { [weak self] error in
                self?.isLoading = false
                self?.onLoadingStateChanged?(false)
                self?.onShowAlert?(error as? NetworkError ?? NetworkError())
            }
    }
}
