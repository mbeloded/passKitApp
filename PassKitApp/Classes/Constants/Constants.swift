//
//  Constants.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/3/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import Foundation


let PARSE_APP_KEY                               = "GqSYgMf0zJlSda3JPNImqdm97MwTYs7IArN2rfJq"
let PARSE_CLIENT_KEY                            = "DmQrGKzCOIZDBvT2liOc7h6oiIksC3NuOJB7NFtW"


enum RequestType: Int {
    case version = 0
    case category // 1
    case mall // 2
    case banner
    case mall_BANNER
    case store
}

enum ActionType: Int {
    case no_ACTION = 0
    case version // 1
    case category // 2
    case mall
    case banner
    case mall_BANNER
    case store
    case sync_COMPLETE
}


let BUTTON_TEXT_OK                              = "Ok"
let NOTIFICATION_SYNC_COMPLETE                  = "NotificationIdentifierSyncComplete"

let BACK_BUTTON_IMAGE                           = "share_photo-left_button"
