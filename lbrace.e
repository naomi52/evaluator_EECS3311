note
	description: "Summary description for {LBRACE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LBRACE
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := "{"
	end

end
