//
//  RecordVideoViewController.swift
//  FaceIDPOC
//
//  Created by Rajaselvan Thangaraj on 09/01/19.
//  Copyright © 2019 Rajaselvan Thangaraj. All rights reserved.
//

import UIKit
import PBJVision
import PMAlertController

class RecordVideoViewController: UIViewController {

    @IBOutlet weak var faceDetectorWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var faceDetectorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var cameraView: UIView!
    
    var timer = Timer()
    var count = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        // preview and AV layer
        let vision = PBJVision.sharedInstance()
        vision.delegate = self
        vision.cameraMode = .video
        vision.cameraOrientation = .portrait
        vision.focusMode = .autoFocus
        vision.outputFormat = .square
        vision.cameraDevice = .front
    }
    

    override func viewDidLayoutSubviews() {
        let previewView = UIView()
        previewView.frame = cameraView.bounds
        let previewLayer = PBJVision.sharedInstance().previewLayer
        previewLayer.frame = previewView.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.cornerRadius = 20.0
        previewView.layer.addSublayer(previewLayer)
        cameraView.addSubview(previewView)
    }

    @IBAction func recordButtonAction(_ sender: Any) {
        self.recordButton.isHidden = true
        self.cameraView.isHidden = false
        self.timerLabel.isHidden = false
        PBJVision.sharedInstance().startVideoCapture()
        PBJVision.sharedInstance().startPreview()
    }
    
    
    @objc func update() {
        
        if(count > 0)
        {
            count = count - 1
            timerLabel.text = String(count)
        } else {
            timer.invalidate()
            PBJVision.sharedInstance().endVideoCapture()
            PBJVision.sharedInstance().stopPreview()
            self.cameraView.isHidden = true
            let alertVC = PMAlertController(title: "Success", description: "Your video has been uploaded. You can login using Face ID next time.", image: UIImage(named: "uploadSuccess"), style: .alert)
            
        
            alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
                self.timerLabel.isHidden = true
            }))
            
            self.present(alertVC, animated: true, completion: nil)
        }}
    
}


extension RecordVideoViewController: PBJVisionDelegate {
    func visionDidEndVideoCapture(_ vision: PBJVision) {
        
    }
}
