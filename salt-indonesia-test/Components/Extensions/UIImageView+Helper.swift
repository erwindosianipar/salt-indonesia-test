//
//  UIImageView+Helper.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: String) {
        guard let url = URL(string: url) else {
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
