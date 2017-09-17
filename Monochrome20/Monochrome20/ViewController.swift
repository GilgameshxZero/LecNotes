//
//  ViewController.swift
//  Monochrome20
//
//  Created by Gilgamesh on 9/16/17.
//  Copyright © 2017 Rain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	@IBOutlet weak var image: UIImageView!
	
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var text: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// handle the text field's user input through delegate callbacks 
		
		text.delegate=self
		// Do any additional setup after loading the view, typically from a nib.
	}
	@IBAction func button(_ sender: UIButton) {
		label.text = "default text"
	}
	func textFieldShouldReturn (_ text: UITextField) -> Bool {
		text.resignFirstResponder ()
		return true
	}
	func textFieldDidEndEditing (_ textField: UITextField) {
		label.text = text.text
	}
	@IBAction func gestureRecogniser(_ sender: UITapGestureRecognizer) {
		text.resignFirstResponder()
		
		// UIImagePickerController is a view controller that lets a user pick media from their photo library.
		let pick = UIImagePickerController()
		
		// Only allow photos to be picked, not taken.
		pick.sourceType = .photoLibrary
		
		// Make sure ViewController is notified when the user picks an image.
		pick.delegate = self
		present(pick, animated: true, completion: nil)
	}
	func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
	public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
		if let newimage = info[UIImagePickerControllerEditedImage] as? UIImage {
			image.image = newimage
		}
		else if let newimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			image.image = newimage
		} else{
			print("Something went wrong")
		}
		
		self.dismiss(animated: true, completion: nil)
	}
}

