--[[
*****************************************************************************************
*
*        		===============================================
*           		Nirikshak Bot (NB) Theme (eYRC 2020-21)
*        		===============================================
*
*  This Lua script is to implement Task 2B of Nirikshak Bot (NB) Theme (eYRC 2020-21).
*
*  This software is made available on an "AS IS WHERE IS BASIS".
*  Licensee/end user indemnifies and will keep e-Yantra indemnified from
*  any and all claim(s) that emanate from the use of the Software or
*  breach of the terms of this agreement.
*
*  e-Yantra - An MHRD project under National Mission on Education using ICT (NMEICT)
*
*****************************************************************************************
]]--


--[[
# Team ID:			[ Team-ID ]
# Author List:		[ Names of team members worked on this file separated by Comma: Name1, Name2, ... ]
# Filename:			task_2b
# Functions:        createWall, saveTexture, retrieveTexture, reapplyTexture, receiveData, generateHorizontalWalls,
#                   generateVerticalWalls, deleteWalls, createMaze, sysCall_init, sysCall_beforeSimulation
#                   sysCall_afterSimulation, sysCall_cleanup
# 					[ Comma separated list of functions in this file ]
# Global variables:
# 					[ List of global variables defined in this file ]
]]--

--[[
##################### GLOBAL VARIABLES #######################
## You can add global variables in this section according   ##
## to your requirement.                                     ##
## DO NOT TAMPER WITH THE ALREADY DEFINED GLOBAL VARIABLES. ##
##############################################################
]]--

maze_array = {}
baseHandle = -1       --Do not change or delete this variable
textureID = -1        --Do not change or delete this variable
textureData = -1       --Do not change or delete this variable
--############################################################

--[[
##################### HELPER FUNCTIONS #######################
## You can add helper functions in this section according   ##
## to your requirement.                                     ##
## DO NOT MODIFY OR CHANGE THE ALREADY DEFINED HELPER       ##
## FUNCTIONS                                                ##
##############################################################
]]--

--[[
**************************************************************
	Function Name : createWall()
    Purpose:
	---
	Creates a black-colored wall of dimensions 90cm x 10cm x 10cm

	Input Arguments:
	---
	None

	Returns:
	---
	wallObjectHandle : number

    returns the object handle of the created wall

	Example call:
	---
	wallObjectHandle = createWall()
**************************************************************
]]--
function createWall()
    wallObjectHandle = sim.createPureShape(0, 26, {0.09, 0.01, 0.1}, 0, nil)
    sim.setShapeColor(wallObjectHandle, nil, sim.colorcomponent_ambient_diffuse, {0, 0, 0})
    sim.setObjectSpecialProperty(wallObjectHandle, sim.objectspecialproperty_collidable)
    sim.setObjectSpecialProperty(wallObjectHandle, sim.objectspecialproperty_measurable)
    sim.setObjectSpecialProperty(wallObjectHandle, sim.objectspecialproperty_detectable_all)
    sim.setObjectSpecialProperty(wallObjectHandle, sim.objectspecialproperty_renderable)
    return wallObjectHandle
end

--[[
**************************************************************
  YOU ARE NOT ALLOWED TO MODIFY OR CALL THIS HELPER FUNCTION
**************************************************************
	Function Name : saveTexture()
    Purpose:
	---
	Reads and initializes the applied texture to Base object
    and saves it to a file.

	Input Arguments:
	---
	None

	Returns:
	---
	None

	Example call:
	---
	saveTexture()
**************************************************************
]]--
function saveTexture()
    baseHandle = sim.getObjectHandle("Base")
    textureID = sim.getShapeTextureId(baseHandle)
    textureData=sim.readTexture(textureID ,0,0,0,0,0)
    sim.saveImage(textureData, {512,512}, 0, "models/other/base_template.png", -1)
