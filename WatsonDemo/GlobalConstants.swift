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
    
    static let workspaceID = "d13cc96b-a323-43a1-b484-29d37679ac27"
    static let wcs_username = "4acac659-e820-4ef6-8421-e88f517c9c4c"
    static let wcs_password = "k0gYo1FjJymP"
    static let nodeRedWorkflowUrl = "http://etaycluster.us-south.containers.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "57664062-7e3f-44ba-9509-86693059b908"
    static let BluemixPasswordSTT = "S3mjUCoKlBUW"
    static let BluemixUsernameTTS = "98b40873-5a5f-46fd-8b87-61d331d8154c"
    static let BluemixPasswordTTS = "tndhTu1APbI3"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONINSASST
    
    static let workspaceID = "54141f49-ffa2-4f6b-887c-aac6aea5d42d"
    static let wcs_username = "4acac659-e820-4ef6-8421-e88f517c9c4c"
    static let wcs_password = "k0gYo1FjJymP"
    static let nodeRedWorkflowUrl = "http://ucg-clusterv3.us-south.containers.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "57664062-7e3f-44ba-9509-86693059b908"
    static let BluemixPasswordSTT = "S3mjUCoKlBUW"
    static let BluemixUsernameTTS = "98b40873-5a5f-46fd-8b87-61d331d8154c"
    static let BluemixPasswordTTS = "tndhTu1APbI3"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONWEALTHASST

//    static let workspaceID = "c2777aef-fe89-4df5-8792-46880d6a0662"
    static let workspaceID = "faf6e421-43ae-474a-8f9e-e8e10e71e3df" // Insurance Call Center Assist
    static let wcs_username = "4acac659-e820-4ef6-8421-e88f517c9c4c"
    static let wcs_password = "k0gYo1FjJymP"
    static let nodeRedWorkflowUrl = "http://ucg-clusterv3.us-south.containers.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "57664062-7e3f-44ba-9509-86693059b908"
    static let BluemixPasswordSTT = "S3mjUCoKlBUW"
    static let BluemixUsernameTTS = "98b40873-5a5f-46fd-8b87-61d331d8154c"
    static let BluemixPasswordTTS = "tndhTu1APbI3"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONWEALTHTASST
    
    static let workspaceID = "8956bffe-3b9a-4d67-93e7-bcc7ed56f908"
    static let wcs_username = "8bc0592d-8f6b-4193-9652-fff57b31f202"
    static let wcs_password = "PcLetpuSahcT"
    static let nodeRedWorkflowUrl = "http://etaycluster.us-south.containers.mybluemix.net/mobile"
    //static let nodeRedWorkflowUrl = "http://ucg-clusterdev.us-south.containers.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "57664062-7e3f-44ba-9509-86693059b908"
    static let BluemixPasswordSTT = "S3mjUCoKlBUW"
    static let BluemixUsernameTTS = "98b40873-5a5f-46fd-8b87-61d331d8154c"
    static let BluemixPasswordTTS = "tndhTu1APbI3"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONASST
    
    static let workspaceID = "54141f49-ffa2-4f6b-887c-aac6aea5d42d"
    static let wcs_username = "4acac659-e820-4ef6-8421-e88f517c9c4c"
    static let wcs_password = "k0gYo1FjJymP"
    static let nodeRedWorkflowUrl = "http://ucg-clusterdev.us-south.containers.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "57664062-7e3f-44ba-9509-86693059b908"
    static let BluemixPasswordSTT = "S3mjUCoKlBUW"
    static let BluemixUsernameTTS = "98b40873-5a5f-46fd-8b87-61d331d8154c"
    static let BluemixPasswordTTS = "tndhTu1APbI3"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONMETASST
    
    static let workspaceID = "5fd7c1c7-9ea2-4fc8-b6fa-7920e10aad5a"
    static let wcs_username = "7d18e2e6-310b-4efc-9370-d9a8289e17dd"
    static let wcs_password = "UEVfKB4CLIyF"
    static let nodeRedWorkflowUrl = "http://ucg-clusterv3.us-south.containers.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "02aa260b-fe3c-428a-83b3-4d6909e305e3"
    static let BluemixPasswordSTT = "5YxEslShK1UL"
    static let BluemixUsernameTTS = "709f9691-5440-4518-ae53-a7515cf2b7eb"
    static let BluemixPasswordTTS = "XY56UTVSd7qB"
    static let TTScustomizationID = "12303bc6-fa08-4ca4-b6aa-8bc4b674e653"
    static let STTcustomizationID = "5a381810-c3a3-11e6-8e67-ada083c78a12"
    
