note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_CONJOIN
inherit
	ETF_CONJOIN_INTERFACE
		redefine conjoin end
create
	make
feature -- command
	conjoin
    	do
			if model.my_stack.is_empty and not model.is_new then
				model.set_error_message (model.status_completed_exp)
			else
				model.add_conjunction
				model.pretty_print
			end
		--	model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
