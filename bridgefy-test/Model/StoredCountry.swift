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
    let callingCodes = List<String>()
    @objc dynamic var capital: String?
    @objc dynamic var region: String?
    @objc dynamic var subregion: String?
    @objc dynamic var population: Int = 0
    let latlng = List<Double>()
    @objc dynamic var area: Double = 0.0
    let timezones = List<String>()
    let borders = List<String>()
    @objc dynamic var nativeName: String?
    let currencies = List<String>()
    let languages = List<String>()
}
