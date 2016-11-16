//
//  ConversationService.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

protocol ConversationServiceDelegate: class {
    func didReceiveMessage(withText text: String)
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
                    let text = json?["text"] as! String
                    strongSelf.delegate?.didReceiveMessage(withText: text)
                }
            }
        }

        task.resume()
    }

}
