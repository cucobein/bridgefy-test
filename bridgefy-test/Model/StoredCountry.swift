//
//  StoredCountry.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 30/03/21.
//

import Foundation
import RealmSwift

class StoredCountry: Object {

    @objc dynamic var name: String?
    @objc dynamic var alpha2Code: String?
    @objc dynamic var alpha3Code: String?
    var callingCodes = List<String>?(nil)
    @objc dynamic var capital: String?
    @objc dynamic var region: String?
    @objc dynamic var subregion: String?
    @objc dynamic var population: Int = 0
    var latlng = List<Double>?(nil)
    @objc dynamic var area: Double = 0.0
    var timezones = List<String>?(nil)
    var borders = List<String>?(nil)
    @objc dynamic var nativeName: String?
    var currencies = List<String>?(nil)
    var languages = List<String>?(nil)
}
