package com.finance.automation;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

class KarateRunner {

    @Test
    Karate runAll() {
        return Karate.run().relativeTo(getClass());
    }
}
