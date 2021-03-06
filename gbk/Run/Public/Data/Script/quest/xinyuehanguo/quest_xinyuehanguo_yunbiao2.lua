--功能：二级运镖
--NPC：新月汗国 哈尼斯


x211010_g_ScriptId = 211010
x211010_g_MissionName="二级运镖"

--**********************************

--任务入口函数

--**********************************

function x211010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本
	BeginEvent(sceneId)
		AddText(sceneId, "#Y二级运镖")
		AddText(sceneId, "哈马斯大人是我信仰的主，在他的庇佑下，我才能在这道上混口饭吃。我和我二弟哈底斯现在是哈马斯大人的左臂右膀，你有什么事先找我俩，哈马斯大人很忙，不随便见外人的，知道了吗？")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end



--**********************************

--列举事件

--**********************************

function x211010_OnEnumerate(sceneId, selfId, targetId)
		AddNumText(sceneId, x211010_g_ScriptId, x211010_g_MissionName)
end



--**********************************

--检测接受条件

--**********************************

function x211010_CheckAccept(sceneId, selfId, targetId)

end

--**********************************

--接受

--**********************************

function x211010_OnAccept(sceneId, selfId)
                                                                   
	     
end



--**********************************

--放弃

--**********************************

function x211010_OnAbandon(sceneId, selfId)

end



--**********************************

--检测是否可以提交

--**********************************

function x211010_CheckSubmit( sceneId, selfId, targetId)

end



--**********************************

--提交

--**********************************

function x211010_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x211010_OnKillObject(sceneId, selfId, objdataId)

end



--**********************************

--进入区域事件

--**********************************

function x211010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x211010_OnItemChanged(sceneId, selfId, itemdataId)

end