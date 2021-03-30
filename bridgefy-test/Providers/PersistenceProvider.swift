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
                country.callingCodes.append(objectsIn: callingCodes)
            }
            country.capital = countryData.capital
            country.region = countryData.region
            country.subregion = countryData.subregion
            country.population = countryData.population ?? 0
            if let location = countryData.latlng {
                country.latlng.append(objectsIn: location)
            }
            country.area = countryData.area ?? 0
            if let timezones = countryData.timezones {
                country.timezones.append(objectsIn: timezones)
            }
            if let borders = countryData.borders {
                country.borders.append(objectsIn: borders)
            }
            country.nativeName = countryData.nativeName
            if let currencies = countryData.currencies {
                country.currencies.append(objectsIn: currencies)
            }
            if let languages = countryData.languages {
                country.languages.append(objectsIn: languages)
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
        let country = CountryDetail(
            name: storedCountry.name,
            alpha2Code: storedCountry.alpha2Code,
            alpha3Code: storedCountry.alpha3Code,
            callingCodes: Array(storedCountry.callingCodes),
            capital: storedCountry.capital,
            region: storedCountry.region,
            subregion: storedCountry.subregion,
            population: storedCountry.population,
            latlng: Array(storedCountry.latlng),
            area: storedCountry.area,
            timezones: Array(storedCountry.timezones),
            borders: Array(storedCountry.borders),
            nativeName: storedCountry.nativeName,
            currencies: Array(storedCountry.currencies),
            languages: Array(storedCountry.languages)
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
