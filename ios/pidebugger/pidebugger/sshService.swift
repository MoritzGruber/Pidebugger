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
                print("step1")
                do {
                    //update os
                    try session?.channel.execute("sudo apt-get update")
                    print("step2")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    try session?.channel.execute("sudo apt-get dist upgrade")
                    print("step3")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    //install git
                    try session?.channel.execute("sudo apt-get install git -y")
                    print("step4")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    //install node and npm
                    try session?.channel.execute("sudo apt-get install nodejs -y")
                    print("step5")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    try session?.channel.execute("sudo apt-get install npm -y && sudo ln -s /usr/bin/nodejs /usr/bin/node")
                    print("step6")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    //pull repo
                    try session?.channel.execute("git clone https://github.com/MoritzGruber/RPI.git")
                    print("step7")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    //npm install
                    try session?.channel.execute("cd RPI && npm install")
                    print("step8")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    //start npm
                    try session?.channel.execute("node RPI/server.js &")
                    print("step9")
                    print(session?.channel.lastResponse ?? "no respone of last command")
                    try session?.channel.execute("pwd")
                    print(session?.channel.lastResponse ?? "no respone of last command")

                    
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


