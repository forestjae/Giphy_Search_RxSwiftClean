//
//  UIColor+Extension.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/25.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
