//
//  UsersResponseModel.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 20/09/22.
//

import JASON

struct UserDataResponseModel: Decodable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String
    
    init?(json: JSON) {
        guard let id = json["id"].int,
              let email = json["email"].string,
              let firstName = json["first_name"].string,
              let lastName = json["last_name"].string,
              let avatar = json["avatar"].string else {
            return nil
        }
        
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
}

struct UsersResponseModel: Decodable {
    var data: [UserDataResponseModel] = []
    
    init?(json: JSON) {
        guard let jsonData = json["data"].jsonArray else {
            return nil
        }
        
        jsonData.forEach({ json in
            guard let item = UserDataResponseModel(json: json) else {
                return
            }
            self.data.append(item)
        })
    }
}
