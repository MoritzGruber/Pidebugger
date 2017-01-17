package com.moritzgruber.pidebugger.pidebugger;

import android.os.AsyncTask;
import android.util.Log;

import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

import java.io.ByteArrayOutputStream;
import java.util.Properties;

/**
 * Created by moritz on 17/01/2017.
 */

public class SshConnectAsync extends AsyncTask<String, Void, String> {


    @Override
    protected String doInBackground(String... params) {

        String res = "";
        JSch jsch = new JSch();
        Session session = null;
        try {
            session = jsch.getSession("pi", "192.168.0.100", 22);

            session.setPassword("raspberry");

            // Avoid asking for key confirmation
            Properties prop = new Properties();
            prop.put("StrictHostKeyChecking", "no");
            //prop.put("kex", "diffie-hellman-group-exchange-sha256");
            session.setConfig(prop);

            session.connect();

            // SSH Channel
            ChannelExec channelssh = (ChannelExec)
                    session.openChannel("exec");
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            channelssh.setOutputStream(baos);
            Log.w("ssh exec res:", "before...");
            // Execute command
            channelssh.setCommand("pwd");
            channelssh.connect(1000000);
            Log.w("ssh exec res:", "" +channelssh.isEOF());

            channelssh.disconnect();

            res = baos.toString();
            Log.w("ssh exec res:", res);

        } catch (JSchException e) {
            e.printStackTrace();
        }
        return res;
    }

    @Override
    protected void onPostExecute(String s) {
        super.onPostExecute(s);
        Log.w("ssh exec res:", s);

    }
}
