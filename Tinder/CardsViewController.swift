//
//  CardsViewController.swift
//  Tinder
//
//  Created by Avinash Singh on 06/04/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    var cardInitialCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var touch: CGPoint!
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        touch = location
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            cardInitialCenter = photoView.center
            print("Gesture began")
        }
        else if sender.state == .changed {
            if (touch.y < photoView.frame.height/2)
            { photoView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                photoView.transform = CGAffineTransform(rotationAngle: CGFloat(Double(translation.x) * M_PI / 560))
            }
            else {
                photoView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                photoView.transform = CGAffineTransform(rotationAngle: CGFloat(-1.0 * Double(translation.x) * M_PI / 560))
            }
            
            if(translation.x > 175 || translation.x < -175) {
                UIView.animate(withDuration: 0.4, animations: {
                    self.photoView.alpha = 0
                })
            }
            print("Gesture is changing")
        }
        else if sender.state == .ended {
            
            photoView.center = CGPoint(x: cardInitialCenter.x, y: cardInitialCenter.y)
            photoView.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
            
            print("Gesture ended")
        }
    }

    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
     self.performSegue(withIdentifier: "profileSegue", sender: sender)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! ProfileViewController
        vc.image = photoView.image
    }
    

}
