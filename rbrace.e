note
	description: "Summary description for {RBRACE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RBRACE
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := "}"
	end

end
