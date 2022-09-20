//
//  UIImageView+Helper.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

enum WeatherIcon {
    case custom(String)
    case net(String)
    
    var imagePath: String {
        switch self {
        case .custom(let abbr):
            return "https://www.metaweather.com/static/img/weather/png/64/\(abbr).png"
        case .net(let link):
            return link
        }
    }
}

extension UIImageView {
    
    func loadImage(icon: WeatherIcon) {
        guard let url = URL(string: icon.imagePath) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
