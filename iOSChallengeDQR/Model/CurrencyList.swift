//
//  CurrencyList.swift
//  iOSChallengeDQR
//
//  Created by DevLuis on 13/07/21.
//

import Foundation

struct CurrencyList : Decodable {
    var success : Bool?
    var terms: String?
    var privacy: String?
    var currencies: [String:String]?

    enum CodingKeys: String, CodingKey {
        case success
        case terms
        case privacy
        case currencies
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        terms = try container.decode(String.self, forKey: .terms)
        privacy = try container.decode(String.self, forKey: .privacy)
        currencies = try container.decode([String:String].self, forKey: .currencies)
    }
}
