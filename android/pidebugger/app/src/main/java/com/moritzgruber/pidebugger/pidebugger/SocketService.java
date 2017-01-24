package com.moritzgruber.pidebugger.pidebugger;

import android.util.Log;

import java.net.URISyntaxException;

import io.socket.client.IO;
import io.socket.client.Socket;

public class SocketService {

    private Socket mSocket;
    private String ip;

    public SocketService() {
        // Body of constructor
        {
            try {
                ip = SetupInterfaceActivity.ipAddress;
                Log.w("ip in socket = ", ip);
                mSocket = IO.socket("http://" + ip);
            } catch (URISyntaxException e) {}
        }
    }

    public void connect() {
        mSocket.connect();
    }
    public void send(Integer pin, Integer Value){
        mSocket.emit("set", pin, Value);
        Log.w(" Socket send ", "Pin:" +pin + " Value:"+ Value);
    }
}
