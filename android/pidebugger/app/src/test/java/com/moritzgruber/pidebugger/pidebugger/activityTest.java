package com.moritzgruber.pidebugger.pidebugger;

import android.content.Intent;
import android.test.ActivityUnitTestCase;
import android.test.suitebuilder.annotation.MediumTest;
import android.widget.Button;

import com.moritzgruber.pidebugger.pidebugger.R;
import com.moritzgruber.pidebugger.pidebugger.SetupInterfaceActivity;

import org.junit.Test;


//new test: check if views will be loaded correctly?

//check if skip button starts and loads next activitiy correctly
public class activityTest extends ActivityUnitTestCase<SetupInterfaceActivity> {

    private Intent mStartIntent;
    private Button mButton;


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
    }


    @MediumTest
    public void startPiInterfaceActivityTest() {

        SetupInterfaceActivity activity = startActivity(mStartIntent, null, null);
        mButton = (Button) activity.findViewById(R.id.scrollView);

        mButton.performClick();

        assertNotNull(getStartedActivityIntent());
        assertTrue(isFinishCalled());
    }


}