end
--[[
**************************************************************
  YOU ARE NOT ALLOWED TO MODIFY OR CALL THIS HELPER FUNCTION
**************************************************************
	Function Name : retrieveTexture()
    Purpose:
	---
	Loads texture from file.

	Input Arguments:
	---
	None

	Returns:
	---
	None

	Example call:
	---
	retrieveTexture()
**************************************************************
]]--
function retrieveTexture()
    textureData, resolution = sim.loadImage(0, "models/other/base_template.png")
end

--[[
**************************************************************
  YOU ARE NOT ALLOWED TO MODIFY OR CALL THIS HELPER FUNCTION
**************************************************************
	Function Name : reapplyTexture()
    Purpose:
	---
	Re-applies texture to Base object

	Input Arguments:
	---
	None

	Returns:
	---
	None

	Example call:
	---
    reapplyTexture()
**************************************************************
]]--
function reapplyTexture()
    plane, textureID = sim.createTexture("", 0, nil, {1.01, 1.01}, nil, 0, {512, 512})
    sim.writeTexture(textureID, 0, textureData, 0, 0, 0, 0, 0)
    sim.setShapeTexture(baseHandle, textureID, sim.texturemap_plane, 0, {1.01, 1.01},nil,nil)
    sim.removeObject(plane)
end

--############################################################

--[[
**************************************************************
	Function Name : receiveData()
    Purpose:
	---
	Receives data via Remote API. This function is called by
    simx.callScriptFunction() in the python code (task_2b.py)

	Input Arguments:
	---
	inInts : Table of Ints
    inFloats : Table of Floats
    inStrings : Table of Strings
    inBuffer : string

	Returns:
	---
	inInts : Table of Ints
    inFloats : Table of Floats
    inStrings : Table of Strings
    inBuffer : string

    These 4 variables represent the data being passed from remote
    API client(python) to the CoppeliaSim scene

	Example call:
	---
	N/A

    Hint:
    ---
    You might want to study this link to understand simx.callScriptFunction()
    better
    https://www.coppeliarobotics.com/helpFiles/en/remoteApiExtension.htm
**************************************************************
]]--
function receiveData(inInts,inFloats,inStrings,inBuffer)

    --*******************************************************
    --               ADD YOUR CODE HERE

    maze_array = inInts





    --*******************************************************
    return inInts, inFloats, inStrings, inBuffer
end

--[[
**************************************************************
	Function Name : generateHorizontalWalls()
    Purpose:
	---
	Generates all the Horizontal Walls in the scene.

	Input Arguments:
	---
	None

	Returns:
	---
    None

	Example call:
	---
	generateHorizontalWalls()
**************************************************************
]]--
function generateHorizontalWalls()

    --*******************************************************
    --               ADD YOUR CODE HERE

    for i = 1 , 10 do
        for j = 1 , 11 do
            wall = createWall()
            sim.setObjectParent(wall,sim.getObjectHandle('Base'),false)
            sim.setObjectName(wall,'H'..tostring(j)..tostring(i))
            sim.setObjectPosition(wall,-1,{(-0.45+(i-1)*0.1), (0.5+(j-1)*-0.1),0.08})
        end
    end





    --*******************************************************
end

--[[
**************************************************************
	Function Name : generateVerticalWalls()
    Purpose:
	---
	Generates all the Vertical Walls in the scene.

	Input Arguments:
	---
	None

	Returns:
	---
    None

	Example call:
	---
	generateVerticalWalls()
**************************************************************
]]--
function generateVerticalWalls()

    --*******************************************************
    --               ADD YOUR CODE HERE

    for i = 1 , 10 do
        for j = 1 , 11 do
            wall = createWall()
            sim.setObjectOrientation(wall,-1,{0,0,(3.14/2)})
            sim.setObjectParent(wall,sim.getObjectHandle('Base'),false)
            sim.setObjectName(wall,'V'..tostring(j)..tostring(i))
            sim.setObjectPosition(wall,-1,{(-0.5+(j-1)*0.1), (0.45+(i-1)*-0.1),0.08})
        end
    end






    --*******************************************************
end

