//
//  sshService.swift
//  pidebugger
//
//  Created by Moritz Gruber on 08/11/16.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import Foundation
import NMSSH

class sshService {
    
   
    static func start(VC: ViewControllerSetup){
        let session = NMSSHSession(host: piIp, andUsername: piUsername)
        session?.connect()
        if let isConnected = session?.isConnected {
            print(isConnected)
            session?.authenticate(byPassword: piPassword)
            if let isAuthorized = session?.isAuthorized {
                VC.setLoadingPercentage(percentage: 0.2, status: "Updating Pi")
                do {
                    //update os
                    try session?.channel.execute("sudo apt-get update")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    try session?.channel.execute("sudo apt-get dist upgrade")
                    VC.setLoadingPercentage(percentage: 0.4, status: "Installing Git")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    //install git
                    try session?.channel.execute("sudo apt-get install git -y")
                    VC.setLoadingPercentage(percentage: 0.5, status: "Installing Node")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    //install node and npm
                    try session?.channel.execute("sudo apt-get install nodejs -y")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    try session?.channel.execute("sudo apt-get install npm -y && sudo ln -s /usr/bin/nodejs /usr/bin/node")
                    VC.setLoadingPercentage(percentage: 0.7, status: "Pulling Server Code")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    //pull repo
                    try session?.channel.execute("git clone https://github.com/MoritzGruber/RPI.git")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    VC.setLoadingPercentage(percentage: 0.8, status: "Installing node modules")
                    try session?.channel.execute("cd RPI && npm install")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    VC.setLoadingPercentage(percentage: 0.9, status: "Running Server")
                    try session?.channel.execute("sh RPI/start.sh &")
                    VC.setLoadingPercentage(percentage: 1.0, status: "Done")
                    try session?.disconnect()
                }
                    catch {
                        print("catchted error")
                
                    }
                }
        } else {
            print ("connection error")
        }
    }
}


