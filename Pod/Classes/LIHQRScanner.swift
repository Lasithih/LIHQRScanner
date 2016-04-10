//
//  LIHQRSCanner.swift
//  Perx
//
//  Created by Lasith Hettiarachchi on 1/11/16.
//  Copyright © 2016 Lasith Hettiarachchi. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

@objc public protocol LIHQRScannerDelegate {
    
    optional func qrDetected(qrString: String?, error: NSError?)
}

public class LIHQRScanner: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    private var captureSession:AVCaptureSession?
    private var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    public var delegate: LIHQRScannerDelegate?
    
    
    public func initialize(videoContainer avLayer: UIView) {
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error:NSError?
        let input: AnyObject!
        do {
            input = try AVCaptureDeviceInput(device: captureDevice)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if (error != nil) {
            
            NSLog("\(error?.localizedDescription)")
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(input as! AVCaptureInput)
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = avLayer.layer.bounds
        if let preLayer = videoPreviewLayer {
            avLayer.layer.addSublayer(preLayer)
        }
        
    }
    
    public func startSession(completion: (()->())?) {
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            self.captureSession?.startRunning()
            dispatch_async(dispatch_get_main_queue()) {
                completion?()
            }
        }
    }
    
    public func stopSession() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { () -> Void in
            
            self.captureSession?.stopRunning()
        }
        
    }
    
    //MARK: - MetadataObjectsDelegate
    
    public func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            //let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            
            if metadataObj.stringValue != nil {
                self.stopSession()
                self.delegate?.qrDetected?(metadataObj.stringValue, error: nil)
            }
        }
        
    }
}