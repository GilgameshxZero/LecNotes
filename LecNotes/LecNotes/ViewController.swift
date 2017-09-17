//
//  ViewController.swift
//  LecNotes
//
//  Created by Raymond Huffman on 9/17/17.
//  Copyright © 2017 Raymond Huffman. All rights reserved.
//

import UIKit
import os.log
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var previewView: UIView!
    
    var img: LecImage?
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //swipeGestureRecognizer = MySwipeGestureRecognizer(target: self, swipeLeftSegue: "yourSwipeLeftSegue", swipeRightSeque: "yourSwipeRightSegue")
        //view.addGestureRecognizer(swipeGestureRecognizer!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Navigation
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIButton, button === button else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type:.debug)
            return
        }
        
    }*/
    
    @IBAction func clickCollection(_ sender: UIButton) {
        self.performSegue (withIdentifier: "segueToCollection", sender: sender)
    }
    
    @IBAction func takePicture(_ sender: UIButton) {
        if let videoConnection = stillImageOutput?.connection(withMediaType: AVMediaTypeVideo) {
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection) {
                (imageDataSampleBuffer, error) -> Void in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                
                //let photo = UIImage(data: imageData!)
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let day = calendar.component(.day, from: date)
                let timestamp = String(day) + ":" + String(hour) + ":" + String(minutes)
                //print (timestamp)
                
                mainInstance.tempImgData = UIImage (data: imageData!)!
                self.performSegue (withIdentifier: "segueToClass", sender: sender)
                
                //UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, nil, nil, nil)
                
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Setup your camera here...
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetPhoto
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            // ...
            // The remainder of the session setup will go here...
        }
        
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        if session!.canAddOutput(stillImageOutput) {
            session!.addOutput(stillImageOutput)
            // ...
            // Configure the Live Preview here...
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
        videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        previewView.layer.addSublayer(videoPreviewLayer!)
        session!.startRunning()
        
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        videoPreviewLayer!.frame = previewView.bounds
    }
}

