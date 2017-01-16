package com.moritzgruber.pidebugger.pidebugger.networkScanner.com.unwind.netTools;

import android.os.AsyncTask;
import android.util.Log;

import java.io.IOException;
import java.net.InetAddress;
import java.net.URL;
import java.util.LinkedList;
import java.util.List;

public class DiscoverRunner extends AsyncTask<Void, Integer, Long> implements Runnable {
    private static final String CMD = "/system/bin/ping -c 1 %s";
    private static final String TAG = "DiscoverRunner";
    private List<InetAddress> results;

    private String subnet;
    private Integer startAdd;
    private Integer numAdds;

    public DiscoverRunner(String subnet, Integer start, Integer steps) {
        this.subnet = subnet;
        this.startAdd = start;
        this.numAdds = steps;
        results = new LinkedList<InetAddress>();
    }

    @Override
    public void run() {
        int timeout = 4000;
        Log.w("in run", " there was");
        for (int i = startAdd; i < startAdd + numAdds; i++) {
            String host = subnet + "." + i;

            try {
                Process exec = Runtime.getRuntime().exec(String.format(CMD, host));
                int i1 = exec.waitFor();
                if (i1 == 0){
                    InetAddress a = InetAddress.getByName(host);
                    Log.i(TAG, "run: "+ a.getHostAddress());
                    results.add(a);
                    String macAd = Pinger.getMacFromArpCache(a.getHostAddress());
                    String vendorA;
                    Log.i(TAG, "mac of run: "+ macAd);

                    try {
                        vendorA = Pinger.getVendor("http://api.macvendors.com/" + macAd);
                        Log.i(TAG, "vendor of run: "+ vendorA);

                    }catch(java.lang.Exception e3) {
                        vendorA = "";
                    }

                }else {
                    throw new IOException("Unable to get ping from runtime");
                }
            } catch (IOException | InterruptedException e) {
                try {
                    InetAddress a = InetAddress.getByName(host);
                    Log.w("in run", "" + a);
                    if (a.isReachable(timeout)) {
                        results.add(a);
                    }
                } catch (IOException ioe) {
                    ioe.printStackTrace();
                }
            }

        }
    }

    public List<InetAddress> getResults() {
        return results;
    }

    @Override
    protected Long doInBackground(Void... params) {
        return null;
    }
}
