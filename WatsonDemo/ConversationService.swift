//
//  ConversationService.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

protocol ConversationServiceDelegate: class {
    func didReceiveMessage(withText text: String, options: [String]?)
    func didReceiveMap(withUrl mapUrl: URL)
}


class ConversationService {

    // MARK: - Properties
    weak var delegate: ConversationServiceDelegate?
    var context = ""

    // MARK: - Constants
    private struct Constants {
        static let firstName = "Jane"
        static let lastName = "Smith"
        static let httpMethodPost = "POST"
        static let nName = "Jane"
        static let statusCodeOK = 200
        static let value1 = "Fidelity"
        static let value2 = "TD Ameritrade"
        static let value3 = "Pershing"
    }

    // MARK: - Key
    private struct Key {
        static let context = "context"
        static let cValue1 = "cvalue1"
        static let cValue2 = "cvalue2"
        static let cValue3 = "cvalue3"
        static let input = "input"
        static let firstName = "fname"
        static let lastName = "lname"
        static let nName = "nname"
        static let workspaceID = "workspace_id"
    }

    // MARK: - Map
    private struct Map {
        static let mapOne = "https://maps.googleapis.com/maps/api/staticmap?format=png&zoom=17&size=590x300&markers=icon:http://chart.apis.google.com/chart?chst=d_map_pin_icon%26chld=cafe%257C996600%7C10900+South+Parker+road+Parker+Colorado&key=AIzaSyA22GwDjEAwd58byf7JRxcQ5X0IK6JlT9k"
        static let mapTwo = "https://maps.googleapis.com/maps/api/staticmap?maptype=satellite&format=png&zoom=18&size=590x300&markers=icon:http://chart.apis.google.com/chart?chst=d_map_pin_icon%26chld=cafe%257C996600%7C10900+South+Parker+road+Parker+Colorado&key=AIzaSyA22GwDjEAwd58byf7JRxcQ5X0IK6JlT9k"
        static let mapThree = "https://maps.googleapis.com/maps/api/staticmap?format=png&zoom=13&size=590x300&markers=icon:http://chart.apis.google.com/chart?chst=d_map_pin_icon%26chld=cafe%257C996600%7C1000+Jasper+Avenue+Edmonton+Canada&key=AIzaSyA22GwDjEAwd58byf7JRxcQ5X0IK6JlT9k"
        static let mapFour = "https://maps.googleapis.com/maps/api/staticmap?maptype=satellite&format=png&zoom=18&size=590x300&markers=icon:http://chart.apis.google.com/chart?chst=d_map_pin_icon%26chld=cafe%257C996600%7C1000+Jasper+Avenue+Edmonton+Canada&key=AIzaSyA22GwDjEAwd58byf7JRxcQ5X0IK6JlT9k"
    }

    // MARK: - Init
    init(delegate: ConversationServiceDelegate) {
        self.delegate = delegate
    }

    func sendMessage(withText text: String) {
        let requestParameters =
            [Key.input: text,
             Key.workspaceID: GlobalConstants.dennisNotoWorkspaceID,
             Key.firstName: Constants.firstName,
             Key.lastName: Constants.lastName,
             Key.nName: Constants.nName,
             Key.cValue1: Constants.value1,
             Key.cValue2: Constants.value2,
             Key.cValue3: Constants.value3,
             Key.context: context]

        var request = URLRequest(url: URL(string: GlobalConstants.nodeRedWorkflowUrl)!)
        request.httpMethod = Constants.httpMethodPost
        request.httpBody = requestParameters.stringFromHttpParameters().data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // check for fundamental networking error
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }

                guard let data = data, error == nil else {
                    print("error=\(error)")
                    return
                }

                // check for http errors
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != Constants.statusCodeOK {
                    print("Failed with status code: \(httpStatus.statusCode)")
                }

                let responseString = String(data: data, encoding: .utf8)
                if let data = responseString?.data(using: String.Encoding.utf8) {
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                    strongSelf.context = json?["context"] as! String
                    var text = json?["text"] as! String

                    // Look for the option params in the brackets
                    let nsString = text as NSString
                    let regex = try! NSRegularExpression(pattern: "\\[.*\\]")
                    var options: [String]?
                    if let result = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length)).last {
                        var optionsString = nsString.substring(with: result.range)
                        text = text.replacingOccurrences(of: optionsString, with: "")
                        optionsString = optionsString.replacingOccurrences(of: "[", with: "")
                        optionsString = optionsString.replacingOccurrences(of: "]", with: "")
                        optionsString = optionsString.replacingOccurrences(of: ", ", with: ",")
                        options = optionsString.components(separatedBy: ",")
                    }

                    // TBD: Remove me - for debug of buttons
                    options = ["checking", "savings", "savings", "checking", "savings", "savings"]


                    var mapUrlString: String?

                    /// Check for maps
                    if text.contains("InsMap1") {
                        text = text.replacingOccurrences(of: "InsMap1", with: "")
                        mapUrlString = Map.mapOne
                    }

                    if text.contains("InsMap2") {
                        text = text.replacingOccurrences(of: "InsMap2", with: "")
                        mapUrlString = Map.mapTwo
                    }

                    if text.contains("InsMap3") {
                        text = text.replacingOccurrences(of: "InsMap3", with: "")
                        mapUrlString = Map.mapThree
                    }

                    if text.contains("InsMap4") {
                        text = text.replacingOccurrences(of: "InsMap4", with: "")
                        mapUrlString = Map.mapFour
                    }

                    strongSelf.delegate?.didReceiveMessage(withText: text, options: options)
                    if let mapUrlString = mapUrlString, let mapUrl = URL(string: mapUrlString) {
                        strongSelf.delegate?.didReceiveMap(withUrl: mapUrl)
                    }

                    // TBD: Remove me - for debug of map
                    // strongSelf.delegate?.didReceiveMap(withUrl: URL(string: Map.mapOne)!)

                }
            }
        }

        task.resume()
    }

}
