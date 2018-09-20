note
	description: "Summary description for {NEGATIVE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEGATIVE
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := "- "
	end

end
