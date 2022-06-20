//
//  HomeViewController.swift
//  CurrencyConversation
//
//  Created by Mubashshir on 6/15/22.
//

import UIKit
import DropDown

class HomeViewController: BaseViewController {

    @IBOutlet private weak var tblView                      : UITableView!
    @IBOutlet private weak var amountTextField              : UITextField!
    @IBOutlet private weak var selectCurrencyButtonOutlet   : UIButton!
    @IBOutlet private weak var currencySymbolLabel          : UILabel!
    
    var selectedCurrency    : CurrenciesModel?
    var currenciesArr       : [CurrenciesModel] = []
    let currencyDropDown    = DropDown()
    
    var exchangeRates       : [ExchangeRatesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareViews()
    }
    
    private func prepareViews(){
        amountTextField.attributedPlaceholder = NSAttributedString(string: "Enter amount here",attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 184/255, green: 185/255, blue: 186/255, alpha: 1.0)])
        
        getAllCurrenciesApiCall()
        
        let appearance = DropDown.appearance()
        appearance.cellHeight = 40
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        appearance.cornerRadius = 10
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
        
        currencyDropDown.anchorView = selectCurrencyButtonOutlet
        currencyDropDown.bottomOffset = CGPoint(x: 0,y: selectCurrencyButtonOutlet.bounds.height)
    }
    
    @IBAction func didTapOnSelectCurrency(_ sender: Any) {
        currencyDropDown.show()
        currencyDropDown.selectionAction = {[weak self] (index: Int, item: String) in
            guard let `self` = self else {return}
            self.selectCurrencyButtonOutlet.setTitle(item, for: .normal)
            self.currencySymbolLabel.text = self.currenciesArr[index].getSymbol()
            self.selectedCurrency = self.currenciesArr[index]
        }
    }
    
    @IBAction func didTapOnConvert(_ sender: Any) {
        if isValid() {
            getConversationRates()
        }
    }
    
    private func isValid() -> Bool {
        var isValid = true
        
        if selectedCurrency == nil {
            isValid = false
            self.showAlert(withMessage: "Please select a currency from drop down.")
        }
        
        if amountTextField.text?.isEmpty ?? false || amountTextField.text == "" {
            isValid = false
            self.showAlert(withMessage: "Please enter amount.")
        }
        
        return isValid
    }
}


// MARK: API Calls
extension HomeViewController {
    private func getAllCurrenciesApiCall() {
        Utill.showProgressHud()
        APIManager.shared.callRequest(.currencies) {[weak self] response in
            Utill.hideProgressHud()
            guard let `self` = self else {return}
            for key in response.dictionaryValue.keys {
                self.currenciesArr.append(CurrenciesModel.init(currencyName: key, countryName: response[key].stringValue))
            }
            self.currenciesArr = self.currenciesArr.sorted { $0.countryName < $1.countryName }
            self.currencyDropDown.dataSource = self.currenciesArr.map({$0.countryName})
        } onFailure: {[weak self] error in
            Utill.showProgressHud()
            guard let `self` = self else {return}
            self.showAlert(withMessage: error.reason)
        }
    }
    
    private func getConversationRates() {
        let params = ["base" : self.selectedCurrency?.currencyName ?? ""] as [String : Any]
        Utill.showProgressHud()
        APIManager.shared.callRequest(.latest(params)) {[weak self] response in
            Utill.hideProgressHud()
            guard let `self` = self else {return}
            print(response)
            for key in response["rates"].dictionaryValue.keys {
                self.exchangeRates.append(ExchangeRatesModel.init(currenyName: key, country: self.currenciesArr.filter({$0.currencyName == key}).first?.countryName ?? "", rate: response["rates"][key].doubleValue, symbol: Utill.getSymbol(forCurrencyCode: key) ?? ""))
            }
            self.tblView.reloadData()
        } onFailure: {[weak self] error in
            Utill.hideProgressHud()
            guard let `self` = self else {return}
            self.showAlert(withMessage: error.reason)
        }
    }
}



extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.registerAndGet(cell: ConvertedCurrencyTableViewCell.self)!
        cell.userEnteredValue = Double(amountTextField.text ?? "0") ?? 0.0
        cell.userSelectedCurrencyName = self.selectedCurrency?.currencyName ?? ""
        cell.exchangeRatesModel = exchangeRates[indexPath.row]
        return cell
    }
    
    
}
