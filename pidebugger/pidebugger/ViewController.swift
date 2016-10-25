//
//  ViewController.swift
//  pidebugger
//
//  Created by Moritz Gruber on 17/10/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import UIKit
import SocketIO
import NMSSH

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pi = raspberrypi.init()
        print("              PI:  \( pi.pins[1])");
        let socket = SocketIOClient(socketURL: URL(string: "http://10.60.45.94:3000")!, config: [.log(true), .forcePolling(true)])
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.emit("set", 40, 1);
        
        socket.connect();
 
        let session = NMSSHSession(host: "138.68.74.156", andUsername: "root")
        session?.connect()
        if let isConnected = session?.isConnected {
            print(isConnected)
            session?.authenticate(byPassword: "asdf1234")
            /*if let isAuthorized = session?.isAuthorized {
                print("auth = /(isAuthorized)")
                
                do {
                    try{
                        print(session?.channel.execute("ls"))
                    }
                    
                } catch {
                    print("sasfd")
                }
                
            }*/
        }
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

