@isTest
private class TVRemoteControlTest {
    // test method to test increasing volume
    @isTest static void testVolumeIncrease() {
        TVRemoveControl rc = new TVRemoveControl(10);
        Integer newVolume = rc.increaseVolume(15);
        system.assertEquals(25, newVolume);

    }
    // test method to test decreaseing the volume
    @isTest static void testVolumeDecrease() {
        TVRemoveControl rc = new TVRemoveControl(20);
        Integer newVolume = rc.decreaseVolume(15);
        system.assertEquals(5, newVolume);
    }
    // test my other constric
    @isTest static void testConstructors() {
        TVRemoveControl rc1 = new TVRemoveControl();
        TVRemoveControl rc2 = new TVRemoveControl(5, 'mute');
        
        

    }
    //test method over mas
    @isTest static void testVolumeIncreaseOverMax() {
        TVRemoveControl rc = new TVRemoveControl(10);
        Integer newVol = rc.increaseVolume(100);
        system.assertEquals(50, newVol);
    }

    @isTest static void testVolumeDecreeaseBelowMin() {
        TVRemoveControl rc = new TVRemoveControl(10);
        Integer newVol = rc.decreaseVolume(100);
        system.assertEquals(0, newVol);

    }
    // test retrieving menu options
    @isTest static void testMenuOptions() {
        String menu = TVRemoveControl.getMenuOptions();
        Integer cnt = TVRemoveControl.howMany();
        system.assertNotEquals(null, menu);
    }
}