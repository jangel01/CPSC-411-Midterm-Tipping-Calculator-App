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
    
    var faceView: UIImageView!
    var billDouble: Double!
    var tipPercentDouble: Double!
    var numPeopleDouble: Double!

    
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
    }
    
    
    override func loadView() {
        super.loadView()
        
        self.faceView = UIImageView()
        self.faceView.image = UIImage(named: "sad-face.png")
        self.faceView.contentMode = .scaleAspectFit
        self.faceView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.faceView)
        
        let fvTopConstraint = self.faceView.topAnchor.constraint(equalTo: self.fifthStack.bottomAnchor, constant: 30)
        let fvLeadingConstraint = self.faceView.leadingAnchor.constraint(equalTo: self.leftSpacer.leadingAnchor)
        let fvTrailingConstraint = self.faceView.trailingAnchor.constraint(equalTo: self.rightSpacer.trailingAnchor)
        
        fvTopConstraint.isActive = true
        fvLeadingConstraint.isActive = true
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
        
        //Logging comment
        print("Total has been calculated!")
    }

    func getTextInfo() {
        //Get the information of the text fields
        let billText = billField.text ?? ""
        billDouble = Double(billText) ?? 100.00
        let tipPercentText = tipPercentField.text ?? ""
        tipPercentDouble = Double(tipPercentText) ?? 16.00
        let numOfPeopleText = numOfPeopleField.text ?? ""
        numPeopleDouble = Double(numOfPeopleText) ?? 1.00
        
        //Logging comment
        print("Bill info obtained!")
        
    }
}

