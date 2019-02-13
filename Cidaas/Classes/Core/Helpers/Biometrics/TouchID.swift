//
//  TouchID.swift
//  Cidaas
//
//  Created by ganesh on 13/02/19.
//

import Foundation
import LocalAuthentication

public class TouchID {
    
    public static let sharedInstance = TouchID()
    let authenticatedContext = LAContext()
    var error: NSError?
    
    public func checkIfTouchIdAvailable(callback: @escaping (Bool, String?, Int32?)->()) {
        if authenticatedContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            DispatchQueue.main.async {
                callback(true, nil, nil)
            }
        }
        else {
            switch error!.code {
            case LAError.touchIDNotAvailable.rawValue:
                DispatchQueue.main.async {
                    callback(false, "TouchId not available", WebAuthErrorCode.TOUCHID_NOT_AVAILABLE.rawValue)
                }
                break
            case LAError.touchIDNotEnrolled.rawValue:
                DispatchQueue.main.async {
                    callback(false, "TouchId not enrolled", WebAuthErrorCode.TOUCHID_NOT_ENROLLED.rawValue)
                }
                break
            case LAError.passcodeNotSet.rawValue:
                DispatchQueue.main.async {
                    callback(false, "Passcode not configured", WebAuthErrorCode.PASSCODE_NOT_CONFIGURED.rawValue)
                }
                break
            case LAError.authenticationFailed.rawValue:
                DispatchQueue.main.async {
                    callback(false, "Invalid authentication", WebAuthErrorCode.INVALID_AUTHENTICATION.rawValue)
                }
                break
            case LAError.appCancel.rawValue:
                DispatchQueue.main.async {
                    callback(false, "App cancelled", WebAuthErrorCode.APP_CANCELLED.rawValue)
                }
                break
            case LAError.systemCancel.rawValue:
                DispatchQueue.main.async {
                    callback(false, "System cancelled", WebAuthErrorCode.SYSTEM_CANCELLED.rawValue)
                }
                break
            case LAError.userCancel.rawValue:
                DispatchQueue.main.async {
                    callback(false, "User cancelled", WebAuthErrorCode.USER_CANCELLED.rawValue)
                }
                break
            case LAError.touchIDLockout.rawValue:
                DispatchQueue.main.async {
                    callback(false, "TouchId locked", WebAuthErrorCode.TOUCHID_LOCKED.rawValue)
                }
                break
            case LAError.userFallback.rawValue:
                DispatchQueue.main.async {
                    callback(false, "User cancelled", WebAuthErrorCode.USER_CANCELLED.rawValue)
                }
                break
            default:
                DispatchQueue.main.async {
                    callback(false, "Error occured", WebAuthErrorCode.TOUCHID_DEFAULT_ERROR.rawValue)
                }
                break
            }
        }
    }
    
    public func checkTouchIDMatching(localizedReason: String, callback: @escaping (Bool, String?, Int32?)->()) {
        authenticatedContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason, reply: { (success, error) -> Void in
            if( success ) {
                DispatchQueue.main.async {
                    callback(true, nil, nil)
                }
            }else {
                DispatchQueue.main.async {
                    callback(false, error?.localizedDescription, WebAuthErrorCode.TOUCHID_DEFAULT_ERROR.rawValue)
                }
            }
        })
    }
}
