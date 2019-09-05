//
//  SignUpViewController.swift
//  Post Plus
//
//  Created by Tech World on 14/8/19.
//  Copyright © 2019 Tech World. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

     // Override Functions Start:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To Hide the Keyboard while press on Return Key.Implementation:
        hideKeyboard()

        // Scroll Functionality Start:
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardActivity), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardActivity), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        // Scroll Functionality End --
        
        // Do any additional setup after loading the view.
    }

    /* ---- Press Return Key - Hide Keyboard Functionality Start ---- */
    
    // UI Variables Start:

    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var EmailID: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    // Functions Start:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // To Hide the Keyboard while press on Return Key. Definition:
    func hideKeyboard(){
        FirstName.delegate = self
        LastName.delegate = self
        EmailID.delegate = self
        Password.delegate = self
        ConfirmPassword.delegate = self
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

    
/* ---- Scrolling Functionality Start ---- */

    // UI Variable:
    
    @IBOutlet weak var signUpScroll: UIScrollView!
    
    // Variable:
    
    var activeTextField: UITextField!
    
    // @objc Functions:
    
    @objc func KeyboardActivity (notification: Notification){
    
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification{
            signUpScroll.contentInset = UIEdgeInsets.zero
        } else {
            signUpScroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        signUpScroll.scrollIndicatorInsets = signUpScroll.contentInset
    
    }
    
    /*
     // Rescources: - Navigation
     
     1. Scroll View Basics: https://youtu.be/6ewb40qW2wI
     2. Adjust while keyboard is enable: https://www.youtube.com/watch?v=D3sxanj3vd8
     */

/* ---- Scrolling Functionality End ---- */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
