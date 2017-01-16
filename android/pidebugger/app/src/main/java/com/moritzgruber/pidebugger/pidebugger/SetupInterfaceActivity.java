package com.moritzgruber.pidebugger.pidebugger;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import org.apache.http.conn.util.InetAddressUtils;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Collections;
import java.util.List;

public class SetupInterfaceActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.setup_interface_screen);

        //find the skip button and switch to the piInterface if you press it
        final Button button = (Button) findViewById(R.id.skip);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
                startActivity(new Intent(SetupInterfaceActivity.this, PiInterfaceActivity.class));
            }
        });

        //testing socket ...
        final SocketService mySocket = new SocketService("http://10.60.60.254:3000");
        mySocket.connect();
        final Button button2 = (Button) findViewById(R.id.setup);
        button2.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
                String[] strArray = new String[]{"root@138.68.74.156","Bar","Baz"};
                Log.w("in setup", "main");

                ssh.main(strArray);
//                mySocket.send();
//                Log.w("socket", "connected");
//                startActivity(new Intent(SetupInterfaceActivity.this, Scan.class));


            }
        });
        //testing stuff with ip

        String aipv4 = "";
        try {
            String ipv4;
            List<NetworkInterface> nilist = Collections.list(NetworkInterface.getNetworkInterfaces());
            if(nilist.size() > 0){
                for (NetworkInterface ni: nilist){
                    List<InetAddress>  ialist = Collections.list(ni.getInetAddresses());
                    if(ialist.size()>0){
                        for (InetAddress address: ialist){
                            if (!address.isLoopbackAddress() && InetAddressUtils.isIPv4Address(ipv4=address.getHostAddress())){
                                aipv4 = ipv4;
                            }
                        }
                    }

                }
            }

        } catch (SocketException ex) {
            Log.w("try", "exeton");

        }
        //Log.w("aipv4", aipv4);
        //DiscoverRunner runner = new DiscoverRunner(aipv4.substring(0, aipv4.length()-4), 0, 1);
        //Log.w("aipv4", " after create");

        // runner.run();
        //Log.w("aipv4", "done");


         //   JSch jsch=new JSch();
        //try{
        //    Session session=jsch.getSession("root", "138.68.74.156", 22);
        //    session.connect(3000);
        //} catch(Exception e){

        //}



            try {
                Thread.sleep(0);
                //Log.w("pinger", Pinger.getDevicesOnNetwork(aipv4.substring(0, aipv4.length()-4)).toString());



            }
            catch (Exception e){
                System.err.println(e);
            }




    }
}
