//
//  VehicleDetailViewController.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/5/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class VehicleDetailViewController: UIViewController {
    
    
    @IBOutlet weak var vehicleImageView: UIImageView!
    @IBOutlet weak var thrustLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var twrLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var enginesLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var orbitLabel1: UILabel!
    @IBOutlet weak var orbitMassLabel1: UILabel!
    @IBOutlet weak var orbitLabel2: UILabel!
    @IBOutlet weak var orbitMassLabel2: UILabel!
    @IBOutlet weak var orbitLabel3: UILabel!
    @IBOutlet weak var orbitMassLabel3: UILabel!
    @IBOutlet weak var engineNameLabel: UILabel!
    @IBOutlet weak var engineLayoutLabel: UILabel!
    @IBOutlet weak var engineLossLabel: UILabel!
    @IBOutlet weak var prop1Label: UILabel!
    @IBOutlet weak var prop2Label: UILabel!
    @IBOutlet weak var seaLevelThrustLabel: UILabel!
    @IBOutlet weak var vacuumThrustLabel: UILabel!
    @IBOutlet weak var twrSmallLabel: UILabel!
    @IBOutlet weak var stage1ResuableLabel: UILabel!
    @IBOutlet weak var stage1EnginesLabel: UILabel!
    @IBOutlet weak var stage1FuelLabel: UILabel!
    @IBOutlet weak var stage1BurnTimeLabel: UILabel!
    @IBOutlet weak var stage1ThrustSeaLevel: UILabel!
    @IBOutlet weak var stage1ThrustVacuum: UILabel!
    
    @IBOutlet weak var stage2ReusableLabel: UILabel!
    @IBOutlet weak var stage2EnginesLabel: UILabel!
    @IBOutlet weak var stage2FuelLabel: UILabel!
    @IBOutlet weak var stage2BurnTimeLabel: UILabel!
    @IBOutlet weak var stage2ThrustSeaLevel: UILabel!
    @IBOutlet weak var stage2ThrustVacuum: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var heightSmallLabel: UILabel!
    @IBOutlet weak var diameteLabel: UILabel!
    
    
    
    
    var rocketID = ""
    let apiURL = "https://api.spacexdata.com/v3/rockets"
    var vehicle = Vehicle()

    override func viewDidLoad() {
        super.viewDidLoad()
        getVehicleData {
            print("Got vehicle data")
            self.populateUI()
        }


    }
    
    
    func getVehicleData(completed: @escaping () -> ()) {
        
        Alamofire.request(apiURL).responseJSON { (response) in
            //print("*** JSON = \(response)")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfVehicles = json.count
                print(numberOfVehicles)
                for index in 0..<numberOfVehicles {
                    let ID = json[index]["rocket_id"].stringValue
                    if ID == self.rocketID {
                        print("I got here")
                        // Populate landing pad struct
                        let active = json[index]["active"].stringValue
                        let cost = json[index]["cost_per_launch"].intValue
                        let successRate = json[index]["success_rate_pct"].intValue
                        let height = json[index]["height"]["feet"].floatValue
                        let diameter = json[index]["diameter"]["feet"].floatValue
                        let firstStageEngines = json[index]["first_stage"]["engines"].intValue
                        let firstStageFuel = json[index]["first_stage"]["fuel_amount_tons"].floatValue
                        let firstStageBurnTime = json[index]["first_stage"]["burn_time_sec"].floatValue
                        let firstStageThrustSeaLevel = json[index]["first_stage"]["thrust_sea_level"]["kN"].intValue
                        let firstStageReuable = json[index]["first_stage"]["reusable"].boolValue
                        let secondStageEngines = json[index]["second_stage"]["engines"].intValue
                        let secondStageFuel = json[index]["second_stage"]["fuel_amount_tons"].floatValue
                        let secondStageBurnTime = json[index]["second_stage"]["burn_time_sec"].floatValue
                        let secondStageThrust = json[index]["second_stage"]["thrust"]["kN"].intValue
                        let engineName = json[index]["engines"]["type"].stringValue
                        let engineVersion = json[index]["engines"]["version"].stringValue
                        let engineLayout = json[index]["engines"]["layout"].stringValue
                        let engineISPSeaLevel = json[index]["engines"]["isp"]["sea_level"].intValue
                        let engineISPVacuum = json[index]["engines"]["isp"]["vacuum"].intValue
                        let engineLossMax = json[index]["engines"]["engine_loss_max"].intValue
                        let prop1 = json[index]["engines"]["propellant_1"].stringValue
                        let prop2 = json[index]["engines"]["propellant_2"].stringValue
                        let thrustSeaLevel = json[index]["engines"]["thrust_sea_level"]["kN"].intValue
                        let thrustVacuum = json[index]["engines"]["thrust_vacuum"]["kN"].intValue
                        let twr = json[index]["engines"]["thrust_to_weight"].floatValue
                        
                        var orbitalCapabilities: [OrbitalCapability] = []
                        for i in 0..<json[index]["payload_weights"].count {
                            let id = json[index]["payload_weights"]["id"].stringValue
                            let name = json[index]["payload_weights"]["name"].stringValue
                            let kg = json[index]["payload_weights"]["kg"].intValue
                            let lb = json[index]["payload_weights"]["lb"].intValue
                            
                            orbitalCapabilities.append(OrbitalCapability(id: id, name: name, kg: kg, lb: lb))
                        }
                        
                        
                        var imageLinks: [String] = []
                        for i in 0..<json[index]["flickr_images"].count {
                            imageLinks.append(json[index]["flickr_images"][i].stringValue)
                        }
                        
                        self.vehicle.active = active
                        self.vehicle.cost = cost
                        self.vehicle.successRate = successRate
                        self.vehicle.height = height
                        self.vehicle.diameter = diameter
                        self.vehicle.firstStageEngines = firstStageEngines
                        self.vehicle.firstStageFuel = firstStageFuel
                        self.vehicle.firstStageBurnTime = firstStageBurnTime
                        self.vehicle.firstStageReuable = firstStageReuable
                        self.vehicle.firstStageThrustSeaLevel = firstStageThrustSeaLevel
                        self.vehicle.secondStageEngines = secondStageEngines
                        self.vehicle.secondStageFuel = secondStageFuel
                        self.vehicle.secondStageBurnTime = secondStageBurnTime
                        self.vehicle.secondStageThrust = secondStageThrust
                        self.vehicle.engineName = engineName
                        self.vehicle.engineVersion = engineVersion
                        self.vehicle.engineLayout = engineLayout
                        self.vehicle.engineISPSeaLevel = engineISPSeaLevel
                        self.vehicle.engineISPVacuum = engineISPVacuum
                        self.vehicle.engineLossMax = engineLossMax
                        self.vehicle.prop1 = prop1
                        self.vehicle.prop2 = prop2
                        self.vehicle.thrustSeaLevel = thrustSeaLevel
                        self.vehicle.thrustVacuum = thrustVacuum
                        self.vehicle.twr = twr
                        self.vehicle.orbitalCapabilities = orbitalCapabilities
                        self.vehicle.imageLinks = imageLinks
                        
                        // Success rate
                        // Thrust
                        // Mass
                        // Engines
                        // TWR
                        // Engine Loss Max
                    }
                        
                    
                }
            case.failure(let error):
                print("Error: failed to get data from url \(self.apiURL), error: \(error.localizedDescription)")
            }
            completed()
        }
        
    }
    
    func populateUI() {
        
        let imageURL = vehicle.imageLinks.randomElement()!
        if let url = URL(string: imageURL) {
        
            do {
                let data = try Data(contentsOf: url)
                vehicleImageView.image = UIImage(data: data)
        
            } catch let err {
                print("Error: \(err.localizedDescription)")
            }
        }
        
        thrustLabel.text = "\(vehicle.thrustSeaLevel)"
        massLabel.text = "\(vehicle.mass)"
        twrLabel.text = "\(vehicle.twr)"
        heightLabel.text = "\(vehicle.height)"
        enginesLabel.text = "\(vehicle.firstStageEngines)"
        successLabel.text = "\(vehicle.successRate)"
        
        orbitLabel1.text = vehicle.orbitalCapabilities[0].name
        orbitMassLabel1.text = "\(vehicle.orbitalCapabilities[0].lb)"
        
        engineNameLabel.text = vehicle.engineName + vehicle.engineVersion
        engineLayoutLabel.text = vehicle.engineLayout
        engineLossLabel.text = "\(vehicle.engineLossMax)"
        prop1Label.text = vehicle.prop1
        prop2Label.text = vehicle.prop2
        stage1ThrustVacuum.text = "\(vehicle.thrustVacuum)"
        stage1ThrustSeaLevel.text = "\(vehicle.firstStageThrustSeaLevel)"
        
        stage2EnginesLabel.text = "\(vehicle.secondStageEngines)"
        stage2FuelLabel.text = "\(vehicle.secondStageFuel)"
        stage2BurnTimeLabel.text = "\(vehicle.secondStageBurnTime)"
        stage2ThrustSeaLevel.text = "\(vehicle.secondStageThrust)"
        stage2ThrustVacuum.text = "\(vehicle.thrustVacuum)"
        
        costLabel.text = "\(vehicle.cost)"
        heightSmallLabel.text = "\(vehicle.height)"
        diameteLabel.text = "\(vehicle.diameter)"

    }
    
    



}
