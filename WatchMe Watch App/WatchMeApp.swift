//
//  WatchMeApp.swift
//  WatchMe Watch App
//
//  Created by Leo Dion on 12/18/22.
//

import SwiftUI
import WatchMeServ
import class Vapor.Application

@main
struct WatchMe_Watch_AppApp: App {
  @State var server: Server?
  @State var serverApplication : Application?
  
    var body: some Scene {
        WindowGroup {
          ContentView().onAppear {
            let server: Server
            let application : Application
            do {
            server = try Server()
             application = try server.start()
              
            } catch {
              dump(error)
              return
            }
            self.server = server
            self.serverApplication = application
            print(ProcessInfo().hostName)
          }
        }
    }
}
