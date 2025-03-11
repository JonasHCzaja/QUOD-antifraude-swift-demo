//
//  BiometriaFacialViewController.swift
//  QUOD Antifraude
//
//  Created by Jonas Czaja on 02/12/24.
//

import UIKit

class BiometriaFacialViewController: UIViewController {
    
    @IBOutlet weak var faceIv: UIImageView!
    @IBOutlet weak var resultLb: UILabel!
    @IBOutlet weak var validateBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var loadingTextTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLb.text = ""
        activityIndicator.isHidden = true
        
    }
    
    @IBAction func validateFace(_ sender: UIButton) {
        resultLb.text = "Capturando face..."
        resultLb.textColor = .lightGray
        validateBtn.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        animatetFace()
        startLoadingTextAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.faceIv.layer.removeAllAnimations()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            self.stopLoadingTextAnimation()
            
            let success = Bool.random()
            self.resultLb.text = success ? "Face válida" : "Face inválida"
            self.resultLb.textColor = success ? .systemGreen : .systemRed
            self.validateBtn.isEnabled = true
        }
        
    }
    
    private func animatetFace() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations:{
            self.faceIv.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            self.faceIv.transform = .identity
        }
    }
        
    
    private func startLoadingTextAnimation() {
           var dots = 0
           loadingTextTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
               if dots < 3 {
                   self.resultLb.text = "Capturando face" + String(repeating: ".", count: dots + 1)
                   dots += 1
               } else {
                   dots = 0
                   self.resultLb.text = "Capturando face"
               }
           }
       }

       
       private func stopLoadingTextAnimation() {
           loadingTextTimer?.invalidate()
           loadingTextTimer = nil
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
