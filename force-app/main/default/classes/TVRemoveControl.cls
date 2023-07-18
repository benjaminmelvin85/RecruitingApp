public with sharing class TVRemoveControl {
    
    // create an instance member variable
    Integer volume;

    // create a static variable
    public static Integer count = 0;

    // create a constant to hold the max volume
    static final Integer MAX_VOLUME = 50;
    
    public TVRemoveControl() {
        // set initial value for volume
        volume = 0;
        count++;
    }
    // overload the constructor to accept a value for volume
    public TVRemoveControl(Integer v) {
        // set initial value for volume
        volume = v;
        count++;
    }

    public TVRemoveControl(Integer v, String mute) {
        // set initial value for volume
        volume = v;
        system.debug('Constructor with two parms');
        count++;
    }

    // create an instance method to increase the volume
    public Integer increaseVolume(Integer amount) {
        volume += amount;

        // check to see if volume is greater than MAX
        if (volume > MAX_VOLUME) {
            volume = MAX_VOLUME;
        }

        // return the value of volume
        return volume;
    }

    // create an instance method to decrease the volume
    public Integer decreaseVolume(Integer amount) {
        volume -= amount;

        // check to see if volume is less than zero
        if (volume < 0) {
            volume = 0;
        }

        return volume;
    }

    // create a static method to return some menu options
    public static String getMenuOptions() {
        return 'AUDIO SETTTING - VIDEO SETTINGS';
    }

    public static Integer howMany() {
        return count;
    }
}