//
//  QRCodeScanViewController.swift
//  BFL Authenticator
//
//  Created by Jakub Dolejs on 28/03/2018.
//  Copyright © 2018 Applied Recognition Inc. All rights reserved.
//

import UIKit
import AVFoundation

public class QRCodeScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    public weak var delegate: QRCodeScanViewControllerDelegate?
    public var prompt: String?
    
    public static func create() -> QRCodeScanViewController {
        let storyboard = UIStoryboard(name: "QRCode", bundle: Bundle(for: QRCodeScanViewController.self))
        return storyboard.instantiateInitialViewController() as! QRCodeScanViewController
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBOutlet var cameraView: UIView!
    @IBOutlet var promptLabel: UILabel!
    var captureSession: AVCaptureSession!
    lazy var barcodeScanQueue: DispatchQueue = {
        let queue = DispatchQueue.init(label: "com.appliedrec.qrcodescan")
        return queue
    }()
    var avCaptureVideoOrientation: AVCaptureVideoOrientation {
        switch UIApplication.shared.statusBarOrientation {
        case .portraitUpsideDown:
            return AVCaptureVideoOrientation.portraitUpsideDown
        case .landscapeRight:
            return AVCaptureVideoOrientation.landscapeRight
        case .landscapeLeft:
            return AVCaptureVideoOrientation.landscapeLeft
        default:
            return AVCaptureVideoOrientation.portrait
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let prompt = self.prompt {
            self.promptLabel.text = prompt
        }
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startCamera()
    }
    
    func startCamera() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            self.startScan()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.startScan()
                } else {
                    self.showCameraAccessDenied()
                }
            }
        case .denied:
            self.showCameraAccessDenied()
        case .restricted:
            self.showCameraAccessRestricted()
        @unknown default:
            fatalError()
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopCamera()
    }
    
    @IBAction func restartQRCodeScan(_ segue: UIStoryboardSegue) {
        
    }
    
    func showCameraAccessDenied() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "denied", sender: nil)
        }
    }
    
    func showCameraAccessRestricted() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "restricted", sender: nil)
        }
    }
    
    private func startScan() {
        self.barcodeScanQueue.async {
            self.captureSession = AVCaptureSession()
            guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                return
            }
            guard let videoInput = try? AVCaptureDeviceInput(device: camera) else {
                return
            }
            do {
                try camera.lockForConfiguration()
                if camera.isAutoFocusRangeRestrictionSupported {
                    camera.autoFocusRangeRestriction = .near
                }
                if camera.isFocusModeSupported(AVCaptureDevice.FocusMode.continuousAutoFocus) {
                    camera.focusMode = .continuousAutoFocus
                } else if camera.isFocusModeSupported(AVCaptureDevice.FocusMode.autoFocus) {
                    camera.focusMode = .autoFocus
                }
                if camera.isFocusPointOfInterestSupported {
                    camera.focusPointOfInterest = CGPoint(x: 0.5, y: 0.5)
                }
                camera.unlockForConfiguration()
            } catch {
                
            }
            if self.captureSession.canAddInput(videoInput) {
                self.captureSession.addInput(videoInput)
            }
            let barcodeOutput = AVCaptureMetadataOutput()
            barcodeOutput.setMetadataObjectsDelegate(self, queue: self.barcodeScanQueue)
            if self.captureSession.canAddOutput(barcodeOutput) {
                self.captureSession.addOutput(barcodeOutput)
                if barcodeOutput.availableMetadataObjectTypes.contains(where: { (val) -> Bool in return val == AVMetadataObject.ObjectType.qr }) {
                    barcodeOutput.metadataObjectTypes = [.qr]
                }
            }
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                let previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer.frame = self.cameraView.bounds
                if previewLayer.connection != nil && previewLayer.connection!.isVideoOrientationSupported {
                    previewLayer.connection!.videoOrientation = self.avCaptureVideoOrientation
                }
                self.cameraView.layer.masksToBounds = true
                while let sub = self.cameraView.layer.sublayers?.first {
                    sub.removeFromSuperlayer()
                }
                self.cameraView.layer.addSublayer(previewLayer)
            }
        }
    }
    
    func stopCamera() {
        self.barcodeScanQueue.async {
            if self.captureSession != nil {
                self.captureSession.stopRunning()
                self.captureSession = nil
            }
        }
    }
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let codeValue = (metadataObjects.first(where: { $0 is AVMetadataMachineReadableCodeObject && $0.type == AVMetadataObject.ObjectType.qr }) as? AVMetadataMachineReadableCodeObject)?.stringValue {
            self.stopCamera()
            DispatchQueue.main.async {
                self.delegate?.qrCodeScanViewController(self, didScanQRCode: codeValue)
                self.delegate = nil
            }
        }
    }
}

public protocol QRCodeScanViewControllerDelegate: class {
    func qrCodeScanViewController(_ viewController: QRCodeScanViewController, didScanQRCode value: String)
}
