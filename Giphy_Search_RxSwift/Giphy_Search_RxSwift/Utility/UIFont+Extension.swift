//
//  UIFont+Extension.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/25.
//

import UIKit

extension UIFont {
    func metrics(for textStyle: UIFont.TextStyle) -> UIFont {
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: self)
    }
}
