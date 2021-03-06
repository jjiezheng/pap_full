--王汗的愤怒

--MisDescBegin
x201009_g_ScriptId = 201009
--x201009_g_MissionIdPre =41
x201009_g_MissionId = 91
x201009_g_MissionKind = 2
x201009_g_MissionLevel = 10
x201009_g_ScriptIdNext = {ScriptId = 201008 ,LV = 1 }
x201009_g_Name	="王汗" 
x201009_g_DemandItem ={}
x201009_g_DemandKill ={{id=474,num=20}}

x201009_g_MissionName="王汗的愤怒"
x201009_g_MissionInfo="    我是克烈部的王汗，铁木真是我的义子，这件事让我十分的愤怒！\n \n    我见过孛儿帖，她是一个非常漂亮贤淑的女人，铁木真9岁的时候跟她定亲，18岁娶她过门，我的貂皮大衣就是他们夫妻送的。\n \n    蔑里乞人偷袭我义子的部落，抢走了孛儿帖，他们真该死，即便是真主也不会原谅蔑里乞人。\n \n    "  --任务描述
x201009_g_MissionInfo2="，听着进攻的号声，消灭#G罕难河上郡#W的那些#R弓箭守卫#W，他们的冷箭实在让我不喜欢！"
x201009_g_MissionTarget="    #G王汗#W命你去消灭#G罕难河上郡#W的20名#R弓箭守卫#W。"		                                                                                               
x201009_g_MissionComplete="    你很英勇，是不可多得的人才。"					--完成任务npc说话的话
x201009_g_ContinueInfo="    听从号令，消灭那些弓箭守卫！"
--任务奖励
x201009_g_MoneyBonus = 1

--固定物品奖励，最多8种
x201009_g_ItemBonus={}

--可选物品奖励，最多8种
x201009_g_RadioItemBonus={}

--MisDescEnd
x201009_g_ExpBonus = 50
--**********************************

--任务入口函数

--**********************************

function x201009_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x201009_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x201009_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x201009_g_MissionId)
		if x201009_CheckSubmit(sceneId, selfId, targetId) <= 0 then
     	  BeginEvent(sceneId)
				AddText(sceneId,"#Y"..x201009_g_MissionName)
				AddText(sceneId,x201009_g_ContinueInfo)
		  	AddText(sceneId,"#Y任务目标#W") 
				AddText(sceneId,x201009_g_MissionTarget) 
				AddText(sceneId,format("\n    杀死弓箭守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x201009_g_DemandKill[1].num ))
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
		end

		if x201009_CheckSubmit(sceneId, selfId, targetId) > 0 then
        BeginEvent(sceneId)
        AddText(sceneId,"#Y"..x201009_g_MissionName)
		    AddText(sceneId,x201009_g_MissionComplete)
		    AddMoneyBonus(sceneId, x201009_g_MoneyBonus)
		    EndEvent()
        DispatchMissionContinueInfo(sceneId, selfId, targetId, x201009_g_ScriptId, x201009_g_MissionId)
    end

  elseif x201009_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x201009_g_MissionName)
      AddText(sceneId,x201009_g_MissionInfo..GetName(sceneId, selfId)..x201009_g_MissionInfo2) 
			AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x201009_g_MissionTarget) 
			AddMoneyBonus(sceneId, x201009_g_MoneyBonus)
			EndEvent()
			DispatchMissionInfo(sceneId, selfId, targetId, x201009_g_ScriptId, x201009_g_MissionId)
  end
	
end



--**********************************

--列举事件

--**********************************

function x201009_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x201009_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x201009_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x201009_g_ScriptId, x201009_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x201009_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x201009_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x201009_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==1) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x201009_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x201009_g_MissionId, x201009_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x201009_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x201009_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x201009_g_MissionId)
	for i, item in pairs(x201009_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x201009_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x201009_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,1) == x201009_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x201009_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x201009_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x201009_g_MissionId)
		AddExp(sceneId, selfId, x201009_g_ExpBonus)
		AddMoney(sceneId, selfId, x201009_g_MoneyBonus)
		for i, item in pairs(x201009_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x201009_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x201009_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x201009_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x201009_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x201009_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,1) 
	 	 if objdataId == x201009_g_DemandKill[1].id then 
       		    if num < x201009_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,1,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死弓箭守卫   %d/%d", GetMissionParam(sceneId,selfId,misIndex,1),x201009_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    else
		    	SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		    end
		    
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x201009_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x201009_OnItemChanged(sceneId, selfId, itemdataId)

end

