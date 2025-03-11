//
//  DocumentoscopiaViewController.swift
//  QUOD Antifraude
//
//  Created by Jonas Czaja on 02/12/24.
//

import UIKit

class DocumentoscopiaViewController: UIViewController {

    @IBOutlet weak var documentIv: UIImageView!
    @IBOutlet weak var resultLb: UILabel!
    @IBOutlet weak var captureBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var loadingTextTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLb.text = ""
        activityIndicator.isHidden = true
    }

    @IBAction func captureDocument(_ sender: UIButton) {
        resultLb.text = "Analisando documento..."
        resultLb.textColor = .lightGray
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        captureBtn.isEnabled = false
        animateDocument()
        startLoadingTextAnimation()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.documentIv.layer.removeAllAnimations()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            self.stopLoadingTextAnimation()

            let isValid = Bool.random()
            self.resultLb.text = isValid ? "Documento válido." : "Documento inválido."
            self.resultLb.textColor = isValid ? .systemGreen : .systemRed
            self.captureBtn.isEnabled = true
        }
    }
    
    private func animateDocument() {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
                self.documentIv.alpha = 0.5
            }) { _ in
                self.documentIv.alpha = 1.0
            }
        }

    
    private func startLoadingTextAnimation() {
        var dots = 0
        loadingTextTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if dots < 3 {
                self.resultLb.text = "Analisando documento" + String(repeating: ".", count: dots + 1)
                dots += 1
            } else {
                dots = 0
                self.resultLb.text = "Analisando documento"
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
