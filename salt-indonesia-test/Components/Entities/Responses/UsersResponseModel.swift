//
//  UsersResponseModel.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 20/09/22.
//

import JASON

struct UserDataResponseModel: Decodable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}

struct UsersResponseModel: Decodable {
    let data: [UserDataResponseModel]
}
