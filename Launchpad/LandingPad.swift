//
//  LandingPad.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/6/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//

import Foundation

struct LandingPad {
    var fullName: String = ""
    var status: String = ""
    var location: String = ""
    var region: String = ""
    var wikiLink: String = ""
    var description: String = ""
    var attemptedLandings: Int = 0
    var succesfulLandings: Int = 0
    var lat: Float = 0
    var long: Float = 0
}
