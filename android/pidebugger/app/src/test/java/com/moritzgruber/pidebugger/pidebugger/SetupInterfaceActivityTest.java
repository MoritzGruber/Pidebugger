package com.moritzgruber.pidebugger.pidebugger;

import android.content.Intent;
import android.test.ActivityUnitTestCase;
import android.test.suitebuilder.annotation.SmallTest;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.moritzgruber.pidebugger.pidebugger.SetupInterfaceActivity;
import com.moritzgruber.pidebugger.pidebugger.R;

import dalvik.annotation.TestTargetClass;

import org.junit.Test;
import org.junit.runner.RunWith;

import java.util.regex.Pattern;

import static android.R.attr.button;
import static android.R.attr.fingerprintAuthDrawable;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;




public class SetupInterfaceActivityTest extends ActivityUnitTestCase<SetupInterfaceActivity> {

    private Button skipButton;
    private Button setupButton;

    // Activity of the Target application
   SetupInterfaceActivity activity;

    // TextView of the MainActivity to be tested
    TextView tvWelcome;

    public SetupInterfaceActivityTest() {
        super(SetupInterfaceActivity.class);
    }

    @Override
    protected void setUp() throws Exception {
        super.setUp();

        // Starts the MainActivity of the target application
        startActivity(new Intent(getInstrumentation().getTargetContext(), SetupInterfaceActivity.class), null, null);

        // Getting a reference to the MainActivity of the target application
        activity = (SetupInterfaceActivity)getActivity();

        // Getting a reference to the TextView of the MainActivity of the target application
        tvWelcome = (TextView) activity.findViewById(R.id.textView);


    }

    @Override
    protected void tearDown() throws Exception {
        super.tearDown();
    }


    @SmallTest
    public void testHello(){
        // The actual text displayed in the textview
        String actual=tvWelcome.getText().toString();

        // The expected text to be displayed in the textview
        String expected = "Welcome to PiDebugger";

        // Check whether both are equal, otherwise test fails
        assertEquals(expected,actual );
    }





}
