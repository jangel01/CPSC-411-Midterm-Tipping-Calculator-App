//
//  ViewController.swift
//  midterm-tipping-calculator
//
//  Created by Jason Angel on 10/11/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var leftSpacer: UIView!
    @IBOutlet var rightSpacer: UIView!
    @IBOutlet var fifthStack: UIView!
    @IBOutlet var billField: UITextField!
    @IBOutlet var tipPercentField: UITextField!
    @IBOutlet var numOfPeopleField: UITextField!
    @IBOutlet var perPersonTip: UILabel!
    @IBOutlet var perPersonTotal: UILabel!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var middleSpacer: UIView!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var totalAmountLabel: UILabel!
    
    var faceView: UIImageView!
    var billDouble: Double!
    var tipPercentDouble: Double!
    var numPeopleDouble: Double!
    
    var fvLeadingConstraintPortrait: NSLayoutConstraint!
    var fvLeadingConstraintLandscape: NSLayoutConstraint!
    
    var tipAmountLabelInitialText: String!
    var totalAmountLabelInitialText: String!
    let amountLabel = NSLocalizedString(" (per person)", comment: "text if there is more than one person")
    
    func textField(_ tipPercentField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            let currentLocale = Locale.current
            let decimalSeparator = currentLocale.decimalSeparator ?? "."

            let existingTextHasDecimal = tipPercentField.text?.range(of: decimalSeparator)
            let replacementTextHasDecimal = string.range(of: decimalSeparator)
            
            if existingTextHasDecimal != nil,
               replacementTextHasDecimal != nil {
                return false
            } else {
                return true
            }
        }
        
        func billField(_ billField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentLocale = Locale.current
            let decimalSeparator = currentLocale.decimalSeparator ?? "."

            let existingTextHasDecimal = billField.text?.range(of: decimalSeparator)
            let replacementTextHasDecimal = string.range(of: decimalSeparator)
            
            if existingTextHasDecimal != nil,
               replacementTextHasDecimal != nil {
                return false
            } else {
                return true
            }
        }
        
        func peopleField(_ numOfPeopleField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentLocale = Locale.current
            let decimalSeparator = currentLocale.decimalSeparator ?? "."

            let existingTextHasDecimal = numOfPeopleField.text?.range(of: decimalSeparator)
            let replacementTextHasDecimal = string.range(of: decimalSeparator)
            
            if existingTextHasDecimal != nil,
               replacementTextHasDecimal != nil {
                return false
            } else {
                return true
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = UIScreen.main.bounds.size
        
        if size.width < size.height {
            // portrait
            self.fvLeadingConstraintPortrait.isActive = true
            self.fvLeadingConstraintLandscape.isActive = false
            self.logo.image = UIImage(named: "logo.png")
        } else {
            // landscape
            self.fvLeadingConstraintPortrait.isActive = false
            self.fvLeadingConstraintLandscape.isActive = true
            self.logo.image = UIImage(named: "colored-logo.png")
        }
        
        self.tipAmountLabelInitialText = self.tipAmountLabel.text!
        self.totalAmountLabelInitialText = self.totalAmountLabel.text!
    }
    
    
    override func loadView() {
        super.loadView()
        
        self.faceView = UIImageView()
        self.faceView.image = UIImage(named: "sad-face.png")
        self.faceView.contentMode = .scaleAspectFit
        self.faceView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.faceView)
        
        let fvTopConstraint = self.faceView.topAnchor.constraint(equalTo: self.fifthStack.bottomAnchor, constant: 30)
        self.fvLeadingConstraintPortrait = self.faceView.leadingAnchor.constraint(equalTo: self.leftSpacer.leadingAnchor)
        self.fvLeadingConstraintLandscape = self.faceView.leadingAnchor.constraint(equalTo: self.middleSpacer.leadingAnchor)
        let fvTrailingConstraint = self.faceView.trailingAnchor.constraint(equalTo: self.rightSpacer.trailingAnchor)
        
        fvTopConstraint.isActive = true
        fvTrailingConstraint.isActive = true
        
        tipPercentField.placeholder = "16"
        numOfPeopleField.placeholder = "1"
    }
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        self.billField.resignFirstResponder()
        self.tipPercentField.resignFirstResponder()
        self.numOfPeopleField.resignFirstResponder()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        //Whenever the resetButton is tapped clear all textFields
        print("Reset button tapped!")
        billField.text = ""
        tipPercentField.text = ""
        numOfPeopleField.text = ""
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let formattedZeroCurrency = formatter.string(from: NSNumber(value: 0.00)) ?? "$0.00"

        perPersonTip.text = formattedZeroCurrency
        perPersonTotal.text = formattedZeroCurrency
    }
    
    @IBAction func calcTips(_ sender: UITextField) {
        //Get the information of the text fields
        getTextInfo()
        
        //Calculate the total tips divided by amount of people
        let tipCalc = (billDouble * (tipPercentDouble / 100)) / numPeopleDouble
        
        //Format the result based on the current locale
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedTip = formatter.string(from: NSNumber(value: tipCalc)) {
            perPersonTip.text = formattedTip
        } else {
            perPersonTip.text = "$0.00" // Fallback
        }
        
        //Logging comment
        print("Tip has been calculated!")
    }

    @IBAction func calcTotal(_ sender: UITextField) {
        //Get the information of the text fields
        getTextInfo()
        
        //Calculate the total divided by amount of people
        let totalCalc = (billDouble + (billDouble * (tipPercentDouble / 100))) / numPeopleDouble
        
        //Format the result based on the current locale
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedTotal = formatter.string(from: NSNumber(value: totalCalc)) {
            perPersonTotal.text = formattedTotal
        } else {
            perPersonTotal.text = "$0.00" // Fallback
        }
        
        if self.numPeopleDouble > 1 {
            self.tipAmountLabel.text = self.tipAmountLabelInitialText + self.amountLabel
            self.totalAmountLabel.text = self.totalAmountLabelInitialText + self.amountLabel
        } else {
            self.tipAmountLabel.text = self.tipAmountLabelInitialText
            self.totalAmountLabel.text = self.totalAmountLabelInitialText
        }
        
        //Logging comment
        print("Total has been calculated!")
    }

    func getTextInfo() {
        //Get the information of the text fields
        let billText = billField.text ?? ""
        billDouble = stringToNum(currencyString: billText)
        
        //Check to see if the tip field is filled if not use the default number
        var tipPercentText = tipPercentField.text!
        if tipPercentText != ""{
            tipPercentDouble = stringToNum(currencyString: tipPercentText)
        }
        else {
            tipPercentText = "16"
            tipPercentDouble = stringToNum(currencyString: tipPercentText)
        }
        
        //Check to see if the numPeople field is filled if not use the default number
        var numOfPeopleText = numOfPeopleField.text!
        if numOfPeopleText != "" {
            numPeopleDouble = stringToNum(currencyString: numOfPeopleText)
        }
        else {
            numOfPeopleText = "1"
            numPeopleDouble = stringToNum(currencyString: numOfPeopleText)
        }

        //Logging comment
        print("Bill info obtained!")
    }
    
    func stringToNum (currencyString: String) -> Double {
        //Covert from a string to a universal decimal
        let formatter = NumberFormatter()
        if let number = formatter.number(from: currencyString) {
            print("Converted to ", number.doubleValue)
            return number.doubleValue
        } else {
            print("Failed to parse the string.")
            return 0.00
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if self.traitCollection.verticalSizeClass == .compact {
            // landscape orientation
            self.fvLeadingConstraintPortrait.isActive = false
            self.fvLeadingConstraintLandscape.isActive = true
            self.logo.image = UIImage(named: "colored-logo.png")
        } else {
            // portrait orientation
            self.fvLeadingConstraintPortrait.isActive = true
            self.fvLeadingConstraintLandscape.isActive = false
            self.logo.image = UIImage(named: "logo.png")
        }
        
    }
    
}
