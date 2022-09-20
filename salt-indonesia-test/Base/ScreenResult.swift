//
//  ScreenResult.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 19/09/22.
//

internal protocol ScreenResult {}

extension Int: ScreenResult {}
extension String: ScreenResult {}

extension HomeScreenResult: ScreenResult {}
