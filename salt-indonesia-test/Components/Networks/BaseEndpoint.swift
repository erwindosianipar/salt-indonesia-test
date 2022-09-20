//
//  BaseEndpoint.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

protocol Endpoint {
    var base: String { get }
    var method: String { get }
    var path: String { get }
}
