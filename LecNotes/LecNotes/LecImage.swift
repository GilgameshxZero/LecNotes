//
//  LecImage.swift
//  LecNotes
//
//  Created by Raymond Huffman on 9/17/17.
//  Copyright © 2017 Raymond Huffman. All rights reserved.
//

import UIKit

class LecImage {
    
    //MARK: properties
    
    var name: String
    var photo: UIImage
    var date: String
    
    
    init?(name: String, photo: UIImage, date: String){
        if name.isEmpty{
            return nil
        }
        self.name = name
        self.photo = photo
        self.date = date
        
    }
}
