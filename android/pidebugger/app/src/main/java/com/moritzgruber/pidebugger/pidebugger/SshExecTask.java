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

//this class async executes driffrent commands with a ssh connection
//Commands(Stings) as given Params , Integer as progress Status and a String as Result (feedback)
public class SshExecTask extends AsyncTask<String, Integer, String> {

    @Override
    protected String doInBackground(String... params) {
        int count = params.length;
        String res = "";
        long totalSize = 0;
        //loop through all commands
        for (int i = 0; i < count; i++) {
            //we create new sessions to run diffrent commands at the same time
            JSch jsch = new JSch();
            Session session = null;
            try {
                //setup ssh
                session = jsch.getSession("pi", SetupInterfaceActivity.ipAddress, 22);
                session.setPassword("raspberry");

                // Avoid asking for key confirmation
                Properties prop = new Properties();
                prop.put("StrictHostKeyChecking", "no");
                session.setConfig(prop);
                //connect ssh
                session.connect();

                //open SSH Channel
                ChannelExec channelssh = (ChannelExec)
                        session.openChannel("exec");
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                channelssh.setOutputStream(outputStream);
                // Execute command from params
                channelssh.setCommand(params[i]);
                channelssh.connect(1800000); //this seems like bad code, but the framework has a bug if you use empty Brackets
                //now disconnect if the command has run throgh or half an our is over (timeout)
                channelssh.disconnect();

                res = res + " -- "+i+":" + outputStream.toString();

            } catch (JSchException e) {
                e.printStackTrace();
            }
            //update progress
            publishProgress((int) ((i / (float) count) * 100));
            // Escape early if cancel() is called
            if (isCancelled()) break;
        }

        return res;
    }

    @Override
    protected void onPostExecute(String s) {
        super.onPostExecute(s);
        //just log the result
        Log.i("ssh exec res:", s);
    }
    //update after each command
    protected void onProgressUpdate(Integer... progress) {
        SetupInterfaceActivity.updateProgress(progress[0]);
    }
}