#elseif WATSONWHIRLASST
// **************** Nweds updating **********************************
    
    static let workspaceID = "251c4882-44e3-4f34-9c71-36054e155320"
    static let wcs_username = "4acac659-e820-4ef6-8421-e88f517c9c4c"
    static let wcs_password = "k0gYo1FjJymP"
    static let nodeRedWorkflowUrl = "https://whirlpoolnode-red.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONFIDASST
    
    static let workspaceID = "3f189964-2ed6-4740-bc3a-0952cf1c686f"
    static let wcs_username = "4acac659-e820-4ef6-8421-e88f517c9c4c"
    static let wcs_password = "k0gYo1FjJymP"
    static let nodeRedWorkflowUrl = "https://ucg-clusterv3.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONREGASST
    
    static let workspaceID = "321e996d-efee-42a0-8aed-3dc93006a026"
    static let wcs_username = "f40d2d94-d2e7-4dd1-a718-b57d93203aaa"
    static let wcs_password = "cYuHIo2dCmwf"
    static let nodeRedWorkflowUrl = "https://node-red-regions.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "8fb6456f-3e2b-483c-bc39-34609d7e27a1"
    static let BluemixPasswordSTT = "JmtwYp5NEBVw"
    static let BluemixUsernameTTS = "af631b9a-ef1d-4b06-aa14-2687a157a999"
    static let BluemixPasswordTTS = "4frML2xqiKIL"
    static let TTScustomizationID = "bf2bfc49-a06a-472c-8a15-622d47b0a832"
    static let STTcustomizationID = "481dab60-e41c-11e6-9f7b-9dd7346ffae2"
    
#elseif WATSONALFASST
    
    static let workspaceID = "fababd0b-b416-40b0-8b06-3536aaa53d44"
    static let wcs_username = "f733dd14-570c-440a-91ce-5e81b6c9f471"
    static let wcs_password = "OSC2qk3l0UHY"
    static let nodeRedWorkflowUrl = "https://aflac1.mybluemix.net/mobileV2-1"
    static let BluemixUsernameSTT = "cd577564-8907-4459-97c0-e2bd52e9bc58"
    static let BluemixPasswordSTT = "EvhOuqq6HyeD"
    static let BluemixUsernameTTS = "beb39c12-31cf-46b1-bb8b-7d00a5711ebe"
    static let BluemixPasswordTTS = "ky3dLOMhXbAW"
    static let TTScustomizationID = "f85ba3f7-4f2e-481c-900f-a24138974973"
    static let STTcustomizationID = "f276d800-eecd-11e6-8e67-ada083c78a12"
    
#elseif WATSONFMAEASST
    
    static let workspaceID = "0a7cb606-7488-4b3e-88ae-abcdaafb1c0a"
    static let wcs_username = "42c2ab56-fe61-4fc0-af98-a5dbc1df5234"
    static let wcs_password = "Q0lXwWClSKkp"
    static let nodeRedWorkflowUrl = "https://fanniemae-nodered-v1.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "8785f0ee-cc39-46a8-af5f-9524d2ec32e1"
    static let BluemixPasswordSTT = "zEHAWYsm6pYH"
    static let BluemixUsernameTTS = "a959079b-b60e-4101-b722-f2ec4b6a8652"
    static let BluemixPasswordTTS = "zkloyeobF1Tr"
    static let TTScustomizationID = "d6aab329-b010-4a9c-ae27-39701faf5a48"
    static let STTcustomizationID = "89117320-635d-11e7-85f6-435b156592c7"
    
#elseif WATSONHERTZASST
// **************** Nweds updating **********************************
    static let workspaceID = "8bc22de1-609b-4530-bab0-13481eba086c"
    static let wcs_username = "4acac659-e820-4ef6-8421-e88f517c9c4c"
    static let wcs_password = "k0gYo1FjJymP"
    static let nodeRedWorkflowUrl = "https://callwatson.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "7f9d7a16-b26a-48bc-a1ef-fc470f58eb5b"
    static let BluemixPasswordSTT = "EdtenjXZdeha"
    static let BluemixUsernameTTS = "bf4f679e-7f2d-4473-8f06-359e3029d106"
    static let BluemixPasswordTTS = "yCHYfBm10qPK"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
    
    #else
    
    static let workspaceID = "54141f49-ffa2-4f6b-887c-aac6aea5d42d"
    static let wcs_username = "4acac659-e820-4ef6-8421-e88f517c9c4c"
    static let wcs_password = "k0gYo1FjJymP"
    static let nodeRedWorkflowUrl = "http://ucg-clusterv3.us-south.containers.mybluemix.net/mobile"
    static let BluemixUsernameSTT = "57664062-7e3f-44ba-9509-86693059b908"
    static let BluemixPasswordSTT = "S3mjUCoKlBUW"
    static let BluemixUsernameTTS = "98b40873-5a5f-46fd-8b87-61d331d8154c"
    static let BluemixPasswordTTS = "tndhTu1APbI3"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#endif

    static var UserIcon = "";
    static var username = "";
    static var password = "";

}
