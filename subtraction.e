note
	description: "Summary description for {MINUS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUBTRACTION
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := " - "
	end

end
