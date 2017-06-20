package com.moritzgruber.pidebugger.pidebugger;

import android.os.AsyncTask;
import android.util.Log;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Collections;
import java.util.List;

/**
 * Created by morris on 16.01.2017.
 */
// This class runs async in the background and scans the network for a device sold by the Raspberry Pi Foundation and returns its ip address
public class SearchForPiIpAddressTask extends AsyncTask<Void, Integer, String> {

    final String TAG = "SearchIP";

    @Override
    protected String doInBackground(Void... voids) {
        //To start we get our own ip
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
        //we use our ip to get the our subnet
        String subnet = ipAddress.substring(0, ipAddress.length()-4);
        //search the subnet for other devices that answer to pings with this command
        final String CMD = "/system/bin/ping -c 1 %s";

        String resultIp = "";
        //loop through the whole subnet
        for (int i = 0; i < 255; i++) {
            //increment ip address
            String host = subnet + "." + i;
            try {
                //execute ping
                Process exec = Runtime.getRuntime().exec(String.format(CMD, host));
                int exitValue = exec.waitFor();
                if (exitValue == 0){ //ping was succsessful
                    InetAddress a = InetAddress.getByName(host);
                    //get mac address
                    String macAd = NetworkService.getMacFromArpCache(a.getHostAddress());
                    String aVendor;
                    try {
                        aVendor = NetworkService.getVendor("http://api.macvendors.com/" + macAd);
                        //check if its the right vendor
                        if(aVendor.contains("aspberry")){
                            //we have found a raspberry pi
                            //save results and break the loop
                            resultIp = host;
                            //set i to 255 so the loop stops
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
            //update progress
            publishProgress((int) ((i / (float) 255) * 100));
        }

        return resultIp;
    }

    protected void onPostExecute(String result) {
        //update the ui and save the ip
        SetupInterfaceActivity.updateProgress(100);
        SetupInterfaceActivity.statusText.setText("Successful: Pi has IP " + result);
        SetupInterfaceActivity.ipAddress = result;
        SetupInterfaceActivity.enableButton(SetupInterfaceActivity.setupButton);
        SetupInterfaceActivity.enableButton(SetupInterfaceActivity.skipButton);


    }

    protected void onProgressUpdate(Integer... progress) {
        //send progress informations to ui thread
        SetupInterfaceActivity.updateProgress(progress[0]);

    }


}
