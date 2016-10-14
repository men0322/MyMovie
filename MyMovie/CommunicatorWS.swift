//
//  CommunicatorWS.swift
//  PebbleSwim
//
//  Created by trunga.nguyen-mac on 8/15/15.
//  Copyright (c) 2015 swim. All rights reserved.
//

import Foundation
import AFNetworking
@objc class CommunicatorWS: NSObject {
    let appDelegate = UIApplication.sharedApplication().delegate as! PebbleSwimAppDelegate
    var currentOperation: AFHTTPRequestOperation?
    
    func getWS(url:String, completeBlock: CompleteBlock, failureBlock: FailureBlock){
        let requestOperationManager = AFHTTPRequestOperationManager()
        requestOperationManager.requestSerializer = AFHTTPRequestSerializer()
        requestOperationManager.credential = appDelegate.updateAuthenticate()
        requestOperationManager.requestSerializer.setAuthorizationHeaderFieldWithUsername(ses_UserLogin.userNameCredential, password: ses_UserLogin.passwordCredential)
//        print(ses_UserLogin.userNameCredential)
//        print(ses_UserLogin.passwordCredential)
        requestOperationManager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions())
        
        let policy : AFSecurityPolicy = AFSecurityPolicy();
        policy.allowInvalidCertificates = true;
        requestOperationManager.securityPolicy = policy
        currentOperation = requestOperationManager.GET(url, parameters: nil, success: { (operation: AFHTTPRequestOperation!, returnedItem: AnyObject!) -> Void in
            
            completeBlock(success: true, result: (returnedItem as! Dictionary<String, AnyObject>))
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                failureBlock(error: error)
        })
        currentOperation?.start()
    }
    
    func postJsonWS(url:String,param:AnyObject?, completeBlock: CompleteBlock, failureBlock: FailureBlock){
        let requestOperationManager = AFHTTPRequestOperationManager()
        requestOperationManager.requestSerializer = AFJSONRequestSerializer(writingOptions: [])
        requestOperationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestOperationManager.requestSerializer.setAuthorizationHeaderFieldWithUsername(ses_UserLogin.userNameCredential, password: ses_UserLogin.passwordCredential)
        requestOperationManager.credential = appDelegate.updateAuthenticate()
        requestOperationManager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions())
        
        let policy : AFSecurityPolicy = AFSecurityPolicy();
        policy.allowInvalidCertificates = true;
        requestOperationManager.securityPolicy = policy
        currentOperation = requestOperationManager.POST(url, parameters: param as? [NSObject : AnyObject], success: { (operation: AFHTTPRequestOperation!, returnedItem: AnyObject!) -> Void in
            completeBlock(success: true, result: (returnedItem as! Dictionary<String, AnyObject>))
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                failureBlock(error: error)
        })
        currentOperation?.start()
        
        
    }
    
    func postWS(url:String,param:AnyObject?, completeBlock: CompleteBlock, failureBlock: FailureBlock){
        let requestOperationManager = AFHTTPRequestOperationManager()
        requestOperationManager.requestSerializer = AFHTTPRequestSerializer()
        requestOperationManager.credential = appDelegate.updateAuthenticate()
        requestOperationManager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions())
        requestOperationManager.requestSerializer.setAuthorizationHeaderFieldWithUsername(ses_UserLogin.userNameCredential, password: ses_UserLogin.passwordCredential)
        
        let policy : AFSecurityPolicy = AFSecurityPolicy();
        policy.allowInvalidCertificates = true;
        requestOperationManager.securityPolicy = policy
        currentOperation = requestOperationManager.POST(url, parameters: param as? [NSObject : AnyObject], success: { (operation: AFHTTPRequestOperation!, returnedItem: AnyObject!) -> Void in
            completeBlock(success: true, result: (returnedItem as! Dictionary<String, AnyObject>))
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                failureBlock(error: error)
        })
        currentOperation?.start()
        
        
    }
    
    func getWS_NoAuthenticate(url:String, completeBlock: CompleteBlock, failureBlock: FailureBlock){
        let requestOperationManager = AFHTTPRequestOperationManager()
        requestOperationManager.requestSerializer = AFHTTPRequestSerializer()
        requestOperationManager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions())
        
        let policy : AFSecurityPolicy = AFSecurityPolicy();
        policy.allowInvalidCertificates = true;
        requestOperationManager.securityPolicy = policy
        currentOperation = requestOperationManager.GET(url, parameters: nil, success: { (operation: AFHTTPRequestOperation!, returnedItem: AnyObject!) -> Void in
            
            completeBlock(success: true, result: (returnedItem as! Dictionary<String, AnyObject>))
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                failureBlock(error: error)
        })
        currentOperation?.start()
    }
    
    func postWS_NoAuthenticate(url:String,param:AnyObject?, completeBlock: CompleteBlock, failureBlock: FailureBlock){
        let requestOperationManager = AFHTTPRequestOperationManager()
        requestOperationManager.requestSerializer = AFHTTPRequestSerializer()
        requestOperationManager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions())
        
        let policy : AFSecurityPolicy = AFSecurityPolicy()
        policy.validatesDomainName = false
        policy.validatesCertificateChain = false
        
        policy.allowInvalidCertificates = true;
        requestOperationManager.securityPolicy = policy
        currentOperation = requestOperationManager.POST(url, parameters: param as? [NSObject : AnyObject], success: { (operation: AFHTTPRequestOperation!, returnedItem: AnyObject!) -> Void in
            completeBlock(success: true, result: (returnedItem as! Dictionary<String, AnyObject>))
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                failureBlock(error: error)
        })
        currentOperation?.start()
        
        
    }
    
    
    func uploadFileWS(url:String,param:AnyObject?,data:NSData, dataName:String,dataFileName:String, dataMimeType:String, completeBlock: CompleteBlock, failureBlock: FailureBlock){
        let requestOperationManager = AFHTTPRequestOperationManager()
        
        let policy : AFSecurityPolicy = AFSecurityPolicy();
        policy.allowInvalidCertificates = true;
        requestOperationManager.securityPolicy = policy
        
        requestOperationManager.requestSerializer = AFHTTPRequestSerializer()
        requestOperationManager.credential = appDelegate.updateAuthenticate()
        requestOperationManager.requestSerializer.setAuthorizationHeaderFieldWithUsername(ses_UserLogin.userNameCredential, password: ses_UserLogin.passwordCredential)
        requestOperationManager.requestSerializer.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        requestOperationManager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions())
        
        currentOperation = requestOperationManager.POST(url, parameters: param as? [NSObject : AnyObject], constructingBodyWithBlock: { (formData:AFMultipartFormData!) -> Void in
            formData.appendPartWithFileData(data, name: dataName, fileName: dataFileName, mimeType: dataMimeType)
            }, success: { (operation: AFHTTPRequestOperation!, returnedItem: AnyObject!) -> Void in
                completeBlock(success: true, result: (returnedItem as! Dictionary<String, AnyObject>))
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                failureBlock(error: error)
        })
        currentOperation?.start()
        
        
    }
    
    func uploadFileWS_URLLocal(url:String,param:AnyObject?, dataName:String, filePath:String, completeBlock: CompleteBlock, failureBlock: FailureBlock){
        let requestOperationManager = AFHTTPRequestOperationManager()
        let dataFile : NSData = NSData(contentsOfFile: filePath)!
        let policy : AFSecurityPolicy = AFSecurityPolicy();
        policy.allowInvalidCertificates = true;
        requestOperationManager.securityPolicy = policy
        
        requestOperationManager.requestSerializer = AFHTTPRequestSerializer()
        requestOperationManager.credential = appDelegate.updateAuthenticate()
        requestOperationManager.requestSerializer.setAuthorizationHeaderFieldWithUsername(ses_UserLogin.userNameCredential, password: ses_UserLogin.passwordCredential)
        requestOperationManager.requestSerializer.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        requestOperationManager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions())
        currentOperation = requestOperationManager.POST(url, parameters: param as? [NSObject : AnyObject], constructingBodyWithBlock: { (formData:AFMultipartFormData!) -> Void in
            formData.appendPartWithFileData(dataFile, name: dataName, fileName: dataName, mimeType: "application/binary")
            }, success: { (operation: AFHTTPRequestOperation!, returnedItem: AnyObject!) -> Void in
                completeBlock(success: true, result: (returnedItem as! Dictionary<String, AnyObject>))
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                failureBlock(error: error)
        })
        currentOperation?.start()
        
        
    }
}

