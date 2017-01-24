package com.moritzgruber.pidebugger.pidebugger;


import android.support.test.espresso.Espresso;
import android.support.test.rule.ActivityTestRule;
import android.test.suitebuilder.annotation.LargeTest;
import android.view.View;
import android.widget.Button;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import static android.support.test.espresso.Espresso.onView;
import static android.support.test.espresso.action.ViewActions.click;
import static android.support.test.espresso.action.ViewActions.closeSoftKeyboard;
import static android.support.test.espresso.action.ViewActions.typeText;
import static android.support.test.espresso.assertion.ViewAssertions.matches;
import static android.support.test.espresso.matcher.ViewMatchers.isClickable;
import static android.support.test.espresso.matcher.ViewMatchers.isDisplayed;
import static android.support.test.espresso.matcher.ViewMatchers.withId;
import static android.support.test.espresso.matcher.ViewMatchers.withText;
import static junit.framework.Assert.assertTrue;


//check if skip and setup buttonn of setupinterface will be loaded correctly

@RunWith(JUnit4.class)
@LargeTest
public class SetupInterfaceButtonsTest {


    @Rule
    public ActivityTestRule<SetupInterfaceActivity> mActivityRule = new ActivityTestRule<>(
            SetupInterfaceActivity.class);

    @Before
    public void initButton() {

        onView(withId(R.id.skip)).check(matches(isDisplayed()));
        onView(withId(R.id.setup)).check(matches(isDisplayed()));
    }

    @Test
    public void checkButton() {

        onView(withId(R.id.skip)).check(matches(isClickable()));
        onView(withId(R.id.setup)).check(matches(isClickable()));
    }

}

