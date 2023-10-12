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
    
    var faceView: UIImageView!

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
    }
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        self.billField.resignFirstResponder()
        self.tipPercentField.resignFirstResponder()
        self.numOfPeopleField.resignFirstResponder()
    }

}

