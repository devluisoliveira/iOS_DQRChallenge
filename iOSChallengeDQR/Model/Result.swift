//
//  Result.swift
//  iOSChallengeDQR
//
//  Created by DevLuis on 13/07/21.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
