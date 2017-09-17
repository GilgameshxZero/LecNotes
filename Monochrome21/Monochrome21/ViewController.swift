//
//  ViewController.swift
//  Monochrome21
//
//  Created by Gilgamesh on 9/17/17.
//  Copyright © 2017 rain. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	@IBOutlet weak var previewView: UIView!
	@IBOutlet weak var captureImageView: UIImageView!
	
	var session: AVCaptureSession?
	var stillImageOutput: AVCaptureStillImageOutput?
	var videoPreviewLayer: AVCaptureVideoPreviewLayer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func didTakePhoto(_ sender: UIButton) {
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
		
		videoPreviewLayer!.frame = previewView.bounds
	}
}

