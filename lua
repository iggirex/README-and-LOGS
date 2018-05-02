-----------------------------------------------------------------------------------------------
------------------------------------          Lua          ------------------------------------ 
-----------------------------------------------------------------------------------------------

--------------
Types
--------------
JavaScript type	    Lua type	Example Lua values
boolean	            boolean	    true or false
null or undefined	nil	        nil
number	            number	    3.141
string	            string	    'hi' or "there"
object or array	    table	    {a = 1, [2] = false}
function	        function	function () return 42 end

A table can work as either a hash table or an array. 
JavaScript object keys must be strings; Lua table keys can be any non-nil value

The two remaining types in Lua are userdata and thread. 
A userdata, intuitively, is an object that’s been implemented in C using Lua’s C API. 
A userdata typically acts like a table with private data, although its behavior can be customized 
    to appear non-private. 
A Lua thread is a coroutine, allowing a function to yield values while preserving its own 
    stack and internal state.


------------------------------------------
Comments, whitespace, and semicolons
------------------------------------------
Multiline comments in Lua begin with the token --[[ and end with the token ]]. 

    --[[ And this is a
        multiline comment! ]]

Indentation is ignored by Lua. 
Whitespace characters are also ignored
End-of-line semicolons in Lua are optional and are typically excluded.


------------------------------------------
Scope
------------------------------------------

Lua variables are global by default. Lua’s local keyword is a bit like JavaScript’s var keyword, 
except that Lua scopes aren’t hoisted. 
In other words, you can think of Lua’s local keyword as similar to ES6’s let keyword, 
which makes a variable visible within the current code block:

-- Lua
phi         = 1.618034  -- `phi` has global scope.
local gamma = 0.577216  -- `gamma` has local scope in the current block.


------------------------------------------
Ternary operator equivalent in Lua
------------------------------------------

-- Lua’s ternary-operator-like idiom.
local x = myBoolean and valueOnTrue or valueOnFalse

-- An example: find the max of the numbers a and b.
local maxNum = (a > b) and a or b

-- This is similar to the Javascript:
-- var maxNum = (a > b) ? a : b;


------------------------------------------
Control Flow
------------------------------------------


JavaScript	                            Lua
while (condition) { … }	                while condition do … end
do { … } while (condition)	            repeat … until condition
for (var i =start; i <=end; i++) { … }	for i =start, end do … end
for (key in object) { … }	            for key, value = pairs(object) do … end
for (value of object) { … } (ES6)	    for key, value = pairs(object) do … end
if (condition) {…} [else {…}]	        if condition1 do … [elseif conditition2 then …] [else …] end


FOR LOOP IN LUA

    local i = startValue()    -- Initialize.
    while myCondition(i) do   -- Check a loop condition.
    doLoopBody()
    i = step(i)             -- Update any loop variables.
    end

