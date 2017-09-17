//
//  InputViewController.swift
//  LecNotes
//
//  Created by Raymond Huffman on 9/17/17.
//  Copyright © 2017 Raymond Huffman. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UITextFieldDelegate {

    //MARK: properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var className = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // handle text input
        nameTextField.delegate = self
        photoImageView.image = mainInstance.tempImgData
        self.nameTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ nameTextField: UITextField) -> Bool {
        //hide keyboard
        nameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ nameTextField: UITextField) {
        className = nameTextField.text!
        savePicture()
    }

    func savePicture () {
        //print ("we are here")
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let day = calendar.component(.day, from: date)
        let timestamp = String(day) + ":" + String(hour) + ":" + String(minutes)
        
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(className)
        print(paths)
        let imageData = UIImageJPEGRepresentation(mainInstance.tempImgData!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        
        self.performSegue (withIdentifier: "segueClassToCam", sender: nameTextField)
    }
}
