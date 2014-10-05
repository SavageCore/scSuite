if not UtilFunctions then
    UtilFunctions = true
    
    --[[ ## Panel Functions ## ]]--
    function sizePanel(panel, panelWidth, panelHeight)
        panel:set_w(panelWidth)
        panel:set_h(panelHeight)
    end
    
    function positionPanel(panel, panelX, panelY)
        panel:set_x(panelX)
        panel:set_y(panelY)
    end
    
    --[[ ## Misc Functions ]]--
    function sleep(ms, func, funcData)
        if not ms or not func then
            return
        end
        local thread = addThread({
            sleep = (ms / 1000),
            loopCount = 2,
            afterFunc = func,
            afterData = funcData
        })
        return thread
    end
    
    --[[ Pauses Game like when the InGame Quit to Menu Screen is Open ]]--
    function pauseGame(pause)
        Application:set_pause(pause)
    end
    
    function isGamePaused()
        return Application:paused()
    end
    
    --[[ This Function Checks if Val1 is Nil if it is it Returns Val2 else it Returns Val1 ]]--
    --[[ Basically Use This to get a Default Value if a Parameter hasn't been Assigned a Value ]]--
    --[[ Because self.value = val1 or val2 Doesn't seem to Work ]]--
    function getValue(val1, val2)
        if val1 == nil then
            return val2
        end
        return val1
    end
    
    --[[ Round a Number Up to the Nearest Whole Number ]]--
    function roundUp(val)
        return math.ceil(val)
    end
    
    --[[ ## Artificial Threading System ## ]]--
    --[[ Hook GameStateMachine Update Functions to Call our 'Threads' ]]--
    if not GameStateMachine then return end
    function GameStateMachine:update(t, dt)
        if self._current_state.update then
            self._current_state:update(t, dt)
        end
        runThreads()
    end
    
    _threads = { }
    
    --[[ Loop Through All the Threads and Execute their Functions ]]--
    function runThreads()
        for n in pairs(_threads) do
            if Application:time() > (_threads[n].prevRunTime + _threads[n].sleep) then
                if _threads[n].func then
                    if not _threads[n].data then
                        _threads[n].func()
                    else
                        _threads[n].func(_threads[n].data)
                    end
                end
                _threads[n].prevRunTime = Application:time()
                _threads[n].loopCount = _threads[n].loopCount - 1
            end
            if _threads[n].loopCount == 0 then
                if _threads[n].afterFunc then
                    if not _threads[n].afterData then
                        _threads[n].afterFunc()
                    else
                        _threads[n].afterFunc(_threads[n].afterData)
                    end
                end
                _threads[n] = nil
            end
        end
    end
    
    --[[ Add a New Thread using Provided Parameters, Generate Random Name if None Provided ]]--
    function addThread(params)
        if not params then
            return
        end
        local name = params.name or tostring(math.random(0,0xFFFFFFFF))
        _threads[name] = {
            func = params.func or nil,
            data = params.data or nil,
            afterFunc = params.afterFunc or nil,
            afterData = params.afterData or nil,
            sleep = params.sleep or 0,
            loopCount = params.loopCount or -1,
            prevRunTime = (Application:time() - (params.sleep or 0))
        }
        return name
    end
    
    --[[ Stop Thread using The Name Provided ]]--
    function stopThread(name)
        if _threads[name] then
            _threads[name] = nil
            return true
        end
        return false
    end
    
    --[[ Stop All Threads ]]--
    function stopAllThreads()
        _threads = { }
    end
end