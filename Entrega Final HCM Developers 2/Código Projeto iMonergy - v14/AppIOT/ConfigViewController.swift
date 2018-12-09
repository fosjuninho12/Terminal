//
//  ConfigViewController.swift
//  AppIOT
//
//  Created by Heitor Machado Franco on 02/08/2018.
//  Copyright © 2018 Felipe Corte. All rights reserved.
//

import UIKit

class Conf {
    var voltagem:Float
    var valor: Float
    
    init (voltagem: Float, valor: Float){
        self.voltagem = voltagem
        self.valor = valor
        }
}

var configX = Conf(voltagem: 220, valor: 0.60)


class ConfigViewController: UIViewController {

    @IBOutlet weak var tfValor: UITextField!
    @IBOutlet weak var imgTela3: UIImageView!
    
    @IBOutlet weak var btSeg: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgTela3.alpha=0.5
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func btVoltagem(_ sender: Any) {
        if btSeg.selectedSegmentIndex == 0 {
            configX.voltagem = 220.00
        } else {
            configX.voltagem = 110.00
            //ViewController1.lbVoltagem.text = "Configurado para 110v"
        }
    }
    
    @IBAction func btGravar(_ sender: Any) {
        if tfValor.text != ""{
            configX.valor = (Float(tfValor.text!))!
            tfValor.text = "\(configX.valor)"
            view.endEditing(true)
            print("- R$\(configX.valor) -")
        } else {
            tfValor.text = "0.60"
        }
    }
    
    
    
}
