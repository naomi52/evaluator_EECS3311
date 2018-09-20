note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_RESET
inherit
	ETF_RESET_INTERFACE
		redefine reset end
create
	make
feature -- command
	reset
    	do
			if model.is_new then
				model.set_error_message (model.status_expression_cannot_be_reset)
			else
				model.reset
				model.set_error_message (model.status_ok)
			end
			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
