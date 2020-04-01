//
//  ViewController.swift
//  QR Code Scanner Sample
//
//  Created by Jakub Dolejs on 01/04/2020.
//  Copyright © 2020 Applied Recognition. All rights reserved.
//

import UIKit
import QRCodeScanner

class ViewController: UIViewController, QRCodeScanViewControllerDelegate {
    
    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textContainer.lineBreakMode = .byClipping
    }
    
    @IBAction func scanQRCode() {
        let controller = QRCodeScanViewController.create()
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func qrCodeScanViewController(_ viewController: QRCodeScanViewController, didScanQRCode value: String) {
        self.navigationController?.popViewController(animated: true)
        self.textView.text = value
    }
    
}

