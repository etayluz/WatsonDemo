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
    func didReceiveVideo(withUrl videoUrl: URL)
}


class ConversationService {

    // MARK: - Properties
    weak var delegate: ConversationServiceDelegate?
    var context = ""
    var firstName: String?

    // MARK: - Constants
    private struct Constants {
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

    private struct Video {
        static let videoOne = "https://r2---sn-qxo7snek.googlevideo.com/videoplayback?upn=u3VFnIlYlRY&mn=sn-qxo7snek&mm=31&id=o-ANJR_MNQAL0YSZN3tJP8HyLiUQgBQHxlcHpK7oSWPSlF&gir=yes&mt=1481158915&ms=au&ip=104.197.75.157&key=yt6&requiressl=yes&ei=U7FIWLSeKYiZuQKEpKygDA&lmt=1392959589613671&mv=m&sparams=clen%2Cdur%2Cei%2Cgir%2Cid%2Cinitcwndbps%2Cip%2Cipbits%2Citag%2Clmt%2Cmime%2Cmm%2Cmn%2Cms%2Cmv%2Cpl%2Cratebypass%2Crequiressl%2Csource%2Cupn%2Cexpire&mime=video%2Fmp4&expire=1481180595&source=youtube&itag=18&pl=20&dur=30.464&initcwndbps=8352500&clen=2338824&ipbits=0&ratebypass=yes&signature=CE269EE93E35C36492B3877099DA121FB43A3BC7.CCC72118C980E16745CE5FFF6063DD28017E518C&title=BAM%21+Social+Norming"
    }

    // MARK: - Init
    init(delegate: ConversationServiceDelegate) {
        self.delegate = delegate
    }

    func sendMessage(withText text: String) {
        if firstName == nil && text != "Hi" {
            firstName = text
        }

        let requestParameters =
            [Key.input: text,
             Key.workspaceID: GlobalConstants.sriniCheedallaWorkspaceID,
             Key.firstName: firstName,
             Key.lastName: Constants.lastName,
             Key.nName: Constants.nName,
             Key.cValue1: Constants.value1,
             Key.cValue2: Constants.value2,
             Key.cValue3: Constants.value3,
             Key.context: context,
        ]

        var request = URLRequest(url: URL(string: GlobalConstants.sriniCheedallNodeRedWorkflowUrl)!)
        request.httpMethod = Constants.httpMethodPost
        request.httpBody = requestParameters.stringFromHttpParameters().data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // check for fundamental networking error
            DispatchQueue.main.async { [weak self] in

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
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                            self?.parseJson(json: json)
                        }
                    } catch {
                        // No-op
                    }

                }
            }
        }

        /// Delay conversation request so as to give the keyboard time to dismiss and chat table view to scroll bottom
        let when = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: when + 0.3) {
            task.resume()
        }

    }

    func parseJson(json: [String:AnyObject]) { 

        self.context = json["context"] as! String
        var text = json["text"] as! String

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

        #if DEBUG
            //                      options = ["4 PM today", "9:30 AM tomorrow", "1 PM tomorrow", "checking", "savings", "savings"]
            //                      options = ["Yes", "No"]
            //                        options = ["4 PM today", "9:30 AM", "1 PM tomorrow"]
            //                        options = ["Checking", "Savings", "Brokerage"]
            //                        options = ["4 PM today", "9:30 AM tomorrow", "1 PM tomorrow", "checking"]
        #endif

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

        self.delegate?.didReceiveMessage(withText: text, options: options)
        if let mapUrlString = mapUrlString, let mapUrl = URL(string: mapUrlString) {
            self.delegate?.didReceiveMap(withUrl: mapUrl)
        }

//        text = "Let me show you a short video to see the effects of distracted driving"
        if text.contains("Let me show you a short video") {
            let videoUrl = URL(string: Video.videoOne)!
            self.delegate?.didReceiveVideo(withUrl: videoUrl)
        }

        // TBD: Remove me - for debug of map
        // strongSelf.delegate?.didReceiveMap(withUrl: URL(string: Map.mapOne)!)
    }

}
