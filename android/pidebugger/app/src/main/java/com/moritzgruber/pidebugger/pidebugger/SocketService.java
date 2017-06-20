package com.moritzgruber.pidebugger.pidebugger;

import android.util.Log;

import java.net.URISyntaxException;

import io.socket.client.IO;
import io.socket.client.Socket;

public class SocketService {

    //internal variables
    private Socket mSocket;
    private String ip;

    public SocketService() {
        // Body of constructor
        //create a socket instance with the ip of the setup activity
        {
            try {
                ip = SetupInterfaceActivity.ipAddress;
                mSocket = IO.socket("http://" + ip);
            } catch (URISyntaxException e) {}
        }
    }
    //connect to the server
    public void connect() {
        mSocket.connect();
    }
    //send a signal to the server
    public void send(Integer pin, Integer Value){
        //on a pin number emit a state value
        mSocket.emit("set", pin, Value);
        Log.w(" Socket send ", "Pin:" +pin + " Value:"+ Value);
    }
}
