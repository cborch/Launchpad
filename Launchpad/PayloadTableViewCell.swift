//
//  PayloadTableViewCell.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/8/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//

import UIKit

class PayloadTableViewCell: UITableViewCell {

    
    @IBOutlet weak var payloadImageView: UIImageView!
    @IBOutlet weak var orbitLabel: UILabel!
    @IBOutlet weak var periapsisLabel: UILabel!
    @IBOutlet weak var apoapsisLabel: UILabel!
    @IBOutlet weak var earthGlyphImageView: UIImageView!
    @IBOutlet weak var regimeLabel: UILabel!
    
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var inclinationLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var eccentricityLabel: UILabel!
    
    
    
    
    func setCell(payloadImage: String, orbit: String, periapsis: Float, apoapsis: Float, earthGlyph: String, regime: String, customer: String, nationality: String, manufacturer: String, type: String, mass: Float, inclination: Float, period: Float, eccentrcity: Float) {
        orbitLabel.text = orbit
        print("\(Int(round(periapsis / 10)) * 10)K")
        periapsisLabel.text = "\(Int(round(periapsis / 10)) * 10)K"
        apoapsisLabel.text = "\(Int(round(apoapsis / 10)) * 10)K"
        regimeLabel.text = regime.replacingOccurrences(of: "-", with: " ")
        customerLabel.text = customer
        nationalityLabel.text = nationality
        manufacturerLabel.text = manufacturer
        typeLabel.text = type
        massLabel.text = "\(mass)"
        inclinationLabel.text = "\(inclination)"
        periodLabel.text = "\(period)"
        eccentricityLabel.text = "\(eccentrcity)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
