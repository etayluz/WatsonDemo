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
    func didReceiveCheckbox(witOptions: [String])
    func didReceiveMap(withString mapStr: String)
    //  func didReceiveMap(withUrl mapUrl: URL)
    func didReceiveVideo(withUrl videoUrl: URL)

}


class ConversationService {

    // MARK: - Properties
    weak var delegate: ConversationServiceDelegate?
    var context = ""
    var contextDictionary: Dictionary<String, Any>?
    var options: [String]?
    
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
        static let contextKey = "context"
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
     /*   static let mapOne = "https://maps.googleapis.com/maps/api/staticmap?format=png&zoom=17&size=590x300&markers=icon:http://chart.apis.google.com/chart?chst=d_map_pin_icon%26chld=cafe%257C996600%7C10900+South+Parker+road+Parker+Colorado&key=AIzaSyA22GwDjEAwd58byf7JRxcQ5X0IK6JlT9k"
        static let mapTwo = "https://maps.googleapis.com/maps/api/staticmap?maptype=satellite&format=png&zoom=18&size=590x300&markers=icon:http://chart.apis.google.com/chart?chst=d_map_pin_icon%26chld=cafe%257C996600%7C10900+South+Parker+road+Parker+Colorado&key=AIzaSyA22GwDjEAwd58byf7JRxcQ5X0IK6JlT9k"
        static let mapThree = "https://maps.googleapis.com/maps/api/staticmap?format=png&zoom=13&size=590x300&markers=icon:http://chart.apis.google.com/chart?chst=d_map_pin_icon%26chld=cafe%257C996600%7C1000+Jasper+Avenue+Edmonton+Canada&key=AIzaSyA22GwDjEAwd58byf7JRxcQ5X0IK6JlT9k"
        static let mapFour = "https://maps.googleapis.com/maps/api/staticmap?maptype=satellite&format=png&zoom=18&size=590x300&markers=icon:http://chart.apis.google.com/chart?chst=d_map_pin_icon%26chld=cafe%257C996600%7C1000+Jasper+Avenue+Edmonton+Canada&key=AIzaSyA22GwDjEAwd58byf7JRxcQ5X0IK6JlT9k"
    */
     }

    // MARK: - Init
    init(delegate: ConversationServiceDelegate) {
        self.delegate = delegate
    }

    func sendMessage(withText text: String) {
        let requestParameters =
            [Key.input: text + " ", // Need to add space at end since node red chops off last letter
             Key.workspaceID: GlobalConstants.dennisNotoWorkspaceID,
             Key.firstName: Constants.firstName,
             Key.lastName: Constants.lastName,
             Key.nName: Constants.nName,
             Key.cValue1: Constants.value1,
             Key.cValue2: Constants.value2,
             Key.cValue3: Constants.value3,
             Key.contextKey: context,
        ]

        print(requestParameters)

        var request = URLRequest(url: URL(string: GlobalConstants.nodeRedWorkflowUrl)!)
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

        let test = json["context"]
        print(type(of: test))
        context = json["context"] as! String

        // TEST CHECKPOINTS
//        context = "{\"checkbox\": { \"values\" :[\"checkTitle1\", \"checkTitle2\"],\"display\": \"Yes\"}}"
        contextDictionary = context.dictionary()
        var text = json["text"] as! String
        var text1 = json["text"] as! String

        options?.removeAll(keepingCapacity: false)
        
        // Look for the option params in the brackets
        let nsString = text as NSString
        let regex = try! NSRegularExpression(pattern: "\\[.*\\]")
   //     var options: [String]?
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

//
//        if let array = json["text"] as? [String] {
//            NSLog("here")
//            if (array[0] == "checkbox") {
//                var checkboxOptions = array
//                checkboxOptions.remove(at: 0)
//                delegate?.didReceiveCheckbox(witOptions: checkboxOptions)
//                return
//            }
//        }


        self.delegate?.didReceiveMessage(withText: text, options: options);

        checkForButton()
        checkForUserIcon()
        checkForMap()
        checkForMovie()
        checkForCheckbox()
        // TBD: Remove me - for debug of map
        // strongSelf.delegate?.didReceiveMap(withUrl: URL(string: Map.mapOne)!)
    }

    func checkForCheckbox() {
        if contextDictionary?["checkbox"] != nil {
            let checkbox: Dictionary<String, Any> = contextDictionary?["checkbox"] as! Dictionary<String, Any>
            let checkboxOptions = checkbox["values"] as! Array<String>
            NSLog("%@", checkboxOptions)
            delegate?.didReceiveCheckbox(witOptions: checkboxOptions)
//            let context1 = context
            contextDictionary?["checkbox"] = nil
            print(context)

            let nsContext = context as NSString
            // String to remove: ,"checkbox":{"values":["Overall balance","Top Portfolio News "],"display":"Yes"}
            let regex = try! NSRegularExpression(pattern: ",\"checkbox.*Yes\"\\}")
            if let result = regex.matches(in: context, range: NSRange(location: 0, length: nsContext.length)).last {
                let mapJson = nsContext.substring(with: result.range)
                context = context.replacingOccurrences(of: mapJson, with: "")
            }
        }
    }

    func checkForUserIcon() {
        let nsContext = context as NSString
        let regex = try! NSRegularExpression(pattern: "\"UserIcon.*\",|\"UserIcon.*\"\\}")
        if let result = regex.matches(in: context, range: NSRange(location: 0, length: nsContext.length)).last {
            let userIconStr = nsContext.substring(with: result.range)
            var cleanString = userIconStr.replacingOccurrences(of: "\"UserIcon\":\"", with: "", options: .regularExpression, range: nil)
            cleanString = cleanString.replacingOccurrences(of: "\"\\}|\",", with: "", options: .regularExpression, range: nil)
            GlobalConstants.UserIcon = cleanString
            print("user name  " + GlobalConstants.UserIcon)
        }
    }
    func checkForButton() {
        let nsContext = context as NSString
        // String to remove: ,"map":{"values":["Title:buttonLINK1","Tittle:buttonLINK2"],"display":"Yes"}
        let regex = try! NSRegularExpression(pattern: ",\"button.*Yes\"\\}")
        if let result = regex.matches(in: context, range: NSRange(location: 0, length: nsContext.length)).last {
            let buttonJson = nsContext.substring(with: result.range)
            setButtons(forButtonJson: buttonJson)
            context = context.replacingOccurrences(of: buttonJson, with: "")
        }
    }
    
    func setButtons(forButtonJson mapJson: String) {
        var cleanString = mapJson.replacingOccurrences(of: ".*\\[\"", with: "", options: .regularExpression, range: nil)
        cleanString = cleanString.replacingOccurrences(of: "\"].*", with: "", options: .regularExpression, range: nil)
        options = cleanString.components(separatedBy: "\",\"")
        
        //for buttonUrl in buttonsUrls {
        //    let buttonUrl = URL(string: buttonUrl)!
        //    delegate?.didReceiveMap(withUrl: buttonUrl)
        //}
    }
    
    func checkForMap() {
        let nsContext = context as NSString
        // String to remove: ,"map":{"values":["mapsLINK1","mapsLINK2"],"display":"Yes"}
        let regex = try! NSRegularExpression(pattern: ",\"map.*Yes\"\\}")
        if let result = regex.matches(in: context, range: NSRange(location: 0, length: nsContext.length)).last {
            let mapJson = nsContext.substring(with: result.range)
            showMaps(forMapJson: mapJson)
            context = context.replacingOccurrences(of: mapJson, with: "")
        }
    }
    
    func showMaps(forMapJson mapJson: String) {
        var cleanString = mapJson.replacingOccurrences(of: ".*\\[\"", with: "", options: .regularExpression, range: nil)
        cleanString = cleanString.replacingOccurrences(of: "\"].*", with: "", options: .regularExpression, range: nil)
        let mapsStrs = cleanString.components(separatedBy: "\",\"")
        
        for mapStr in mapsStrs {
              delegate?.didReceiveMap(withString: mapStr)
         //   var myUrl = mapUrl + "&size=600x300"
         //   print (myUrl)
         //   let mapUrl = URL(string: myUrl)!
         //   delegate?.didReceiveMap(withUrl: mapUrl)
        }
    }
    
    
    func checkForMovie() {
        let nsContext = context as NSString
        // String to remove: ,"movie":{"values":["MOVIELINK1","MOVIELINK2"],"display":"Yes"}
        let regex = try! NSRegularExpression(pattern: ",\"movie.*Yes\"\\}")
        if let result = regex.matches(in: context, range: NSRange(location: 0, length: nsContext.length)).last {
            let movieJson = nsContext.substring(with: result.range)
            showMovies(forMovieJson: movieJson)
            context = context.replacingOccurrences(of: movieJson, with: "")
        }
    }

    func showMovies(forMovieJson movieJson: String) {
        var cleanString = movieJson.replacingOccurrences(of: ".*\\[\"", with: "", options: .regularExpression, range: nil)
        cleanString = cleanString.replacingOccurrences(of: "\"].*", with: "", options: .regularExpression, range: nil)
        let moviesUrls = cleanString.components(separatedBy: "\",\"")

        for movieUrl in moviesUrls {
            let videoUrl = URL(string: movieUrl)!
            delegate?.didReceiveVideo(withUrl: videoUrl)
        }
    }

}
