//
//  ViewController.swift
//  pidebugger
//
//  Created by Moritz Gruber on 17/10/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let socket = SocketIOClient(socketURL: URL(string: "http://10.60.45.94:3000")!, config: [.log(true), .forcePolling(true)])
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.emit("set", 40, 1);
        
        socket.connect();
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

