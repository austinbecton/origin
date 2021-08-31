//
//  InitialViewController.swift
//  WeatherSnapshot
//
//  Created by Austin Becton on 8/10/21.
//

import UIKit

class InitialViewController: UIViewController {

    
    
    @IBOutlet weak var sunLoadingView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
                
        //self.sunLoadingView.rotateView(targetView: sunLoadingView, duration: 1)
        
        self.sunLoadingView.rotate360Degrees()
        
        pushToMainViewController()
        
        
            
    }
    
    func pushToMainViewController() {
        
        let currentStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let newVC = currentStoryboard.instantiateViewController(withIdentifier: "MainViewController")
            
        
        navigationController?.pushViewController(newVC, animated: true)
    
       
    }
 
    
    
    
            
            
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

    extension UIImageView {
        
        func rotate360Degrees(duration: CFTimeInterval = 0.8) {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            let radians = CGFloat.pi / 4
            rotateAnimation.fromValue = radians
            rotateAnimation.toValue = radians + .pi
            rotateAnimation.isRemovedOnCompletion = false
            rotateAnimation.duration = duration
            rotateAnimation.repeatCount=Float.infinity
            self.layer.add(rotateAnimation, forKey: nil)
        }


        func rotateView(targetView: UIView, duration: Double) {
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
                targetView.transform = targetView.transform.rotated(by: 1)
            })
            
            
        }
        
    }
