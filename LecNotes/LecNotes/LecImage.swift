//
//  LecImage.swift
//  LecNotes
//
//  Created by Raymond Huffman on 9/17/17.
//  Copyright © 2017 Raymond Huffman. All rights reserved.
//

import UIKit
import os.log

class LecImage {
    
    //MARK: properties
    
    var name: String
    var photo: UIImage
    var date: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("entrys")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let date = "date"
    }
    
    //MARK: Init
    
    init?(name: String, photo: UIImage, date: String){
        guard !name.isEmpty else {
            return nil
        }

        if name.isEmpty{
            return nil
        }
        self.name = name
        self.photo = photo
        self.date = date
        
    }
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a LecImage object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String
        
        // Must call designated initializer.
        self.init(name: name, photo: photo!, date: date!)
        
    }
}
