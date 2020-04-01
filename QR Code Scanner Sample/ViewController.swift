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
    
    /// Scan QR code
    @IBAction func scanQRCode() {
        // Create an instance of QRCodeScanViewController
        let controller = QRCodeScanViewController.create()
        // Set the view controller delegate
        controller.delegate = self
        // Push the view controller
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: QRCodeScanViewControllerDelegate
    
    /// Called when the camera scans a QR code
    /// - Parameters:
    ///   - viewController: View controller that scanned the QR code
    ///   - value: String encoded in the QR code
    func qrCodeScanViewController(_ viewController: QRCodeScanViewController, didScanQRCode value: String) {
        // Pop the view controller
        self.navigationController?.popViewController(animated: true)
        // Display the scanned value
        self.textView.text = value
    }
    
}

