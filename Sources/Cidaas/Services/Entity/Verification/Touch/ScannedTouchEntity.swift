//
//  ScannedPatternEntity.swift
//  Cidaas
//
//  Created by ganesh on 23/07/18.
//

import Foundation

public class ScannedTouchEntity : Codable {
    // properties
    public var usage_pass: String = ""
    public var statusId: String = ""
    public var deviceInfo: DeviceInfoModel = DeviceInfoModel()
    
    // Constructors
    public init() {
        
    }
}
