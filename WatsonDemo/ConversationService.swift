//
//  ConversationService.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

protocol ConversationServiceDelegate: class {
    func didReceiveMessage(withText:String)
}


class ConversationService {

    // MARK: - Properties
    weak var delegate: ConversationServiceDelegate?
    var context = ""

    // MARK: - Constants
    private struct Constants {
        static let firstName = "Jane"
        static let lastName = "Smith"
        static let nName = "Jane"
        static let value1 = "Fidelity"
        static let value2 = "TD Ameritrade"
        static let value3 = "Pershing"
        static let httpMethodPost = "POST"
    }

    // MARK: - Key
    private struct Key {
        static let input = "input"
        static let workspaceID = "workspace_id"
        static let firstName = "fname"
        static let lastName = "lname"
        static let nName = "nname"
        static let cValue1 = "cvalue1"
        static let cValue2 = "cvalue2"
        static let cValue3 = "cvalue3"
        static let context = "context"
    }

    // MARK: - Init
    init(delegate: ConversationServiceDelegate) {
        self.delegate = delegate
    }

    func sendMessage(withText text: String) {

        let requestParameters =
            [Key.input: text,
             Key.workspaceID : GlobalConstants.conversationWorkspaceID,
             Key.firstName : Constants.firstName,
             Key.lastName : Constants.lastName,
             Key.nName : Constants.nName,
             Key.cValue1 : Constants.value1,
             Key.cValue2 : Constants.value2,
             Key.cValue3 : Constants.value3,
             Key.context : context]

        print (requestParameters)

        var request = URLRequest(url: URL(string: GlobalConstants.nodeRedWorkflowUrl)!)
        request.httpMethod = Constants.httpMethodPost
        var parametersString = ""
        for (key, value) in requestParameters {
            parametersString = parametersString + key + "=" + value + "&"
        }
        parametersString = parametersString.substring(to: parametersString.index(before: parametersString.endIndex))
        parametersString = parametersString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        request.httpBody = parametersString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // check for fundamental networking error
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }

            // check for http errors
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Failed with status code: \(httpStatus.statusCode)")
                print("response = \(response)")
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }

}
