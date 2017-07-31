//
//  TeamRoomNotify.cpp
//  VoiceTutorial
//
//  Created by apollo on 8/23/16.
//
//
#include "CLuaHelper.h"
#include "GvoiceListener.h"



TeamRoomNotify::TeamRoomNotify()
{
    
}

void TeamRoomNotify::OnJoinRoom(gcloud_voice::GCloudVoiceCompleteCode code, const char *roomName, int memberID)
{
    if (code == gcloud_voice::GV_ON_JOINROOM_SUCC) {
        CCLOG("joinsuccess!!!!!!!!!! %d", memberID);
        gcloud_voice::GetVoiceEngine()->OpenSpeaker();
        //通知到服务器要把我加入到聊天室
       
        cocos2d::ValueMap valueMap;
        valueMap["memberID"] = Value(memberID);
        CLuaHelper::getInstance()->callbackLuaFunc("C2Lua_GvoiceLoginResponse",valueMap);
       
    } else {
        
    }
}

void TeamRoomNotify::OnStatusUpdate(gcloud_voice::GCloudVoiceCompleteCode status, const char *roomName, uint32_t memberID)
{
    if (status == gcloud_voice::GV_ON_JOINROOM_SUCC) {
        CCLOG("memberid _ls=====================%d",memberID);
    } else {
        
        
    }
}

void TeamRoomNotify::OnQuitRoom(gcloud_voice::GCloudVoiceCompleteCode code, const char *roomName)
{
    if (code == gcloud_voice::GV_ON_QUITROOM_SUCC) {
       CCLOG("quicksuccess!!!!!!!!!!");
        
    } else {
        CCLOG("quickfailed!!!!!!!!!!");
    }
}

void TeamRoomNotify::OnMemberVoice (const unsigned int *members, int count)
{
    for (int i=0; i<count; i++) {
        CCLOG("member %d's status is %d", *(members+2*i), *(members+2*i+1));
        //通知到服务器要把我加入到聊天室
        cocos2d::ValueMap valueMap1;
        valueMap1["memberID"] = int(*(members+2*i));
        valueMap1["status"] = int(*(members+2*i+1));
        CLuaHelper::getInstance()->callbackLuaFunc("C2Lua_GvoiceUserStateChange",valueMap1);
    }
}
