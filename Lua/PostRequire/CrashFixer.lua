if RequiredScript == "lib/managers/group_ai_states/groupaistatebase" then
    for k,v in pairs(GroupAIStateBase) do
        if type(v) == "function" then
            GroupAIStateBase[k] = function(...)
                local ret = {pcall(v, ...)}
                if ret[1] == true and #ret > 1 then
                    table.remove(ret, 1)
                    return unpack(ret)
                end
            end
        end
    end
    
elseif RequiredScript == "lib/units/enemies/cop/actions/lower_body/copactionwalk" then
    CopActionWalk.___nav_point_pos = CopActionWalk._nav_point_pos
    CopActionWalk.___send_nav_point = CopActionWalk._send_nav_point
    
    function CopActionWalk._nav_point_pos(...)
        local _,ret = pcall(CopActionWalk.___nav_point_pos, ...)
        return ret
    end
    
    function CopActionWalk:_send_nav_point(...)
        local _,ret = pcall(self.___send_nav_point, self, ...)
        return ret
    end
    
elseif RequiredScript == "lib/units/enemies/spooc/actions/lower_body/actionspooc" then
    ActionSpooc.__upd_chase_path = ActionSpooc._upd_chase_path

    function ActionSpooc:_upd_chase_path(...)
        pcall(self.__upd_chase_path, self, ...)
    end
end  