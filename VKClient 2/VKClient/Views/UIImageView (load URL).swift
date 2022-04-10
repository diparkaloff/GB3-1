//
//  UIImageView (load URL).swift
//  VKClient
//
//  Created by Дмитрий Паркалов on 9.04.22.
//

import UIKit

// загурзка картинок по урлу
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

