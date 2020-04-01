//
//  CameraAccessDeniedViewController.swift
//
//  Created by Jakub Dolejs on 28/03/2018.
//  Copyright © 2018 Applied Recognition Inc. All rights reserved.
//

import UIKit

class CameraAccessDeniedViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String {
            label.text = String(format: NSLocalizedString("Camera access denied. Please go to settings and enable camera for appName.", comment: ""), appName)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
