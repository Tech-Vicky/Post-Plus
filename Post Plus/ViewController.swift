//
//  ViewController.swift
//  Post Plus
//
//  Created by Tech World on 10/8/19.
//  Copyright © 2019 Tech World. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To Hide the Keyboard while press on Return Key.Implementation:
        hideKeyboard()
        
        // Do any additional setup after loading the view.
    }
    
/* ---- Press Return Key - Hide Keyboard Functionality Start ---- */
    
    // UI Variables Start:
    
    @IBOutlet weak var UserID: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
    
    // Functions Start:
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // To Hide the Keyboard while press on Return Key. Definition:
    func hideKeyboard(){
        UserID.delegate = self
        UserPassword.delegate = self
    }
    
    // Functions End --
    
    // Override Functions Start:
    
    // When user touches the outside of the TextField, it will Hide
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Override Functions End --
    
    /*
     // Rescources:
     
     1. Basics: https://www.youtube.com/watch?v=ahzvP8ulebk
     */
    
/* ---- Press Return Key - Hide Keyboard Functionality End ---- */
    
    
}

