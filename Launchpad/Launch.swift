//
//  Launch.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/4/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//
//
import Foundation

class Launch {
    var flightNumber = 0
    var missionName = "Mission Name"
    var launchYear = "1999"
    var vehicleBlock = 99
    var launchDateUnix = 0000000000.0
    var launchDateLocal = "July 04"
    var launchTime = "12:12pm"
    var rocketType = "Eagle 10"
    var serial = "12345"
    var previousFlights = -1
    var reused = false
    var landingIntent = false
    var landingType = "ADD"
    var landingVehicle = "Ground"
    var payloadArray:[Payload]
    var timeZone = "EST"
    var padName = "KSC"
    
    
    var siteName = "VAB"
    var siteNameLong = "Vehicle Assembley Building"
    var missionDetails = "This mission will launch a rocket"
    var link = "http"
    var upcoming = false
    
    init(flightNumber: Int, missionName: String, launchYear: String, vehicleBlock: Int, launchDateUnix: Double, launchDateLocal: String, rocketType: String, serial: String, previousFlights: Int, reused: Bool, landingIntent: Bool, landingType: String, landingVehicle: String, payloadArray: [Payload], siteName: String, siteNameLong: String, missionDetails: String, link: String, upcoming: Bool, launchTime: String, timeZone: String, padName: String) {
        self.flightNumber = flightNumber
        self.missionName = missionName
        self.launchYear = launchYear
        self.vehicleBlock = vehicleBlock
        self.launchDateUnix = launchDateUnix
        self.launchDateLocal = launchDateLocal
        self.rocketType = rocketType
        self.serial = serial
        self.previousFlights = previousFlights
        self.reused = reused
        self.landingIntent = landingIntent
        self.landingType = landingType
        self.landingVehicle = landingVehicle
        self.payloadArray = payloadArray
        self.siteName = siteName
        self.siteNameLong = siteNameLong
        self.link = link
        self.upcoming = upcoming
        self.missionDetails = missionDetails
        self.launchTime = launchTime
        self.timeZone = timeZone
        self.padName = padName
    }
    
    
    
    
}
