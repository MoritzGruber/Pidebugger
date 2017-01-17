package com.moritzgruber.pidebugger.pidebugger;

import android.os.AsyncTask;
import android.util.Log;

import com.moritzgruber.pidebugger.pidebugger.networkScanner.com.unwind.netTools.Pinger;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Collections;
import java.util.List;

/**
 * Created by morris on 16.01.2017.
 */

public class SearchForPiIpAdressTask extends AsyncTask<Void, Integer, String> {

    final String TAG = "SearchForPiIpAdressTask";

    @Override
    protected String doInBackground(Void... voids) {
        //step 1 get own ip


        String ipAddress = "";
        try {

            List<NetworkInterface> nilist = Collections.list(NetworkInterface.getNetworkInterfaces());
            if(nilist.size() > 0){
                for (NetworkInterface ni: nilist){
                    List<InetAddress>  ialist = Collections.list(ni.getInetAddresses());
                    if(ialist.size()>0){
                        for (InetAddress addr: ialist){
                            if (!addr.isLoopbackAddress()) {
                                String sAddr = addr.getHostAddress();
                                boolean isIPv4 = sAddr.indexOf(':')<0;
                                if (isIPv4)
                                    ipAddress = sAddr;

                            }
                        }
                    }

                }
            }

        } catch (SocketException ex) {
            Log.w("Get IP", "Cannot get own ip");

        }
        //use the ip to get subnet
        String subnet = ipAddress.substring(0, ipAddress.length()-4);
        //search the subnet for other devices that answer to pings
         final String CMD = "/system/bin/ping -c 1 %s";

        String resultIp = "";
        //loop through the whole subnet
        for (int i = 0; i < 255; i++) {
            String host = subnet + "." + i;
            try {
                Process exec = Runtime.getRuntime().exec(String.format(CMD, host));
                int exitValue = exec.waitFor();
                if (exitValue == 0){ //ping was succsessful
                    InetAddress a = InetAddress.getByName(host);
                    String macAd = Pinger.getMacFromArpCache(a.getHostAddress());
                    String aVendor;
                    try {
                        aVendor = Pinger.getVendor("http://api.macvendors.com/" + macAd);
                        //check if its the right vendor
                        if(aVendor.contains("aspberry")){
                            //save results and break the loop
                            resultIp = host;
                            i = 255;
                        }

                    }catch(java.lang.Exception e3) {
                        aVendor = "";
                    }

                }else {
                    Log.i(TAG, "Unable to get ping from " + host);
                }
            } catch ( Exception e) {
                Log.i(TAG, "Unable to execute ping");
            }
        }

        return resultIp;
    }

    protected void onPostExecute(String result) {
        Log.w("SearchForPiIpAdressTask", "Pi has ip " + result + " as result of scan");
    }
}
