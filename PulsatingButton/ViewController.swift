//
//  ViewController.swift
//  PulsatingButton
//
//  Created by Julio Collado on 3/15/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var youtubeImage: UIImageView!
    @IBOutlet weak var nukeButton: UIImageView!
    @IBOutlet weak var shieldButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNukeButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupYoutubeImage()
        setupBottonButton()
    }
    
    func setupBottonButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.createBurble()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.createBurble()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.createBurble()
                }
            }
        }
    }
    
    func createBurble() {
        let rad = self.shieldButton.frame.size.height
        let pulse = BurblePulse(radius: rad, position: self.shieldButton.center)
        self.view.layer.insertSublayer(pulse, below: self.shieldButton.layer)
        
    }
    
    func setupYoutubeImage() {
        let rad = youtubeImage.frame.size.height
        let pulse = Pulsing(radius: rad, position: youtubeImage.center)
        
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.red.cgColor
        
        self.view.layer.insertSublayer(pulse, below: youtubeImage.layer)
        
    }
    
    func setupNukeButton() {
        nukeButton.isUserInteractionEnabled = true
        let squareTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addTapPulseAnimation))
        nukeButton.addGestureRecognizer(squareTapGestureRecognizer)
    }
    
    @objc func addTapPulseAnimation(){
        let pulse = Pulsing(radius: 110, position: nukeButton.center, numberOfPulses: 1)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.blue.cgColor
        
        self.view.layer.insertSublayer(pulse, below: nukeButton.layer)
        
    }
    
}

