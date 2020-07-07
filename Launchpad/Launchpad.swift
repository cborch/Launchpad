//
//  Launchpad.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/6/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//

import Foundation

struct Launchpad {
    var fullName: String = ""
    var status: String = ""
    var location: String = ""
    var region: String = ""
    var lat: Float = 0
    var long: Float = 0
    var vehiclesLaunched: [String] = []
    var attempts: Int = 0
    var success: Int = 0
    var wiki: String = ""
    var description: String = ""
}
