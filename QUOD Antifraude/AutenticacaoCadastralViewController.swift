//
//  AutenticacaoCadastralViewController.swift
//  QUOD Antifraude
//
//  Created by Jonas Czaja on 02/12/24.
//

import UIKit

class AutenticacaoCadastralViewController: UIViewController {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var cpfTf: UITextField!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var validateBtn: UIButton!
    @IBOutlet weak var resultLb: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLb.text = "Preencha os dados para validação."
        activityIndicator.isHidden = true
    }
    
    @IBAction func validateData(_ sender: UIButton) {
        guard
            let name = nameTf.text, !name.isEmpty,
            let cpf = cpfTf.text, !cpf.isEmpty,
            let address = addressTf.text, !address.isEmpty,
            let phone = phoneTf.text, !phone.isEmpty
        else {
            resultLb.text = "Por favor, preencha todos os campos."
            resultLb.textColor = .systemRed
            return
        }
        
        resultLb.text = "Validando dados..."
        resultLb.textColor = .lightGray
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            let validationSuccess = Bool.random()
            if validationSuccess {
                self.resultLb.text = "Dados autenticados com sucesso!"
                self.resultLb.textColor = .systemGreen
            } else {
                self.resultLb.text = "Falha na autenticação dos dados."
                self.resultLb.textColor = .systemRed
            }
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
