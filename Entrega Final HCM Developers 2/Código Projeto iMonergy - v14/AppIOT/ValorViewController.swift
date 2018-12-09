//
//  ValorViewController.swift
//  AppIOT
//
//  Created by Heitor Machado Franco on 02/08/2018.
//  Copyright © 2018 Felipe Corte. All rights reserved.
//

import UIKit

var setValHr:Float = 0.0
var setValMes:Float = 0.0



class ValorViewController: UIViewController {

    @IBOutlet weak var imgTela2: UIImageView!
    @IBOutlet weak var lbValorHora: UILabel!
    @IBOutlet weak var lbValorMes: UILabel!
    var timerr : Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btIniciar()
        imgTela2.alpha = 0.5
    }
    
    func setVal(){
        lbValorHora.text = String(format:"%.2f",setValHr)
        lbValorMes.text = String(format:"%.2f",setValMes)
    }
    
    @IBAction func btIniciar() {
        if timerr==nil{
            timerr = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(setVal),userInfo: nil, repeats: true)
        }else{
            timerr.invalidate()
            timerr=nil
            setValHr = 0.00
            setValMes = 0.00
        }
    }
    
    @IBAction func salvarPaciente(_ sender: Any) {
    }
    

}
