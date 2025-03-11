//
//  ScoreAntifraudeViewController.swift
//  QUOD Antifraude
//
//  Created by Jonas Czaja on 02/12/24.
//

import UIKit

class ScoreAntifraudeViewController: UIViewController {

    @IBOutlet weak var cpfTf: UITextField!
    @IBOutlet weak var calculateBtn: UIButton!
    @IBOutlet weak var resultLb: UILabel!
    @IBOutlet weak var scoreLb: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLb.textColor = .lightGray
        scoreLb.text = ""
        activityIndicator.isHidden = true
    }
    
    @IBAction func calculateScore(_ sender: UIButton) {
        guard let cpf = cpfTf.text, !cpf.isEmpty else {
            resultLb.text = "Por favor, insira um CPF válido."
            resultLb.textColor = .systemRed
            scoreLb.text = ""
            return
        }
        
        scoreLb.isHidden = true
        resultLb.text = "Calculando score..."
        resultLb.textColor = .lightGray
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            let score = Int.random(in: 1...1000)
            self.displayScore(score)
        }
    }
    
    private func displayScore(_ score: Int) {
        scoreLb.isHidden = false
        scoreLb.text = "\(score)"
        
        switch score {
        case 1...400:
            resultLb.text = "Alto risco de fraude detectado."
            resultLb.textColor = .systemRed
            scoreLb.textColor = .systemRed
            
        case 401...700:
            resultLb.text = "Risco moderado de fraude detectado."
            resultLb.textColor = .systemOrange
            scoreLb.textColor = .systemOrange
            
        case 701...1000:
            resultLb.text = "Baixo risco de fraude detectado."
            resultLb.textColor = .systemGreen
            scoreLb.textColor = .systemGreen
            
        default:
            resultLb.text = "Erro no cálculo do score."
            resultLb.textColor = .darkGray
            scoreLb.textColor = .darkGray
        }
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
