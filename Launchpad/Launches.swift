//
//  Launches.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/5/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.


import Foundation
import Alamofire
import SwiftyJSON

class Launches {
   
    var apiURL = "https://api.spacexdata.com/v3/launches"
    var launchArray: [Launch] = []
    
    
    
    
    
    
    func getLaunches(completed: @escaping () -> ()) {
        var upcomingIndex = 1000000
        
        Alamofire.request(apiURL).responseJSON { (response) in
            //print("*** JSON = \(response)")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let totalLaunches = json.count
                print(totalLaunches)
                for index in 0..<totalLaunches {
                    let upcoming = json[index]["upcoming"].boolValue
                    if upcoming {
                        upcomingIndex = index
                    }
                    if index >= upcomingIndex {
                        let flightNumber = json[index]["flight_number"].intValue
                        let missionName = json[index]["mission_name"].stringValue
                        
                        let launchYear = json[index]["launch_year"].stringValue
                        // Will not work properly if a vehicle has more than one core
                        let vehicleBlock = json[index]["rocket"]["first_stage"]["cores"][0]["block"].intValue
                        let launchDateUnix = json[index]["launch_date_unix"].doubleValue
                        
                        // Date and time processing
                        
                        let date = Date(timeIntervalSince1970: launchDateUnix)
                        let dateFormatter = DateFormatter()
                        //dateFormatter.locale = Locale(identifier: "en_US")
                        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMdd")
                        let stringLaunchDate = dateFormatter.string(from: date)
                        
                        dateFormatter.setLocalizedDateFormatFromTemplate("hh:mm a")
                        let stringLaunchTime = dateFormatter.string(from: date)
                        print(stringLaunchTime)
                        
                        dateFormatter.setLocalizedDateFormatFromTemplate("YYYY")
                        let stringLaunchYear = dateFormatter.string(from: date)

                        
                        dateFormatter.setLocalizedDateFormatFromTemplate("zzz")
                        let stringTimeZone = dateFormatter.string(from: date)

                        
                        let launchDateLocal = json[index]["launch_date_local"].stringValue
                        let rocketType = json[index]["rocket"]["rocket_name"].stringValue
                        // Will not work properly if a rocket has more than one core
                        let serial = json[index]["rocket"]["first_stage"]["cores"][0]["core_serial"].stringValue
                        // Will not work properly if a rocket has more than one core
                        // -1 issue when API returns null
                        let previousFlights = json[index]["rocket"]["first_stage"]["cores"][0]["flight"].intValue - 1
                        // Will not work properly if a rocket has more than one core
                        let reused = json[index]["rocket"]["first_stage"]["cores"][0]["reused"].boolValue
                        // Will not work properly if a rocket has more than one core
                        let landingIntent = json[index]["rocket"]["first_stage"]["cores"][0]["landing_intent"].boolValue
                        // Will not work properly if a rocket has more than one core
                        let landingType = json[index]["rocket"]["first_stage"]["cores"][0]["landing_type"].stringValue
                        // Will not work properly if a rocket has more than one core
                        let landingVehicle = json[index]["rocket"]["first_stage"]["cores"][0]["landing_vehicle"].stringValue
                        let siteName = json[index]["launch_site"]["site_name"].stringValue
                        
                        // Site Name Processing
                        print(siteName)
                        let splitIndex = siteName.firstIndex(of: " ") ?? siteName.endIndex
                        let siteAbbreviation = siteName[..<splitIndex]
                        let padAbbreviation = siteName[splitIndex..<siteName.endIndex]
                        print(splitIndex)
                        print(siteAbbreviation, padAbbreviation)
                        
                        
                        let siteNameLong = json[index]["launch_site"]["site_name_long"].stringValue
                        let missionDetails = json[index]["details"].stringValue
                        let link = json[index]["links"]["video_link"].stringValue
                        
                        let payloadCount = json[index]["rocket"]["second_stage"]["payloads"].count
                        
                        var launch = Launch(flightNumber: flightNumber, missionName: missionName, launchYear: stringLaunchYear, vehicleBlock: vehicleBlock, launchDateUnix: launchDateUnix, launchDateLocal: stringLaunchDate, rocketType: rocketType, serial: serial, previousFlights: previousFlights, reused: reused, landingIntent: landingIntent, landingType: landingType, landingVehicle: landingVehicle, payloadArray: [], siteName: String(siteAbbreviation), siteNameLong: siteNameLong, missionDetails: missionDetails, link: link, upcoming: upcoming, launchTime: stringLaunchTime, timeZone: stringTimeZone, padName: String(padAbbreviation))
                        
                        
                        for j in 0..<payloadCount {
                            let payloadName = json[index]["rocket"]["second_stage"]["payloads"][j]["payload_id"].stringValue
                            let customer = json[index]["rocket"]["second_stage"]["payloads"][j]["customers"][0].stringValue
                            let nationality = json[index]["rocket"]["second_stage"]["payloads"][j]["nationality"].stringValue
                            let manufacturer = json[index]["rocket"]["second_stage"]["payloads"][j]["manufacturer"].stringValue
                            let type = json[index]["rocket"]["second_stage"]["payloads"][j]["payload_type"].stringValue
                            let mass = json[index]["rocket"]["second_stage"]["payloads"][j]["payload_mass_lbs"].floatValue
                            let orbit = json[index]["rocket"]["second_stage"]["payloads"][j]["orbit"].stringValue
                            var payload = Payload(name: payloadName, customer: customer, nationality: nationality, manufacturer: manufacturer, type: type, mass: mass, orbit: orbit)
                            
                            launch.payloadArray.append(payload)
                        }
                        
                        
                        self.launchArray.append(launch)
                       // print("appended a launch")
                       // if launch.payloadArray.count >= 2 {
                         //   print(launch.payloadArray[1])
                        //}
                        //print(launch.flightNumber, launch.missionName, launch.launchYear, launch.vehicleBlock, launch.launchDateUnix, launch.launchDateLocal, launch.rocketType, launch.serial, launch.previousFlights, launch.reused, launch.landingIntent, launch.landingType, launch.landingVehicle, launch.siteName, launch.missionDetails)
                    }
                    
                    
                    let url = json["results"][index]["url"].stringValue
                    //self.pokeArray.append(PokeData(name: name, url: url))
                    //print("\(index) \(name) \(url)")
                    
                }
            case.failure(let error):
                print("Error: failed to get data from url \(self.apiURL), error: \(error.localizedDescription)")
            }
            completed()
        }
        
    }
}
