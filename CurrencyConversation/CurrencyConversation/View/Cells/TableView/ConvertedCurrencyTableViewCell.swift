//
//  ConvertedCurrencyTableViewCell.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/20/22.
//

import UIKit

class ConvertedCurrencyTableViewCell: UITableViewCell {
    
    
    @IBOutlet private weak var currencySymbol           : UILabel!
    @IBOutlet private weak var currencyName             : UILabel!
    @IBOutlet private weak var totalConvertedValueLabel : UILabel!
    @IBOutlet private weak var perUnitValueLabel        : UILabel!
    
    var userEnteredValue : Double = 0.0
    var userSelectedCurrencyName : String = ""
    
    
    var exchangeRatesModel : ExchangeRatesModel! {
        didSet {
            self.currencySymbol.text            = exchangeRatesModel.getSymbol()
            self.currencyName.text              = exchangeRatesModel.currencyName
            self.totalConvertedValueLabel.text  = String(format: "%.2f", exchangeRatesModel.rate * userEnteredValue)
            self.perUnitValueLabel.text         = "1 \(userSelectedCurrencyName) = \(String(format: "%.2f", exchangeRatesModel.rate)) \(exchangeRatesModel.country)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
}
