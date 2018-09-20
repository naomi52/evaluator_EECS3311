note
	description: "Summary description for {COMMA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMA
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := ", "
	end
end
