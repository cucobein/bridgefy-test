//
//  PersistenceProvider.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import Foundation
import RealmSwift
import ReactiveKit
import Bond

class PersistenceProvider {
    
    private let keyValueStorage: KeyValueStorage
    private let database: Realm
    private static let databaseEncryptionStorageKey = "dbKey"
    private static func generateDatabaseEncryptionKey() -> Data {
        let bytes = (0 ..< 64).map { _ in UInt8.random(in: 0..<255) }
        return bytes.withUnsafeBufferPointer { (buffer: UnsafeBufferPointer<UInt8>) -> Data in
            Data(buffer: buffer)
        }
    }
    private(set) var storedCountries = Observable<[StoredCountry]?>(nil)

    init(keyValueStorage: KeyValueStorage) {
        self.keyValueStorage = keyValueStorage
        var configuration = Realm.Configuration.defaultConfiguration
        if let databaseEncryptionKey = keyValueStorage.data(forKey: PersistenceProvider.databaseEncryptionStorageKey) {
            configuration.encryptionKey = databaseEncryptionKey
        } else {
            let newKey = PersistenceProvider.generateDatabaseEncryptionKey()
            keyValueStorage.set(newKey, forKey: PersistenceProvider.databaseEncryptionStorageKey)
            configuration.encryptionKey = newKey
        }
        do {
            database = try Realm(configuration: configuration)
            loadObjects()
        } catch {
            do {
                configuration.deleteRealmIfMigrationNeeded = true
                database = try Realm(configuration: configuration)
                loadObjects()
            } catch {
                fatalError("Unable to load database: \(error)")
            }
        }
    }
    
    func storeCountryData(with countryData: CountryDetail) {
        if let existing = storedCountries.value?.contains(where: { country -> Bool in
            country.name == countryData.name
        }), existing { return }
        do {
            let country = StoredCountry()
            country.name = countryData.name
            country.alpha2Code = countryData.alpha2Code
            country.alpha3Code = countryData.alpha3Code
            if let callingCodes = countryData.callingCodes {
                let codes = List<String>()
                codes.append(objectsIn: callingCodes)
                country.callingCodes = codes
            }
            country.capital = countryData.capital
            country.region = countryData.region
            country.subregion = countryData.subregion
            country.population = countryData.population ?? 0
            if let location = countryData.latlng {
                let coordinates = List<Double>()
                coordinates.append(objectsIn: location)
                country.latlng = coordinates
            }
            country.area = countryData.area ?? 0
            if let timezones = countryData.timezones {
                let times = List<String>()
                times.append(objectsIn: timezones)
                country.timezones = times
            }
            if let borders = countryData.borders {
                let brds = List<String>()
                brds.append(objectsIn: borders)
                country.timezones = brds
            }
            country.nativeName = countryData.nativeName
            if let currencies = countryData.currencies {
                let curr = List<String>()
                curr.append(objectsIn: currencies)
                country.timezones = curr
            }
            if let languages = countryData.languages {
                let langs = List<String>()
                langs.append(objectsIn: languages)
                country.timezones = langs
            }
            try database.write {
                database.add(country)
                loadObjects()
            }
        } catch {
            fatalError("Unable to save in database: \(error)")
        }
    }
    
    func deleteCountryData(with countryData: CountryDetail) {
        guard let country = storedCountries.value?.first(where: { country -> Bool in
            country.name == countryData.name
        }) else { return }
        do {
            try database.write {
                database.delete(country)
                loadObjects()
            }
        } catch {
            fatalError("Unable to save in database: \(error)")
        }
    }
    
    func retrieveCountry(countryName: String) -> CountryDetail? {
        guard let storedCountry = storedCountries.value?.first(where: { country -> Bool in
            country.name == countryName
        }) else { return nil }
        
        var callingCodes: [String]?
        if let codes = storedCountry.callingCodes {
            callingCodes = Array(codes)
        }
        var latlng: [Double]?
        if let location = storedCountry.latlng {
            latlng = Array(location)
        }
        var timezones: [String]?
        if let times = storedCountry.timezones {
            timezones = Array(times)
        }
        var borders: [String]?
        if let bords = storedCountry.borders {
            borders = Array(bords)
        }
        var currencies: [String]?
        if let currs = storedCountry.currencies {
            currencies = Array(currs)
        }
        var languages: [String]?
        if let langs = storedCountry.languages {
            languages = Array(langs)
        }

        let country = CountryDetail(
            name: storedCountry.name,
            alpha2Code: storedCountry.alpha2Code,
            alpha3Code: storedCountry.alpha3Code,
            callingCodes: callingCodes,
            capital: storedCountry.capital,
            region: storedCountry.region,
            subregion: storedCountry.subregion,
            population: storedCountry.population,
            latlng: latlng,
            area: storedCountry.area,
            timezones: timezones,
            borders: borders,
            nativeName: storedCountry.nativeName,
            currencies: currencies,
            languages: languages
        )
        return country
    }
}

private extension PersistenceProvider {
    
    func loadObjects() {
        storedCountries.value = nil
        storedCountries = Observable(Array(database.objects(StoredCountry.self)))
    }
}
