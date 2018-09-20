note
	description: "Summary description for {DIVIDES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIVIDES
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := " / "
	end
end
