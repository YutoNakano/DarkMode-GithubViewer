//
//  AppColor.swift
//  practice_Mousou
//
//  Created by 中野湧仁 on 2019/03/31.
//  Copyright © 2019 中野湧仁. All rights reserved.
//

import UIKit

public enum AppColorType: String {
    
    case black = "000000"
    
}

extension UIColor {
    public static func appColor(_ type: AppColorType, alpha:CGFloat? = nil) -> UIColor {
        if let alpha = alpha {
            return UIColor(hex: type.rawValue).withAlphaComponent(alpha)
        } else {
            return UIColor(hex: type.rawValue)
        }
    }
}
