//
//  Vehicle.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/9/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//

import Foundation

struct Vehicle {
    var active: String = ""
    var cost: Int = 10
    var successRate: Int = 10
    var height: Float = 1.0
    var diameter: Float = 1.0
    var mass: Int = 10
    var orbitalCapabilities: [OrbitalCapability] = []
    var firstStageEngines: Int = 0
    var firstStageFuel: Float = 0
    var firstStageBurnTime: Float = 0
    var firstStageThrustSeaLevel: Int = 0
    var firstStageReuable: Bool = false
    var secondStageEngines: Int = 0
    var secondStageFuel: Float = 0
    var secondStageBurnTime: Float = 0
    var secondStageThrust: Int = 0
    
    var engineName: String = ""
    var engineVersion: String = ""
    var engineLayout: String = ""
    var engineISPSeaLevel: Int = 0
    var engineISPVacuum: Int = 0
    var engineLossMax: Int = 0
    var prop1: String = ""
    var prop2: String = ""
    var thrustSeaLevel: Int = 0
    var thrustVacuum: Int = 0
    var twr: Float = 0
    var imageLinks: [String] = []
}
