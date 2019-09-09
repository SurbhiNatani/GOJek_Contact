//
//  AppUtility.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 06/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import Foundation
import UIKit

//Error Type
enum ErrorType {
    case noInternet(error: String), requestFailure(error: String), other(error: String), loginError(error: String)
}

//HTTP Methods
enum HttpMethod : String {
    case  GET = "GET"
    case  POST = "POST"
    case  PUT = "PUT"
}





