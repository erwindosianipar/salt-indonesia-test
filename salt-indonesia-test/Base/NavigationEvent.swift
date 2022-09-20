//
//  NavigationEvent.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 19/09/22.
//

internal enum Navigation {
    case prev(ScreenResult?)
    case next(ScreenResult?)
}

internal final class NavigationEvent {
    
    typealias EventHandler = ((Navigation) -> Void)
    
    var eventHandler: EventHandler?
    
    func send(_ navigation: Navigation) {
        eventHandler?(navigation)
    }
    
    func on(_ handler: @escaping EventHandler) {
        eventHandler = handler
    }
}
