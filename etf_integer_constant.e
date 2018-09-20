note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_INTEGER_CONSTANT
inherit
	ETF_INTEGER_CONSTANT_INTERFACE
		redefine integer_constant end
create
	make
feature -- command
	integer_constant(c: INTEGER_64)
    	do
			if model.my_stack.is_empty and not model.is_new then
				model.set_error_message (model.status_completed_exp)
			else
				model.add_integer_constant (c)
				model.pretty_print
			end
			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
