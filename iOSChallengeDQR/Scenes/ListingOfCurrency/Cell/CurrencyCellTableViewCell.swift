//
//  CurrencyCellTableViewCell.swift
//  iOSChallengeDQR
//
//  Created by DevLuis on 13/07/21.
//

import UIKit

class CurrencyCellTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyCodeLabel: UILabel!
    
        override func awakeFromNib() {
            super.awakeFromNib()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }

        func setup(code: String, description: String) {
            currencyCodeLabel.text = "\(code) - \(description)"
        }
    }
