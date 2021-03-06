--西路兵马

--MisDescBegin
x207011_g_ScriptId = 207011
--x207011_g_MissionIdPre =41
x207011_g_MissionId = 273
x207011_g_MissionKind = 18
x207011_g_MissionLevel = 75
--x207011_g_ScriptIdNext = {ScriptId = 207008 ,LV = 1 }
x207011_g_Name	="拖雷" 
x207011_g_DemandItem ={}
x207011_g_DemandKill ={{id=413,num=20}}

x207011_g_MissionName="西路兵马"
x207011_g_MissionInfo="    我们的西路军绕道凤翔，夺取汉中，包围蔡州，在龙骨坡北与金兵大战，"  --任务描述
x207011_g_MissionInfo2="，请你去支援我们西路军。"
x207011_g_MissionTarget="    #G拖雷#W的西路军在龙骨坡北处和金兵大战，你要解决20名#R女真战士#W，支援西路军。"		                                                                                               
x207011_g_MissionComplete="    我听将士们说了，你的确很英勇。"					--完成任务npc说话的话
x207011_g_ContinueInfo="    金国的将士还是有些本事的，我们需要你的支援。"
--任务奖励
x207011_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x207011_g_ItemBonus={}

--可选物品奖励，最多8种
x207011_g_RadioItemBonus={}

--MisDescEnd
x207011_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x207011_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x207011_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x207011_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)
		if x207011_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x207011_g_MissionName)
			AddText(sceneId,x207011_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x207011_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死女真战士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207011_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x207011_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x207011_g_MissionName)
		     AddText(sceneId,x207011_g_MissionComplete)
		     AddMoneyBonus(sceneId, x207011_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x207011_g_ScriptId, x207011_g_MissionId)
                end

        elseif x207011_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x207011_g_MissionName)
                AddText(sceneId,x207011_g_MissionInfo..GetName(sceneId, selfId)..x207011_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x207011_g_MissionTarget) 
		AddMoneyBonus(sceneId, x207011_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x207011_g_ScriptId, x207011_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x207011_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x207011_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x207011_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x207011_g_ScriptId, x207011_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x207011_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x207011_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x207011_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==7) then
        	    	return 1
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x207011_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x207011_g_MissionId, x207011_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x207011_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x207011_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x207011_g_MissionId)
	for i, item in pairs(x207011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x207011_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x207011_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x207011_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x207011_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x207011_g_MissionId)
		AddExp(sceneId, selfId, x207011_g_ExpBonus)
		AddMoney(sceneId, selfId, x207011_g_MoneyBonus)
		for i, item in pairs(x207011_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x207011_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x207011_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x207011_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x207011_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x207011_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x207011_g_DemandKill[1].id then 
       		    if num < x207011_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死女真战士   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x207011_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x207011_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x207011_OnItemChanged(sceneId, selfId, itemdataId)

end

