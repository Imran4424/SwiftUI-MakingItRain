//
//  Extensions.swift
//  MakingItRain
//
//  Created by Shah Md Imran Hossain on 18/2/24.
//

import Foundation

extension Double {
    func spread() -> Self {
        Self.random(in: -self / 2...self / 2)
    }
}
