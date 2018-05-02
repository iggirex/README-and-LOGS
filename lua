----
Lua
----

Types
-----
JavaScript type	    Lua type	Example Lua values
boolean	            boolean	    true or false
null or undefined	nil	        nil
number	            number	    3.141
string	            string	    'hi' or "there"
object or array	    table	    {a = 1, [2] = false}
function	        function	function () return 42 end


Comments, whitespace, and semicolons
------------------------------------
Multiline comments in Lua begin with the token --[[ and end with the token ]]. 

    --[[ And this is a
        multiline comment! ]]

Indentation is ignored by Lua. 
Whitespace characters are also ignored
End-of-line semicolons in Lua are optional and are typically excluded.

