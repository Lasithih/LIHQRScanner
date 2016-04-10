//
//  ViewController.swift
//  LIHQRScanner
//
//  Created by Lasith Hettiarachchi on 04/10/2016.
//  Copyright (c) 2016 Lasith Hettiarachchi. All rights reserved.
//

import UIKit
import LIHQRScanner

class ViewController: UIViewController, LIHQRScannerDelegate {
    
    
    private var qrScanner: LIHQRScanner?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.qrScanner = LIHQRScanner()
        self.qrScanner?.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.qrScanner?.initialize(videoContainer: self.view)
        self.qrScanner?.startSession(nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func qrDetected(qrString: String?, error: NSError?) {
        
        if let qrCode = qrString {
            print(qrCode)
        }
    }
}

