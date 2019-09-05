//
//  SelectItemViewController.swift
//  Post Plus
//
//  Created by Tech World on 14/8/19.
//  Copyright © 2019 Tech World. All rights reserved.
//

import UIKit

class SelectItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         createPickerView()
        closePickerView()
        // Do any additional setup after loading the view.
    }
    
    // UI views Decalration Variables Start:
    
    // Number of Items Text Editor View
    @IBOutlet weak var NumberOfItems: UITextField!
    
    // Item 1 Outlet Variable
    @IBOutlet weak var Item1: UITextField!
    
    // Item 2 Outlet Variable
    @IBOutlet weak var Item2: UITextField!
    
    // Item 3 Outlet Variable
    @IBOutlet weak var Item3: UITextField!
    
    // Item 4 Outlet Variable
    @IBOutlet weak var Item4: UITextField!
    
    // Item 5 Outlet Variable
    @IBOutlet weak var Item5: UITextField!
    
    // UI views Decalration Variables End --
    
    // Variables for the Fnctions Start:
    
    var selectedItem: String?
    var itemTypes = ["Mail", "Clothing", "Food", "Drinks"]
    
    // Variables for the Functions End --
    
    // Functions Start:
    
    // Stepper View, Plus MInus Button in the App
    @IBAction func PlusMinus(_ sender: UIStepper) {
        // Plus Minus Button Logic
        NumberOfItems.text = String(Int(sender.value))
    }
    
    // Default Method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Default Method
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemTypes.count
    }
    
    //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemTypes[row]
    }
    
    // To show the Selected Item in the Text Field
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = itemTypes[row]
        
        // When Item1 Details are Editing, print the Selected Item
        if Item1.isEditing {
        Item1.text = selectedItem
        }
        
        // When Item2 Details are Editing, print the Selected Item
        if Item2.isEditing {
            Item2.text = selectedItem
        }
        
        // When Item3 Details are Editing, print the Selected Item
        if Item3.isEditing {
            Item3.text = selectedItem
        }
        
        // When Item4 Details are Editing, print the Selected Item
        if Item4.isEditing {
            Item4.text = selectedItem
        }
        
        // When Item5 Details are Editing, print the Selected Item
        if Item5.isEditing {
            Item5.text = selectedItem
        }
        
    }
    
    // To create ea Picker View
    func createPickerView() {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        Item1.inputView = pickerView
        Item2.inputView = pickerView
        Item3.inputView = pickerView
        Item4.inputView = pickerView
        Item5.inputView = pickerView
    }
    
    // To close a Picker View
    func closePickerView() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dissmissKeyBoard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        Item1.inputAccessoryView = toolBar
        Item2.inputAccessoryView = toolBar
        Item3.inputAccessoryView = toolBar
        Item4.inputAccessoryView = toolBar
        Item5.inputAccessoryView = toolBar
    }
    
    // To end the Editing
    @objc func dissmissKeyBoard() {
        view.endEditing(true)
    }
    
    // Functions End --
    
    /*
     // Resources:
     
      // 1. Stepper View Basics : https://www.youtube.com/watch?v=eEJbh-2qwz4
     // 2. Pickker View Basics : https://www.youtube.com/watch?v=FuWPOZIwTdU
     
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
