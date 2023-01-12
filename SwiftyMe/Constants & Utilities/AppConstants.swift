//
//  AppConstants.swift

import UIKit

let IMAGE_MAX_MB_SIZE = 4
let IMAGE_MAX_PIXEL_SIZE:Double = 1920.0
let MAX_DAYS_RATING_ALLOWED = 5

/**
 openssl pkcs8 -nocrypt -in TripsConWeatherKitKey_LPB4FP77LT.p8 -out TripsConWeatherKitKey_LPB4FP77LT.pem

 openssl ec -in TripsConWeatherKitKey_LPB4FP77LT.pem -pubout > TripsConWeatherKitKey_LPB4FP77LT.pub
 
 created manually using https://jwt.io/  and Weather-AuthKey_C4UT2U7NY2.pub and Weather-AuthKey_C4UT2U7NY2.pem
 
 {
      "alg": "ES256",
      "kid": "LPB4FP77LT",
      "id": "4GN5V2J2WG.app.tripscon.weatherkit",
      "type":"JWT"
  }
 {
     "iss": "4GN5V2J2WG",
     "iat": 1667199344,
     "exp": 1759276800,
     "sub": "app.tripscon.weatherkit"
 }
 */

//let WEATHERKIT_JWTOKEN = "eyJhbGciOiJFUzI1NiIsImtpZCI6IkM0VVQyVTdOWTIiLCJpZCI6IlRKRk03UjdEVFUuYXBwLnRyaXBzY29uLndlYXRoZXIiLCJ0eXBlIjoiSldUIn0.eyJpc3MiOiJUSkZNN1I3RFRVIiwiaWF0IjoxNjY4NDEzMjIzLCJleHAiOjE5OTg0OTMyMjMsInN1YiI6ImFwcC50cmlwc2Nvbi53ZWF0aGVyIn0.Z5yGc8yBp41Lwjm0JKXkNRs-ol1re36E9akuLUBjPSAWzOTh1OM_vGZ3hQgOzLq-XzZkpRapHZPc6pYOrF8MqQ"

let WEATHERKIT_JWTOKEN = "eyJhbGciOiJFUzI1NiIsImtpZCI6IkxQQjRGUDc3TFQiLCJpZCI6IjRHTjVWMkoyV0cuYXBwLnRyaXBzY29uLndlYXRoZXJraXQiLCJ0eXBlIjoiSldUIn0.eyJpc3MiOiI0R041VjJKMldHIiwiaWF0IjoxNjY3MTk5MzQ0LCJleHAiOjE3NTkyNzY4MDAsInN1YiI6ImFwcC50cmlwc2Nvbi53ZWF0aGVya2l0In0.xefGp1tIxuXovqOICAbn4-MGrQq2-it8Tulcpe-D1zSLxJj4AOJBLxZjZF4IP6puUXQ26_qbSr0G21iLxyQqSA"


struct APP_URL {
    
    static let BASE_URL : String = "https://sandbox-api.tripscon.com/"
    static let API : String = BASE_URL
    static let IMAGE_URL: String = BASE_URL + "assets/uploads/"
   
}

struct NOTIFICATIONS{
    static let REFERSH_DATA = "REFERSH_DATA"
    static let REFERSH_MESSAGE_STATUS = "REFERSH_MESSAGE_STATUS"
    static let LOCATION_UPDATED = "USER_LOCATION_UPDATED"
    static let APPLICATION_COME_FOREGROUND = "APPLICATION_COME_FOREGROUND"
    static let NOTIFICATION_NEW_CHAT_MESSAGE = "NOTIFICATION_NEW_CHAT_MESSAGE"
    static let NOTIFICATION_CURRENCY_CHANGED = "NOTIFICATION_CURRENCY_CHANGED"
}

struct NOTIFICATION_TYPE{
    static let BOOKING_REMINDER = "bookingReminder"
    static let CHAT = "CHAT"
    static let CHAT_MESSAGE = "CHAT_MESSAGE"
    static let BOOKING = "BOOKING"
    static let ACCOMMODATION = "ACCOMMODATION"
    static let VEHICLE = "VEHICLE"
    static let EXPERIENCE = "EXPERIENCE"
    static let MEALMEAL = "MEAL"
}
struct USER_DEFAULT_KEY {
    static let DEVICE_TYPE = "iOS"
    static let AUTH_TOEKN = "auth_token"
    static let IS_USER_LOGGEDIN = "IS_USER_LOGGEDIN"
    static let USER_PROFILE = "USER_PROFILE"
    static let DEFAULT_ERROR = "Something went wrong."
    static let NETWORK_ERROR = "Network connection lost."
    static let TIMEOUT_ERROR = "Request timed out."
    static let INVALID_RESPONSE_ERROR = "Response format is invalid."
    static let SERVER_ERROR = "Something went wrong, please contact support team."
    static let LANGUAGE_DEFAULT = "LANGUAGE_DEFAULT"
    static let CURRENT_ADDRESS = "CURRENT_ADDRESS"
}

struct GOOGLE_KEY{
    
    static let GOOGLE_MAP_KEY =  "AIzaSyBURKqVNB1eT1EPIj4KqCh2N4zwlo_aLW4" //web site
    static let PLACES_KEY = "AIzaSyBURKqVNB1eT1EPIj4KqCh2N4zwlo_aLW4" //web site
    //static let GOOGLE_MAP_KEY =  "AIzaSyBAPdSkJ2534T69Blg4Gklw5-ctfL0XmHQ" //dev.testfb1991@gmail.com
    //static let PLACES_KEY = "AIzaSyBAPdSkJ2534T69Blg4Gklw5-ctfL0XmHQ"
    static let CLIENT_ID_SIGN_IN = "767557684593-mphqlik2aficrmfpacp0bsgs57i3i5k1.apps.googleusercontent.com" //TripsCon, dev.testfb1991@gmail.com 

}
struct MAP_BOX_KEY{
    static let SECRET_TOKEN = "sk.eyJ1Ijoid2FzZWVtd2FubyIsImEiOiJja3ptZTNjdTgwem9vMm90YTYzeTRqMnlhIn0.umWmRzwx2qW0hmq8D8XoMg"
    static let PUBLIC_TOKEN = "sk.eyJ1Ijoid2FzZWVtd2FubyIsImEiOiJja3pvNXp6amo0a3dnMzBvMTc0dTByOGU4In0.1LX8fibTZB1mgtKU5Bmfcg"
}
struct WEATHER_KEY{
    static let APPID = "22cbee608e499cf21b4cc9a53e9edf5d" //waseem@wanologicalsolutions.com, myaccount57 // https://api.openweathermap.org
}

let DAY_NAMES = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
let ALL_CURRENCIES = ["USD","PKR","SAR","AED","EUR","JPY","GBP","AUD","CAD","HKD","TRY","ZAR"]

let METER_UPDATE_INTERVAL = 0.10
struct MESSAGES_TYPES{
    static let leaveGroup = "leaveGroup"
    static let removeMember = "removeMember"
    static let link = "link"
    static let text = "message"
    static let image = "image"
    static let audio = "audio"
    static let bargain = "bargain"
    static let cart = "cart"
    static let order = "order"
}
struct MESSAGES_READ_STATUS{
    static let pending = 0
    static let sent = 1
    static let delivered = 2
    static let read = 3
}
