//
//  HomeViewModel.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 19/09/22.
//

import RxSwift

internal final class HomeViewModel {
    
    let screenResult: HomeScreenResult
    
    init(screenResult: HomeScreenResult) {
        self.screenResult = screenResult
    }
    
    func user() -> Observable<UsersResponseModel> {
        return Observable.create { observer in
            let endpoint = ReqresEndpoint.users
            APIProvider.dataRequest(endpoint: endpoint, body: [:], response: UsersResponseModel.self) { result in
                switch result {
                case .success(let result):
                    observer.onNext(result)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
