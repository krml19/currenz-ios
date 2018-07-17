//
//  AppDelegate.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import SwiftyBeaver
let log = SwiftyBeaver.self
import RxSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let disposeBag = DisposeBag()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()
        
        mock()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    
    }

    func applicationWillTerminate(_ application: UIApplication) {
    
    }

}

// MARK: - Configuration
private extension AppDelegate {
    func configure() {
        Appearance.configure()
        configureLogger()
    }
    private func configureLogger() {
        let console = ConsoleDestination()
        log.addDestination(console)
    }
}

// MARK: - Mock
private extension AppDelegate {
    func mock() {
        log.info("Path: \(NSHomeDirectory())")
        let network = CurrencyExchangeSerivce()
        network.rate(currencyExchangeSymbol: "EURUSD").subscribe(onNext: { (response) in
            log.debug(response)
        }, onError: { (error) in
            log.error(error)
        }, onCompleted: {
            log.info("onCompleted")
        }, onDisposed: {
            log.info("onDisposed")
        }).disposed(by: disposeBag)
    }
}
