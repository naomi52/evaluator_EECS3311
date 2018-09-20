note
	description: "Summary description for {PLUS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLUS
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := " + "
	end
end
