//
//  CGFloat.swift
//  ImageFilter
//
//  Created by Roman Borzdukha on 30.07.2023.
//

import Foundation

extension CGFloat {
    func toString(withDecimals decimals: Int) -> String {
        return String(format: "%.\(decimals)f", self)
    }
}
