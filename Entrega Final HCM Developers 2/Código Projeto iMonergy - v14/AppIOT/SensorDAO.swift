import Foundation



class Sensor {
    
    var corrente: Float
    
    var timestamp: Date
    
    init(json: [String: AnyObject]) {
        
        //Para rodar em swift 4
        //corrente = Float((json["corrente"] as? NSNumber)!)
        
        //Para rodar em swift 3
        corrente = json["corrente"] as! Float
        
        let teste = json["timestamp"] as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT-3:00") //Curretime zone
        timestamp = dateFormatter.date(from: teste)! //according to date format your date string
    }
    
}

// DAO: Data Access Object
class SensorDAO {
    
    static func getSensor(callback: @escaping (([Sensor]) -> Void)) {
        let endpoint: String = "https://medidorcorrenteeletrica.mybluemix.net/correntedata"

        guard let url = URL(string: endpoint) else {
            print("Erroooo: Cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
            if error != nil {
                print("Error = \(String(describing: error))")
                return
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(String(describing: responseString))")

            DispatchQueue.main.async() {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!) as? [[String: AnyObject]] {
                        var sensors = [Sensor]()
                        for sensorDict in json {
                            let sensor = Sensor(json: sensorDict)
                            sensors.append(sensor)
                        }
                        callback(sensors)
                    } else {
                        print("Deu erro!")
                    }
                } catch let error as NSError {
                    print("Error = \(error.localizedDescription)")
                }
            }
        })
        task.resume()
    }
    
    

}

