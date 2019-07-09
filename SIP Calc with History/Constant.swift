//
//  Constant.swift
//  Envio
//
//  Created by vijay on 4/6/18.
//  Copyright © 2018 lenin. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let topConstraintHeight = 60
let basicButtonHeightConstant = 45.0
let basicTextFieldHeightConstant = 35.0
let USERNAMEMINIMUMLENGTH = 5
let PASSWORDMINIMUMLENGTH = 5
let MOBILEMINIMUMLENGTH = 5
let KEYBOARDAPPEAR = 150
let COUNTRYCODE = "+502 "
let DEVICETYPE = "2"
let CURRENCYCODE = "Q"
let english = "en"
let arabic = "ar"
let apiKEY = "qsefthuko!@#456&*(PLIJYGRDWA"
var employee = "Employee"
var customer = "Customer"
//"AIzaSyBckWGQ11OwSSuqZ_nqeg-Mlu21Znn41Zg" vicky
//"AIzaSyDiODCib1cQqvdD6oIaoto0YXyR9ek3-1Q" lenin
var mapKey = "AIzaSyCCSf59a1nIcJaB0QHEMczBAkcBHkkhJIc" // leninsmannath
var screenStatusBarHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.height
}
struct Firebase {
    static let users = "users"
    static let cards = "Mango"
    static let about = "About"
    static let order = "Mango_Orders"
    static let cart = "Mango_Cart"
    
    static let status = "status"
    
    static let id = "id"
    static let createdBy = "createdBy"
    static let createdDate = "createdDate"
    static let modifiedDate = "modifiedDate"
    static let favouriteList = "favouriteList"
    static let savedList = "savedList"
    static let image = "image"
    
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let primaryEmail = "primaryEmail"
    static let mobile = "mobile"
    static let jobTitle = "jobTitle"
    static let businessName = "businessName"
}
enum Identifier:String{
    case LoginVC
    case SignupVC
    case HomeVC
    case ForgotVC
    case NewItem
    case SettingVC
    case OrderVC
    
    case Share
    case RateUs
    case ProfileVC
    
    case SIP_VC
    case TIP_VC
    case EMI_VC
    
}

struct OrderType {
    static let pending = "Pending Orders"
    static let delivered = "Delivered Orders"
    static let cancelled = "Cancelled Orders"
    static let items = "Ordered Items"
}
struct UserDefaultKey {
    static let profileInfo = "ProfileModel"
    static let userInfo = "userinfo"
    
}

