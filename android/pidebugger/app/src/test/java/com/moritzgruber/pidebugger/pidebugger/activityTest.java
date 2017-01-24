package com.moritzgruber.pidebugger.pidebugger;

import android.content.Intent;
import android.test.ActivityUnitTestCase;
import android.test.suitebuilder.annotation.MediumTest;
import android.widget.Button;

import com.moritzgruber.pidebugger.pidebugger.R;
import com.moritzgruber.pidebugger.pidebugger.SetupInterfaceActivity;

import org.junit.Test;


//check if skip button works and loads the next activitiy correctly

public class activityTest extends ActivityUnitTestCase<SetupInterfaceActivity> {

    private Intent mStartIntent;
    private Button mButton;

    SetupInterfaceActivity activity;

    public activityTest() {
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
        mButton = (Button) getActivity().findViewById(R.id.skip);

        assertNotNull(getActivity());
        assertNotNull(mButton);

        startActivityTest();
    }



    @MediumTest
    public void startActivityTest() {

        SetupInterfaceActivity activity = startActivity(mStartIntent, null, null);
        mButton = (Button) activity.findViewById(R.id.skip);

        mButton.performClick();

        assertNotNull(getStartedActivityIntent());
        assertTrue(isFinishCalled());
    }


}
