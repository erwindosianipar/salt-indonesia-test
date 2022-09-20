//
//  ReqresEndpoint.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 20/09/22.
//

enum ReqresEndpoint {
    case login
    case users
}

extension ReqresEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .users:
            return "/users?per_page=12"
        }
    }
    
    var method: String {
        switch self {
        case .login:
            return "POST"
        case .users:
            return "GET"
        }
    }
    
    var base: String {
        return "https://reqres.in/api"
    }
}
