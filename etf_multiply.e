note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MULTIPLY
inherit
	ETF_MULTIPLY_INTERFACE
		redefine multiply end
create
	make
feature -- command
	multiply
    	do
			if model.my_stack.is_empty and not model.is_new then
				model.set_error_message (model.status_completed_exp)
			else
				model.add_multiplication
				model.pretty_print
			end
			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
