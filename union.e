note
	description: "Summary description for {UNION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNION
inherit
	TERMINALS

feature -- Query
	output: STRING
	do
		Result := " \/ "
	end
end