--[[
**************************************************************
	Function Name : deleteWalls()
    Purpose:
	---
	Deletes all the walls in the given scene

	Input Arguments:
	---
	None

	Returns:
	---
    None

	Example call:
	---
	deleteWalls()
**************************************************************
]]--
function deleteWalls()

    --*******************************************************
    --               ADD YOUR CODE HERE

    for i = 1 , 11 do
        for j = 1, 10 do
            Hwall = sim.getObjectHandle('H'..tostring(i)..tostring(j))
            sim.removeObject(Hwall)
            Vwall = sim.getObjectHandle('V'..tostring(i)..tostring(j))
            sim.removeObject(Vwall)
        end
    end






    --*******************************************************
end


--[[
**************************************************************
  YOU CAN DEFINE YOUR OWN INPUT AND OUTPUT PARAMETERS FOR THIS
                          FUNCTION
**************************************************************
	Function Name : createMaze()
    Purpose:
	---
	Creates the maze in the given scene by deleting specific
    horizontal and vertical walls

	Input Arguments:
	---
	None

	Returns:
	---
    None

	Example call:
	---
	createMaze()
**************************************************************
]]--
function createMaze()

    --*******************************************************
    --               ADD YOUR CODE HERE

     j = 0
    i = 1
    for index = 1 , 100 do
        j= j + 1

    cellvalue = maze_array[index]
    cellBinaryValue = ''
    if cellvalue <= 15 then
        for p = 1 , 4 do
        if cellvalue / (2^(4-p)) >= 1 then
            cellvalue = cellvalue - 2^(4-p)
            cellBinaryValue = cellBinaryValue..'1'
        else
            cellBinaryValue = cellBinaryValue..'0'
        end
        end

        S = string.byte(cellBinaryValue,1)
        E = string.byte(cellBinaryValue,2)
        --N = string.byte(cellBinaryValue,3)
        --W = string.byte(cellBinaryValue,4)

        if E == 48 and j ~= 10 then
            E_Wall = sim.getObjectHandle('V'..tostring(j+1)..tostring(i))
            sim.removeObject(E_Wall)
        end

        if S == 48 and j ~= 10 and i ~= 10  then
            S_Wall = sim.getObjectHandle('H'..tostring(i+1)..tostring(j))
            sim.removeObject(S_Wall)
        end
        if j >= 10 then
            i = i + 1
            j = 0
        end

    end
    end






    --*******************************************************
end



--[[
**************************************************************
	Function Name : sysCall_init()
    Purpose:
	---
	Can be used for initialization of parameters

	Input Arguments:
	---
	None

	Returns:
	---
    None

	Example call:
	---
	N/A
**************************************************************
]]--
function sysCall_init()

    if pcall(saveTexture) then -- Do not delete or modify this section
        print("Successfully saved texture")
    else
        print("Texture does not exist. Importing texture from file..")
        retrieveTexture()
        reapplyTexture()
    end
end

--[[
**************************************************************
        YOU ARE NOT ALLOWED TO MODIFY THIS FUNCTION.
**************************************************************
	Function Name : sysCall_beforeSimulation()
    Purpose:
	---
	This is executed before simulation starts

	Input Arguments:
	---
	None

	Returns:
	---
    None

	Example call:
	---
	N/A
**************************************************************
]]--
function sysCall_beforeSimulation()

    sim.setShapeTexture(baseHandle, -1, sim.texturemap_plane, 0, {1.01, 1.01},nil,nil) -- Do not delete or modify this line

    generateHorizontalWalls()
    generateVerticalWalls()
    createMaze()
end

--[[
**************************************************************
        YOU ARE NOT ALLOWED TO MODIFY THIS FUNCTION.
**************************************************************
	Function Name : sysCall_afterSimulation()
    Purpose:
	---
	This is executed after simulation ends

	Input Arguments:
	---
	None

	Returns:
	---
    None

	Example call:
	---
	N/A
**************************************************************
]]--
function sysCall_afterSimulation()
    -- is executed after a simulation ends
    deleteWalls()
    reapplyTexture() -- Do not delete or modify this line
end

function sysCall_cleanup()
    -- do some clean-up here
end

-- See the user manual or the available code snippets for additional callback functions and details




