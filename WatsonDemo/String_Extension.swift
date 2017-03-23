//
//  String_Extension.swift
//  WatsonDemo
//
//  Created by Etay Luz on 3/22/17.
//  Copyright © 2017 Etay Luz. All rights reserved.
//

import Foundation

extension String {

    func dictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
