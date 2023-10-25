// RLV function to blur the vision of a victim
// This code is for educational purposes only. Use at your own risk.

// Define the RLV command to blur vision
string BLUR_VISION = "!vision/<0'0'0>/1.0/*/*/*/*";

// Define the victim's key
key victim;

default
{
    state_entry()
    {
        // Scan for victims in the region
        llSensor("", NULL_KEY, AGENT, 96.0, PI);

        // Wait for the sensor results to be returned
        llSleep(2.0);

        // Display a dialog menu to choose the victim
        list names;
        integer i;
        for (i = 0; i < llGetNumberOfSensedEntities(); i++)
        {
            names += llKey2Name(llDetectedKey(i));
        }
        llDialog(llDetectedName(0) + ", who would you like to restrict?", names, 1);
    }

    sensor(integer total_number)
    {
        // Do nothing if no agents are detected
    }

    no_sensor()
    {
        // Do nothing if no agents are detected
    }

    changed(integer change)
    {
        // Check if the dialog menu was answered
        if (change & CHANGED_DIALOG)
        {
            // Get the key of the selected victim
            integer option = llListFindList(llGetListEntryTypes(llDialogGetName(), [LIST]), llGetListEntryTypes(llDialogGetResponse(), [STRING]));
            victim = llDetectedKey(option);
            
            // Restrict the victim's vision using RLV
            llRegionSayTo(victim, 0, BLUR_VISION);
        }
    }

    attach(key id)
    {
        // Check if the object is attached to the victim's head
        if (id == victim)
        {
            // Restrict the victim's vision using RLV
            llRegionSayTo(victim, 0, BLUR_VISION);
        }
    }

    detach()
    {
        // Remove the restriction on the victim's vision using RLV
        llRegionSayTo(victim, 0, "!vision");
    }
}
