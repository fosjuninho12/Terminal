import UIKit




var imValorHora: [String] = [""]
var imValorMes: [String] = [""]

class ViewController1: UIViewController {

    
    @IBOutlet weak var bttIniciar: UIButton!
    @IBOutlet weak var corrente: UILabel!
    @IBOutlet weak var lbKwh: UILabel!
    @IBOutlet weak var lbVoltagem: UILabel!
    
    @IBOutlet weak var imgTela1: UIImageView!
    
    
    
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbVoltagem.text = "Configurado para \(configX.voltagem)"
        
        imgTela1.alpha=0.5
    }
    
    
    @objc func pqp(){
        SensorDAO.getSensor{(sensors) in
            var testSensor = sensors.sorted(by: { return $0.timestamp > $1.timestamp })
            
            self.corrente.text = String(testSensor[0].corrente)
            self.lbKwh.text = String((testSensor[0].corrente * configX.voltagem) / 1000.00)
            self.lbVoltagem.text = ("*Configurado em \(configX.voltagem)v")
            //self.lbValor.text = String(format:"R$ %.2f",(testSensor[0].corrente) * (configX.voltagem) / (1000.00) * (configX.valor))
            let valorHora = String(format:"R$ %.2f",((testSensor[0].corrente * configX.voltagem) / 1000.00) * configX.valor)
            imValorHora.append(valorHora)
            
            setValHr = ((testSensor[0].corrente * configX.voltagem) / 1000.00) * configX.valor
            setValMes = ((((testSensor[0].corrente * configX.voltagem) / 1000.00) * configX.valor)*24)*30
            
            
        }
       
        
    }
    
    
    
    @IBAction func btIniciar(_ sender: Any) {
        if timer==nil{
            bttIniciar.setTitle("DESCONECTAR", for: .normal)
            bttIniciar.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(pqp),userInfo: nil, repeats: true)
            
            
        
        }else{
            timer.invalidate()
            timer=nil
            bttIniciar.setTitle("INICIAR MONITORAMENTO", for: .normal)
            bttIniciar.setTitleColor(UIColor.cyan, for: .normal)
            corrente.text = "00.00"
            lbKwh.text = "00.00"
            setValHr = 0.00
            setValMes = 0.00
        }
    }
}
