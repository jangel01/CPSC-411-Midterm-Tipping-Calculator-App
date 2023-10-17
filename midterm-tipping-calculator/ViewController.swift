//
//  ViewController.swift
//  midterm-tipping-calculator
//
//  Created by Jason Angel on 10/11/23.
//

import UIKit

class ViewController: UIViewController {
    
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
        perPersonTip.text = "$0.00"
        perPersonTotal.text = "$0.00"
        
    }
    
    @IBAction func calcTips(_ sender: UITextField) {
        //Get the information of the text fields
        getTextInfo()
        
        //Calculate the total tips divided by amount of people
        let tipCalc = (billDouble * (tipPercentDouble / 100)) / numPeopleDouble
        
        //Turn it into a string and add the $ infront
        var tipCalcText = String(tipCalc)
        tipCalcText = "$" + tipCalcText
        perPersonTip.text = tipCalcText
        
        //Logging comment
        print("Tip has been calculated!")
    }
    
    @IBAction func calcTotal(_ sender: UITextField) {
        //Get the information of the text fields
        getTextInfo()
        
        //Calculate the total divided by amount of people
        let totalCalc = (billDouble + (billDouble * (tipPercentDouble / 100))) / numPeopleDouble
        
        //Turn it into a string and add the $ infront
        var totalCalcText = String(totalCalc)
        totalCalcText = "$" + totalCalcText
        perPersonTotal.text = totalCalcText
        
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

