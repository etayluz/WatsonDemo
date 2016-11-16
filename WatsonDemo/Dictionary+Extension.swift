//
//  Dictionary+Extension.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

extension Dictionary {

    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped

    func stringFromHttpParameters() -> String {

        var parametersString = ""
        for (key, value) in self {
            if let key = key as? String,
               let value = value as? String {
                parametersString = parametersString + key + "=" + value + "&"
            }
        }
        parametersString = parametersString.substring(to: parametersString.index(before: parametersString.endIndex))
        return parametersString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
}
