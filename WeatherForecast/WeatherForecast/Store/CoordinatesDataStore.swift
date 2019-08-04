//
//  CoordinatesDataStore.swift
//  WeatherForecast
//
//  Created by BLU on 04/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

class CoordinatesDataStore {
    
    private let storeKey = "coordinates"
    var coordinatesList = [Coordinates]()
    
    func save() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: coordinatesList, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: storeKey)
        } catch {
            print(error)
        }
        //        let data = NSKeyedArchiver.archivedData(withRootObject: coordinatesList, requiringSecureCoding: true)
        //        UserDefaults.standard.set(coordinatesList, forKey: storeKey)
    }
    
    func load() {
        let my = UserDefaults.standard.object(forKey: storeKey)
        do {
            //            let un = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Coordinates.self], from: my as! Data) as? [Coordinates]
            let un = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(my as! Data) as? [Coordinates]
            print(un?.count)
        } catch {
            print(error)
        }
    }
}
