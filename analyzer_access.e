note
	description: "Summary description for {ANALYZER_ACCESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	ANALYZER_ACCESS
feature
	m: ANALYZER
		once
			create Result.make
		end
invariant
	m = m
end
