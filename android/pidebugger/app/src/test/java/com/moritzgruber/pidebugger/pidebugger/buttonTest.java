package com.moritzgruber.pidebugger.pidebugger;


import android.content.Intent;
import android.test.ActivityUnitTestCase;
import android.test.suitebuilder.annotation.MediumTest;
import android.widget.Button;

public class buttonTest extends ActivityUnitTestCase<SetupInterfaceActivity> {


    private Intent mStartIntent;
    private Button skipButton;
    private Button setupButton;


    public buttonTest() {
        super(SetupInterfaceActivity.class);
    }


    @Override
    protected void setUp() throws Exception {
        super.setUp();

        mStartIntent = new Intent(Intent.ACTION_MAIN);
    }


    @MediumTest
    public void testPreconditions() {
        startActivity(mStartIntent, null, null);
        skipButton = (Button) getActivity().findViewById(R.id.skip);
        setupButton = (Button) getActivity().findViewById(R.id.setup);

        assertNotNull(skipButton);
        assertNotNull(setupButton);

        startPiInterfaceActivityTest();
    }


    @MediumTest
    public void startPiInterfaceActivityTest() {

        SetupInterfaceActivity activity = startActivity(mStartIntent, null, null);


        skipButton = (Button) activity.findViewById(R.id.testbtn);
        setupButton = (Button) activity.findViewById(R.id.testbtn);


        //mButton = (Button) activity.findViewById(R.id.testbtn);

        skipButton.performClick();

        assertNotNull(getStartedActivityIntent());
        assertTrue(isFinishCalled());

    }


}



