//
//  VerificationViewController.swift
//  Cidaas
//
//  Created by ganesh on 06/05/19.
//

import UIKit

public class VerificationViewController {

    public static var shared: VerificationViewController = VerificationViewController()
    
    public func setup(verificationType: String, incomingData: SetupRequest, callback: @escaping (Result<SetupResponse>) -> Void) {
        VerificationInteractor.shared.setup(verificationType: verificationType, incomingData: incomingData, callback: callback)
    }
    
    public func scanned(verificationType: String, incomingData: ScannedRequest, callback: @escaping (Result<ScannedResponse>) -> Void) {
        VerificationInteractor.shared.scanned(verificationType: verificationType, incomingData: incomingData, callback: callback)
    }
    
    public func enroll(verificationType: String, photo: UIImage, voice: Data, incomingData: EnrollRequest, callback: @escaping (Result<EnrollResponse>) -> Void) {
        if (verificationType == VerificationTypes.TOUCH.rawValue) {
            VerificationInteractor.shared.askForTouchorFaceIdForEnroll(incomingData: incomingData, callback: callback)
        }
        else {
            VerificationInteractor.shared.enroll(verificationType: verificationType, photo: photo, voice: voice, incomingData: incomingData, callback: callback)
        }
    }
    
    public func initiate(verificationType: String, incomingData: InitiateRequest, callback: @escaping (Result<InitiateResponse>) -> Void) {
        VerificationInteractor.shared.initiate(verificationType: verificationType, incomingData: incomingData, callback: callback)
    }
    
    public func pushAcknowledge(verificationType: String, incomingData: PushAcknowledgeRequest, callback: @escaping (Result<PushAcknowledgeResponse>) -> Void) {
        VerificationInteractor.shared.pushAcknowledge(verificationType: verificationType, incomingData: incomingData, callback: callback)
    }
    
    public func pushAllow(verificationType: String, incomingData: PushAllowRequest, callback: @escaping (Result<PushAllowResponse>) -> Void) {
        VerificationInteractor.shared.pushAllow(verificationType: verificationType, incomingData: incomingData, callback: callback)
    }
    
    public func pushReject(verificationType: String, incomingData: PushRejectRequest, callback: @escaping (Result<PushRejectResponse>) -> Void) {
        VerificationInteractor.shared.pushReject(verificationType: verificationType, incomingData: incomingData, callback: callback)
    }
    
    public func authenticate(verificationType: String, photo: UIImage, voice: Data, incomingData: AuthenticateRequest, callback: @escaping (Result<AuthenticateResponse>) -> Void) {
        if (verificationType == VerificationTypes.TOUCH.rawValue) {
            VerificationInteractor.shared.askForTouchorFaceIdForAuthenticate(incomingData: incomingData, callback: callback)
        }
        else {
            VerificationInteractor.shared.authenticate(verificationType: verificationType, photo: photo, voice: voice, incomingData: incomingData, callback: callback)
        }
    }
    
    public func deleteAll(incomingData: DeleteRequest, callback: @escaping (Result<DeleteResponse>) -> Void) {
        VerificationInteractor.shared.deleteAll(incomingData: incomingData, callback: callback)
    }
    
    public func delete(incomingData: DeleteRequest, callback: @escaping (Result<DeleteResponse>) -> Void) {
        VerificationInteractor.shared.delete(incomingData: incomingData, callback: callback)
    }
    
    public func getConfiguredList(incomingData: MFAListRequest, callback: @escaping (Result<MFAListResponse>) -> Void) {
        VerificationInteractor.shared.getConfiguredList(incomingData: incomingData, callback: callback)
    }
    
    public func getPendingNotificationList(incomingData: PendingNotificationRequest, callback: @escaping (Result<PendingNotificationResponse>) -> Void) {
        VerificationInteractor.shared.getPendingNotificationList(incomingData: incomingData, callback: callback)
    }
    
    public func getAuthenticatedHistoryList(incomingData: AuthenticatedHistoryRequest, callback: @escaping (Result<AuthenticatedHistoryResponse>) -> Void) {
        VerificationInteractor.shared.getAuthenticatedHistoryList(incomingData: incomingData, callback: callback)
    }
    
    public func updateFCM(push_id: String) {
        let incomingData = UpdateFCMRequest()
        incomingData.push_id = push_id
        VerificationInteractor.shared.updateFCM(incomingData: incomingData)
    }
    
    public func configure(incomingData: ConfigureRequest, callback: @escaping (Result<EnrollResponse>) -> Void) {
        VerificationInteractor.shared.configure(incomingData: incomingData, callback: callback)
    }
    
    public func login(incomingData: LoginRequest, photo: UIImage, voice: Data, callback: @escaping(Result<LoginResponse>) -> Void) {
        VerificationInteractor.shared.login(incomingData: incomingData, photo: photo, voice: voice, callback: callback)
    }
}
