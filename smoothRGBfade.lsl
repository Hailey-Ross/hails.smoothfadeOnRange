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

float hailRed = 0;
float hailGrn = 1;
float hailBlu = 0;
string color = "hailsRedUp";

default
{
    on_rez(integer start_param)
    {
        llResetScript();
    }

    changed(integer change)
    {
        if (change & CHANGED_OWNER)
            llResetScript();
    }

    state_entry()
    {
        llSleep(llFrand(5));
        llSetTimerEvent(TIMER_INTERVAL);
        
        integer prims = llGetNumberOfPrims();
        integer i;
        for (i = 0; i <= prims; i++)
        {
            llSetLinkPrimitiveParamsFast(i, [PRIM_COLOR, ALL_SIDES, <hailRed, hailGrn, hailBlu>, 0.0]);
        }
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
        }
        else if (target_visibility == 0 && current_alpha > 0.0)
        {
            current_alpha -= FADE_STEP;
            if (current_alpha < 0.0) current_alpha = 0.0;
        }

        if(color == "hailsRedUp")
        {
            if(hailRed <= 1)
                hailRed += 0.05;
            else
                color = "hailsGrnDown";
        }
        else if(color == "hailsRedDown")
        {
            if(hailRed >= 0)
                hailRed -= 0.05;
            else
                color = "hailsGrnUp";
        }  
        else if(color == "hailsGrnUp")
        {
            if(hailGrn <= 1)
                hailGrn += 0.05;
            else
                color = "hailsBluDown";
        }   
        else if(color == "hailsGrnDown")
        {
            if(hailGrn >= 0)
                hailGrn -= 0.05;
            else
                color = "hailsBluUp";
        }   
        else if(color == "hailsBluUp")
        {
            if(hailBlu <= 1)
                hailBlu += 0.05;
            else
                color = "hailsRedDown";
        }   
        else if(color == "hailsBluDown")
        {
            if(hailBlu >= 0)
                hailBlu -= 0.05;
            else
                color = "hailsRedUp";
        }

        integer prims = llGetNumberOfPrims();
        integer j;
        for (j = 0; j <= prims; j++)
        {
            llSetLinkPrimitiveParamsFast(j, [PRIM_COLOR, ALL_SIDES, <hailRed, hailGrn, hailBlu>, current_alpha]);
        }
    }
}
