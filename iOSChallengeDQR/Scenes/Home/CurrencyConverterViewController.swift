//
//  CurrencyConverterViewController.swift
//  iOSChallengeDQR
//
//  Created by DevLuis on 13/07/21.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

      @IBOutlet weak var sourceCurrencyButton: UIButton?
      @IBOutlet weak var destinationCurrencyButton: UIButton?
      @IBOutlet weak var sourceCurrencyValueTextField: UITextField? {
            didSet {
                let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
                sourceCurrencyValueTextField?.leftView = leftView
                sourceCurrencyValueTextField?.leftViewMode = .always
                sourceCurrencyValueTextField?.attributedPlaceholder = NSAttributedString(string: "Digite o valor para converter",
                                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            }
        }
    @IBOutlet weak var convertedValueLabel: UILabel?
        var selectionPickerView: UIPickerView!
        var viewModel: CurrencyConverterViewModelProtocol?
    
    @IBOutlet var nameCurrencyOri: UILabel! {
        didSet {
            nameCurrencyOri.text = "United States Dollar"
        }
    }
    @IBOutlet var nameCurrencyDES: UILabel! {
           didSet {
               nameCurrencyDES.text = "United States Dollar"
           }
       }

        override func viewDidLoad() {
            super.viewDidLoad()
            initialize()
            requestCurrencies()
        }

        func initialize() {
            viewModel = CurrencyConverterViewModel(liveCurrencyRepository: LiveCurrencyRepository(), listCurrencyRepository: ListCurrencyRepository(), presentErrorDelegate: self)
            sourceCurrencyValueTextField?.delegate = self
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        }

        func requestCurrencies() {
            viewModel?.requestCurrencyList()
            viewModel?.requestCurrencyRates()
        }

        @IBAction func didTapSourceCurrency(_ sender: UIButton) {
            guard let viewModel = viewModel else {return}
            viewModel.isSourceSelected = true
            if viewModel.totalOfCurrenciesInList() > 0 {
                pickerSetup()
            }

        }

        @IBAction func didTapDestinationCurrency(_ sender: UIButton) {
            guard let viewModel = viewModel else {return}
            viewModel.isSourceSelected = false
            if viewModel.totalOfCurrenciesInList() > 0 {
                pickerSetup()
            }
        }

        func pickerSetup() {
            selectionPickerView = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
            selectionPickerView.delegate = self
            selectionPickerView.dataSource = self

            let alertController = UIAlertController(title: "Selecione Moeda", message: nil, preferredStyle: .alert)
            

            alertController.view.addSubview(selectionPickerView)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            alertController.view.addConstraint(NSLayoutConstraint(item: alertController.view as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200))

            self.present(alertController, animated: true, completion: nil)
        }

        @objc func hideKeyboard() {
            convertedValueLabel?.text = convertedStringValue
            view.endEditing(true)
        }
    }

    extension CurrencyConverterViewController : UIPickerViewDelegate, UIPickerViewDataSource {

        private var convertedStringValue: String {
            guard let viewModel = viewModel else { return "" }
            guard let textField = sourceCurrencyValueTextField,
                let value = textField.text else { return "\(viewModel.selectedConversionCurrency)" }
            var convertedValue = viewModel.performConversion(value: value)
            return "\(viewModel.selectedConversionCurrency) \(convertedValue.roundWith(precision: 3).description)"
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            guard let viewModel = viewModel else { return 0 }
            return viewModel.totalOfCurrenciesInList()
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return "\(viewModel?.currencyList[row].key ?? "") - \(viewModel?.currencyList[row].value ?? "")"
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            guard let viewModel = viewModel else { return }
            if viewModel.isSourceSelected {
                viewModel.selectedSourceCurrency = viewModel.currencyList[row].key
                sourceCurrencyButton?.setTitle(viewModel.currencyList[row].key, for: .normal)
                nameCurrencyOri.text = "\(viewModel.currencyList[row].value)"
            } else {
                viewModel.selectedConversionCurrency = viewModel.currencyList[row].key
                destinationCurrencyButton?.setTitle(viewModel.currencyList[row].key, for: .normal)
                nameCurrencyDES.text = "\(viewModel.currencyList[row].value)"
            }
            convertedValueLabel?.text = convertedStringValue
        }
    }

    extension CurrencyConverterViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            convertedValueLabel?.text = convertedStringValue
            textField.resignFirstResponder()
            return true
        }
    }

    extension CurrencyConverterViewController: PresentErrorDelegate {
        func present(error: String) {
            DispatchQueue.main.async{
                let alertController = UIAlertController(title:"Erro", message: error, preferredStyle:.alert)
                let okAction = UIAlertAction(title:"Ok, entendi.", style: .cancel)
                let tryAgainAction = UIAlertAction(title: "Tentar Novamente", style: .default, handler: {[weak self]
                    _ in
                    self?.requestCurrencies()
                })
                alertController.addAction(okAction)
                alertController.addAction(tryAgainAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
