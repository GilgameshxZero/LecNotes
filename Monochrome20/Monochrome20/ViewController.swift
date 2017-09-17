//
//  ViewController.swift
//  Monochrome20
//
//  Created by Gilgamesh on 9/16/17.
//  Copyright © 2017 Rain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var nameTextField: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// handle the text field's user input through delegate callbacks 
		
		nameTextField.delegate=self
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	//UITextFieldDelegate
	func textFieldShouldReturn(_ nameTextField: UITextField) ->Bool {
		nameTextField.resignFirstResponder()
		return true
	}
	func textFieldDidEndEditing(_ nameTextField: UITextField){
		label.text=nameTextField.text
	}

	@IBAction func button(_ sender: UIButton) {
		label.text = nameTextField.text
		nameTextField.resignFirstResponder()
	}
}

