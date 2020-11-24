//
//  QRSacnnerVC.swift
//  Scanner
//
//  Created by Pooja on 24/11/20.
//

import AVFoundation
import UIKit

class QRSacnnerVC: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startScanner() {
        DispatchQueue.main.async {
            self.captureSession = AVCaptureSession()
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput
            
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }
            
            if (self.captureSession.canAddInput(videoInput)) {
                self.captureSession.addInput(videoInput)
            } else {
                self.failed()
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (self.captureSession.canAddOutput(metadataOutput)) {
                self.captureSession.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr]
            } else {
                self.failed()
                return
            }
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session:self.captureSession)
            self.previewLayer.frame = self.view.layer.bounds
            self.previewLayer.videoGravity = .resizeAspectFill
            self.view.layer.addSublayer(self.previewLayer)
            self.captureSession.startRunning()
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        self.captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//
//        if (captureSession?.isRunning == false) {
//            self.captureSession.startRunning()
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            self.captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        self.captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
    func found(code: String) {
        DispatchQueue.main.async {
            print(code)
            self.previewLayer.removeFromSuperlayer()
            self.captureSession.stopRunning()
            self.showAlert("Bar code with data \(code) has been scanned!")
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func showAlert(_ message: String? = "Scanned Successfully") {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                        switch action.style {
                                        case .default:
                                            print("default")
                                        case .cancel:
                                            print("cancel")
                                        case .destructive:
                                            print("destructive")
                                        @unknown default:
                                            break
                                        }}))
        self.present(alert, animated: true, completion: nil)
    }
}
