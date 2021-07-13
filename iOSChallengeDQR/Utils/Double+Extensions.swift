//
//  Double+Extensions.swift
//  iOSChallengeDQR
//
//  Created by DevLuis on 12/07/21.
//

import Foundation

extension Double {
    mutating func roundWith(precision digits: Int) -> Self {
        let divisor = pow(10.0, Double(digits))
        return (self * divisor).rounded() / divisor
    }
}
