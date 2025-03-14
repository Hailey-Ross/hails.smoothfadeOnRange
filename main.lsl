// Script Created by Hailey Enfield
// Site: https://u.hails.cc/Links
// Github: https://github.com/Hailey-Ross/hails.smoothfadeOnRange
// PLEASE LEAVE ALL CREDITS/COMMENTS INTACT

integer RANGE = 10; // Detection range in meters
float FADE_STEP = 0.05; // Amount to change per step (lower = smoother)
float TIMER_INTERVAL = 0.1; // How often the script updates (affects fade smoothness)
float CHECK_INTERVAL = 2.0; // How often to check for avatars
float current_alpha = 0.0; // Start fully invisible
integer target_visibility = 0; // 1 = should be visible, 0 = should be invisible
float last_check_time = 0.0;

default
{
    state_entry()
    {
        llSetAlpha(0.0, ALL_SIDES); 
        llSetTimerEvent(TIMER_INTERVAL); 
    }

    timer()
    {
        float now = llGetTime(); 
        if (now - last_check_time >= CHECK_INTERVAL) 
        {
            last_check_time = now;
            list detected = llGetAgentList(AGENT_LIST_REGION, []);
            integer count = llGetListLength(detected);
            integer i;
            integer found = FALSE;

            for (i = 0; i < count; i++)
            {
                key avatar = llList2Key(detected, i);
                vector avatar_pos = llList2Vector(llGetObjectDetails(avatar, [OBJECT_POS]), 0);
                vector object_pos = llGetPos();

                if (llVecDist(avatar_pos, object_pos) <= RANGE)
                {
                    found = TRUE;
                }
            }
            
            target_visibility = found; 
        }

        if (target_visibility == 1 && current_alpha < 1.0)
        {
            current_alpha += FADE_STEP;
            if (current_alpha > 1.0) current_alpha = 1.0;
            llSetAlpha(current_alpha, ALL_SIDES);
        }
        else if (target_visibility == 0 && current_alpha > 0.0)
        {
            current_alpha -= FADE_STEP;
            if (current_alpha < 0.0) current_alpha = 0.0;
            llSetAlpha(current_alpha, ALL_SIDES);
        }
    }
}
