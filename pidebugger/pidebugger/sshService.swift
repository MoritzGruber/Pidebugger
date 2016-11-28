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
    
   
    static func start(ip: String){
    let session = NMSSHSession(host: ip, andUsername: "root")
    session?.connect()
    if let isConnected = session?.isConnected {
    print(isConnected)
    session?.authenticate(byPassword: "********")
    if let isAuthorized = session?.isAuthorized {
    print("auth = /(isAuthorized)")
    do {
    try print(session?.channel.execute("git clone https://github.com/MoritzGruber/RPI.git"))
        //install node
        //pull repo
        //npm install
        //run start
    
    
    } catch {
    print("catchted error")
    
    }
    
    
    print("run trough")
    
    
    }
    }

    }
    
}


