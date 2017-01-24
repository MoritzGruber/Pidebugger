package com.moritzgruber.pidebugger.pidebugger;

import android.content.Intent;
import android.test.ActivityUnitTestCase;
import android.test.suitebuilder.annotation.SmallTest;
import android.widget.TextView;



public class SetupInterfaceTest extends ActivityUnitTestCase<SetupInterfaceActivity>  {

    // Activity of the Target application
    SetupInterfaceActivity activity;

    // TextView of the MainActivity to be tested
    TextView tvWelcome;

    public SetupInterfaceTest() {
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
