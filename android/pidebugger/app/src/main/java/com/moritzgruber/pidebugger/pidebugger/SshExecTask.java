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

public class SshExecTask extends AsyncTask<String, Integer, String> {


    @Override
    protected String doInBackground(String... params) {
        int count = params.length;
        String res = "";
        long totalSize = 0;
        //loop through all commands
        for (int i = 0; i < count; i++) {
            //execute the command
            JSch jsch = new JSch();
            Session session = null;
            try {
                session = jsch.getSession("pi", SetupInterfaceActivity.ipAddress, 22);

                session.setPassword("raspberry");

                // Avoid asking for key confirmation
                Properties prop = new Properties();
                prop.put("StrictHostKeyChecking", "no");
                session.setConfig(prop);

                session.connect();
                Log.w("ssh exec ", " connected " +i);
                // SSH Channel
                ChannelExec channelssh = (ChannelExec)
                        session.openChannel("exec");
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                channelssh.setOutputStream(baos);
                Log.w("ssh exec res:", "before...");
                // Execute command
                channelssh.setCommand(params[i]);
                channelssh.connect(1000000);
                Log.w("ssh exec res:", "" +channelssh.isEOF());

                channelssh.disconnect();

                res = baos.toString();
                Log.w("ssh exec res:", res);

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
        Log.w("ssh exec res:", s);

    }

    protected void onProgressUpdate(Integer... progress) {
        SetupInterfaceActivity.updateProgress(progress[0]);

    }
}
