//
//  NetworkConstant.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//


import Foundation

enum EnviromentType{
    case production
    case debuging
    
    func getEnviroment()->String{
        switch self {
        case .production:
            return "http://18.170.26.7/api/v1/en/"
        case .debuging:
            return "https://api.robinacademy.ae/api/v1/en/"
            //"https://dashboard.robinacademy.ae/api/v1/en/"
        }
    }
}

//MARK: -

enum APICollectionType{
    case general
    case auth
    case home
    case course
    
    var section: String{
        switch self {
        case .general:
            return ""
        case .auth:
            return "auth/"
        case .home :
            return "home/"
        case .course :
            return "courses/"
        }
    }
}

enum WebServices: String{
    //MARK: - Auth .
    case login  = "login"
    case register = "create-account"
    case verfication = "verify-phone-number"
    case forgetPassword = "forgot-password"
    case resetPassword = "reset-password"
    case changePassword = "change_password"
    case resendCode = "resend-verification-code"
    case getProfile = "get-profile"
    case updateProfile = "update-profile"
    case deleteAccount = "delete-my-account"
    case logout = "logout"
    case pushToken = "push_device_token"
    case country = "countries"
    case myDevices = "my-devices"
    case deleteMyDevice = "delete-my-device"
    case getConfigurations = "get-configurations"
    case allowPushNotifications = "allow-push-notifications"
   
    //MARK: - Home .
    case home = "get-home-content"
    case speciality = "specialities"
    
    //MARK: - Courses .
    case courses = "get-courses"
    case courseDetails = "get-course-details"
    case courseReview = "get-course-reviews"
    case addReview = "add-course-review"
    case courseNotes = "get-course-notes"
    case courselectures = "get-course-lectures"
    case courseFlashCards = "flashcards"
    
    case submitFlashCard = "submit-flashcard"
    case courseQuestions = "questions"
    case submitExam = "submit-exam"
    //MARK: - Learn .
    case myCourses = "my-courses"
    
    func getEndPoint() -> String{
        let base = EnviromentType.debuging.getEnviroment()
        print("base url - ---- \(base)")
        switch self {
        case .login :
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .register:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .verfication:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .forgetPassword:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .resetPassword:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .changePassword:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .resendCode:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .getProfile:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .updateProfile:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .deleteAccount:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .logout:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .pushToken:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case  .myDevices:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case  .deleteMyDevice:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .getConfigurations:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .allowPushNotifications:
            return "\(String(describing: base))\(APICollectionType.auth.section)\(rawValue)"
        case .country:
            return "\(String(describing: base))\(rawValue)"
        case .home:
            return "\(String(describing: base))\(APICollectionType.home.section)\(rawValue)"
        case .speciality:
            return "\(String(describing: base))\(rawValue)"
        case .courses:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        case .courseDetails:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        case .courseReview:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        case .addReview:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        case .courseNotes:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        case .courselectures:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        case .courseFlashCards:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        case .submitFlashCard:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        case .courseQuestions:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        case .submitExam:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        case .myCourses:
            return "\(String(describing: base))\(APICollectionType.course.section)\(rawValue)"
        }
    }
}


