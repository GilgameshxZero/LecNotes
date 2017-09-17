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
	@IBAction func takePicture(_ sender: UIButton) {
		if let videoConnection = stillImageOutput?.connection(withMediaType: AVMediaTypeVideo) {
			stillImageOutput?.captureStillImageAsynchronously(from: videoConnection) {
				(imageDataSampleBuffer, error) -> Void in
				let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
				UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, nil, nil, nil)
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

