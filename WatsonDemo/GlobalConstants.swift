//
//  GlobalConstants.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

struct GlobalConstants {
#if WATSONBANKASST
    static let dennisNotoWorkspaceID = "e162651d-3bf1-4cdb-9b88-c700511eef66"
    static let nodeRedWorkflowUrl = "https://nodered-prod-v1.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "57664062-7e3f-44ba-9509-86693059b908"
    static let BluemixPasswordSTT = "S3mjUCoKlBUW"
    static let BluemixUsernameTTS = "98b40873-5a5f-46fd-8b87-61d331d8154c"
    static let BluemixPasswordTTS = "tndhTu1APbI3"
    
    //static let dennisNotoWorkspaceID = "1549fa38-7160-4106-82ee-73796b21f3b8"
    //static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
    //static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    //static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    //static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    //static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
#elseif WATSONINSASST
    
    static let dennisNotoWorkspaceID = "be10696f-c581-4c7b-a4b7-8cac928c3e56"
    static let nodeRedWorkflowUrl = "https://nodered-prod-v1.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "57664062-7e3f-44ba-9509-86693059b908"
    static let BluemixPasswordSTT = "S3mjUCoKlBUW"
    static let BluemixUsernameTTS = "98b40873-5a5f-46fd-8b87-61d331d8154c"
    static let BluemixPasswordTTS = "tndhTu1APbI3"
    
    
    //static let dennisNotoWorkspaceID = "17df222b-bf8c-41fc-8bec-da21317d993c"
    //static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
    //static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    //static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    //static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    //static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
#elseif WATSONWEALTHASST
    
    static let dennisNotoWorkspaceID = "8a43bb91-62b9-4f45-93c9-dee8075a49fa"
    static let nodeRedWorkflowUrl = "https://nodered-prod-v1.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "57664062-7e3f-44ba-9509-86693059b908"
    static let BluemixPasswordSTT = "S3mjUCoKlBUW"
    static let BluemixUsernameTTS = "98b40873-5a5f-46fd-8b87-61d331d8154c"
    static let BluemixPasswordTTS = "tndhTu1APbI3"
    
    //static let dennisNotoWorkspaceID = "2fb924dd-27c4-4668-8ac3-be7add1065c1"
    //static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
    //static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    //static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    //static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    //static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
#elseif WATSONWEALTHTASST
    static let dennisNotoWorkspaceID = "d229233a-9b65-415d-855d-7edfc231f692"
    static let nodeRedWorkflowUrl = "https://nodered-dev-v1.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "57664062-7e3f-44ba-9509-86693059b908"
    static let BluemixPasswordSTT = "S3mjUCoKlBUW"
    static let BluemixUsernameTTS = "98b40873-5a5f-46fd-8b87-61d331d8154c"
    static let BluemixPasswordTTS = "tndhTu1APbI3"
    
    //static let dennisNotoWorkspaceID = "2fb924dd-27c4-4668-8ac3-be7add1065c1"
    //static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
    //static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    //static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    //static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    //static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONMETASST
    static let dennisNotoWorkspaceID = "5fd7c1c7-9ea2-4fc8-b6fa-7920e10aad5a"
    static let nodeRedWorkflowUrl = "http://metlifepotnode-red1.mybluemix.net/mobileV2-1"
    static let BluemixUsernameSTT = "02aa260b-fe3c-428a-83b3-4d6909e305e3"
    static let BluemixPasswordSTT = "5YxEslShK1UL"
    static let BluemixUsernameTTS = "709f9691-5440-4518-ae53-a7515cf2b7eb"
    static let BluemixPasswordTTS = "XY56UTVSd7qB"
    static let TTScustomizationID = "12303bc6-fa08-4ca4-b6aa-8bc4b674e653"
    static let STTcustomizationID = "5a381810-c3a3-11e6-8e67-ada083c78a12"
#elseif WATSONWHIRLASST
    static let dennisNotoWorkspaceID = "251c4882-44e3-4f34-9c71-36054e155320"
    static let nodeRedWorkflowUrl = "https://whirlpoolnode-red.mybluemix.net/mobileV2-1"
    static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
#elseif WATSONFIDASST
 //   Fidelity space
 //  static let dennisNotoWorkspaceID = "46975d17-120f-4757-8fe8-4a6649b3a257"
 //  static let nodeRedWorkflowUrl = "https://ibm-nodered-v1.mybluemix.net/mobileV2-1"    
    
    static let dennisNotoWorkspaceID = "1555159e-fa59-4d8d-bfba-b10a19144e22"
    static let nodeRedWorkflowUrl = "https://nodered-dev-v1.mybluemix.net/mobile"
    
    static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
#elseif WATSONREGASST
    static let dennisNotoWorkspaceID = "321e996d-efee-42a0-8aed-3dc93006a026"
    static let nodeRedWorkflowUrl = "https://node-red-regions.mybluemix.net/mobileV2-1"
    static let BluemixUsernameSTT = "8fb6456f-3e2b-483c-bc39-34609d7e27a1"
    static let BluemixPasswordSTT = "JmtwYp5NEBVw"
    static let BluemixUsernameTTS = "af631b9a-ef1d-4b06-aa14-2687a157a999"
    static let BluemixPasswordTTS = "4frML2xqiKIL"
    static let TTScustomizationID = "bf2bfc49-a06a-472c-8a15-622d47b0a832"
    static let STTcustomizationID = "481dab60-e41c-11e6-9f7b-9dd7346ffae2"
#elseif WATSONALFASST
    static let dennisNotoWorkspaceID = "fababd0b-b416-40b0-8b06-3536aaa53d44"
    static let nodeRedWorkflowUrl = "https://aflac1.mybluemix.net/mobileV2-1"
 //   static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
 //   static let BluemixPasswordSTT = "NP0ooxJSFfL8"
 //   static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
 //   static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let BluemixUsernameSTT = "cd577564-8907-4459-97c0-e2bd52e9bc58"
    static let BluemixPasswordSTT = "EvhOuqq6HyeD"
    static let BluemixUsernameTTS = "beb39c12-31cf-46b1-bb8b-7d00a5711ebe"
    static let BluemixPasswordTTS = "ky3dLOMhXbAW"
    
    
    static let TTScustomizationID = "f85ba3f7-4f2e-481c-900f-a24138974973"
    static let STTcustomizationID = "f276d800-eecd-11e6-8e67-ada083c78a12"
    
#else
    static let dennisNotoWorkspaceID = "1549fa38-7160-4106-82ee-73796b21f3b8"
    static let nodeRedWorkflowUrl = "https://nodered-prod-v1.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
#endif
}
