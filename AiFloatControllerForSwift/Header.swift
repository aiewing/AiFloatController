//
//  Header.swift
//  AiFloatControllerForSwift
//
//  Created by Aiewing on 2019/11/4.
//  Copyright © 2019 Aiewing. All rights reserved.
//

import Foundation
import UIKit

let AiScreenWidth : CGFloat = UIScreen.main.bounds.size.width
let AiScreenHeight : CGFloat = UIScreen.main.bounds.size.height
let AiDeviceiPhoneX : Bool = ((AiScreenWidth == 375) && (AiScreenHeight == 812)) || ((AiScreenWidth == 414) && (AiScreenHeight == 896))
let AiStatusBarSafeInsetHeight : CGFloat = AiDeviceiPhoneX ? 20.0 : 0.0
let AiNavigationBarHeight : CGFloat = AiDeviceiPhoneX ? 88.0 : 64.0
let AiStatusBarHeight : CGFloat = AiDeviceiPhoneX ? 44.0 : 20.0
