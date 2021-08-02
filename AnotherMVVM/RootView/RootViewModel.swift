//
//  RootViewModel.swift
//  AnotherMVVM
//
//  Created by Mac on 02.08.2021.
//

import Foundation

protocol RootViewModelDelegate {
    func didFinishFetchingMessage(_ message: String?)
    func didStartFetchingMessage(_ message: String?)
}

class RootViewModel {
    
    var rootViewModelDelegate: RootViewModelDelegate?
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func fetchMessage() {
        rootViewModelDelegate?.didStartFetchingMessage("Fetching...")
        DispatchQueueHelper.delay(bySeconds: 3.0,
                                  dispatchLevel: .background) {
            var message: String? = "Hello There"
            if message == nil {
                message = "Failed to fetch"
            } else {
                DispatchQueueHelper.delay(bySeconds: 0.0) { [weak self] in
                    self?.rootViewModelDelegate?.didFinishFetchingMessage(message)
                }
            }
        }
    }
}
