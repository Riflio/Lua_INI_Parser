--[[
	Copyright (c) 2012 Carreras Nicolas
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
--]]
--- Lua INI Parser.
-- It has never been that simple to use INI files with Lua.
--@author Dynodzzo
--@author Riflio

local LIP = {};

--- Returns a table containing all the data from the INI format string.
--@param iniStr The string in INI format to parse. [string]
--@return The table containing all data from the INI data string. [table]
function LIP.parse(iniStr)
	assert(type(iniStr)=='string', 'Parameter "iniStr" must be a string.')
	local data = {};
	local section;
	for line in string.gmatch(iniStr,"[^\r\n]+") do
		local tempSection =line:match('^%s-%[([^%[%]]+)%]$')
		if ( tempSection ) then
			section =tonumber(tempSection) and tonumber(tempSection) or tempSection
			data[section] =data[section] or {}
		end
		local param, value =line:match('^%s-([%w|_]+)%s-=%s-(.+)$')
		if ( param and value~=nil ) then
			if ( tonumber(value) ) then
				value =tonumber(value)
			elseif ( value=='true' ) then
				value =true
			elseif ( value=='false' ) then
				value =false
			end
			if ( tonumber(param) ) then
				param =tonumber(param)
			end
			data[section][param] =value
		end
	end
	return data
end

--- Return all the data from a table to an INI formated string.
--@param data The table containing all the data to store. [table]
--@return INI format string.
function LIP.dump(data)
	assert(type(data) == 'table', 'Parameter "data" must be a table.')
	local contents =''
	for section, param in pairs(data) do
		contents =contents..('[%s]\n'):format(section)
		for key, value in pairs(param) do
			contents =contents..('%s=%s\n'):format(key, tostring(value))
		end
		contents =contents..'\n'
	end
	return contents
end

return LIP