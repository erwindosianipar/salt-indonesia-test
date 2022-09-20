//
//  LoginViewModel.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 20/09/22.
//

import RxSwift

internal final class LoginViewModel {
    
    func login(email: String, password: String) -> Observable<LoginResponseModel> {
        return Observable.create { observer in
            let endpoint = ReqresEndpoint.login
            let body: [String: String] = ["email": email, "password": password]
            APIProvider.dataRequest(endpoint: endpoint, body: body, response: LoginResponseModel.self) { result in
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
