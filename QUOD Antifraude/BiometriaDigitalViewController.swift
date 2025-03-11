//
//  BiometriaDigitalViewController.swift
//  QUOD Antifraude
//
//  Created by Jonas Czaja on 02/12/24.
//

import UIKit

class BiometriaDigitalViewController: UIViewController {

    @IBOutlet weak var fingerprintIv: UIImageView!
    @IBOutlet weak var resultLb: UILabel!
    @IBOutlet weak var validateBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var loadingTextTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLb.text = ""
        activityIndicator.isHidden = true
        
    }
    
    @IBAction func validateFingerprint(_ sender: UIButton) {
        resultLb.text = "Lendo digital..."
        resultLb.textColor = .lightGray
        validateBtn.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        animateFingerprint()
        startLoadingTextAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.fingerprintIv.layer.removeAllAnimations()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true

            self.stopLoadingTextAnimation()
            
            let success = Bool.random()
            self.resultLb.text = success ? "Digital validada com sucesso!" : "Falha na validação da digital."
            self.resultLb.textColor = success ? .systemGreen : .systemRed
            self.validateBtn.isEnabled = true
        }
    }
    
    
    private func animateFingerprint() {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
                self.fingerprintIv.alpha = 0.5
            }) { _ in
                self.fingerprintIv.alpha = 1.0
            }
        }

    
    private func startLoadingTextAnimation() {
        var dots = 0
        loadingTextTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if dots < 3 {
                self.resultLb.text = "Lendo digital" + String(repeating: ".", count: dots + 1)
                dots += 1
            } else {
                dots = 0
                self.resultLb.text = "Lendo digital"
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
