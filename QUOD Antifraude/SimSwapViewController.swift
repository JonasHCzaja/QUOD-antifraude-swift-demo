//
//  SimSwapViewController.swift
//  QUOD Antifraude
//
//  Created by Jonas Czaja on 02/12/24.
//

import UIKit

class SimSwapViewController: UIViewController {

    @IBOutlet weak var phoneNumberTf: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var resultLb: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var loadingTextTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    @IBAction func checkSimSwap(_ sender: UIButton) {
        guard let phoneNumber = phoneNumberTf.text, !phoneNumber.isEmpty else {
            resultLb.text = "Por favor, insira um número de telefone."
            resultLb.textColor = .systemRed
            return
        }
        
        resultLb.text = "Verificando SIM Swap..."
        resultLb.textColor = .lightGray
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        startLoadingTextAnimation()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            self.stopLoadingTextAnimation()
            
            let simSwapDetected = Bool.random()
            if simSwapDetected {
                self.resultLb.text = "Troca de SIM detectada. Atenção necessária!"
                self.resultLb.textColor = .systemRed
            } else {
                self.resultLb.text = "Nenhuma troca de SIM detectada. Dispositivo seguro."
                self.resultLb.textColor = .systemGreen
            }
        }
    }
    
    private func startLoadingTextAnimation() {
           var dots = 0
           loadingTextTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
               if dots < 3 {
                   self.resultLb.text = "Verificando SIM Swap" + String(repeating: ".", count: dots + 1)
                   dots += 1
               } else {
                   dots = 0
                   self.resultLb.text = "Verificando SIM Swap"
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
