note
	description: "Summary description for {RPAREN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RPAREN
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := ")"
	end

end
