note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_THERE_EXISTS
inherit
	ETF_THERE_EXISTS_INTERFACE
		redefine there_exists end
create
	make
feature -- command
	there_exists
    	do
			if model.my_stack.is_empty and not model.is_new then
				model.set_error_message (model.status_completed_exp)
			else
				model.add_generalized_or
				model.pretty_print
			end
			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
