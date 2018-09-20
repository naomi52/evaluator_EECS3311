note
	description: "Summary description for {LPAREN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LPAREN
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := "("
	end

end
