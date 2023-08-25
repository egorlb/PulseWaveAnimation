//
//  ViewController.swift
//  PulseWaveAnimation
//
//  Created by Egor Laba on 24.08.23.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var plusButton: PulseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        plusButton.createPulseAnimation()
        
    }
    
    @objc private func willEnterForegroundNotification() {
        plusButton.createPulseAnimation()
    }
}
