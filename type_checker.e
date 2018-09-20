
note
	description: "Summary description for {VISIT_TYPE_CHECK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CHECKER

inherit
	VISITOR
create make

feature -- Constructor
	make
	do
		create value.make_empty
		create set_enum_list.make (0)
		type_check := false
		is_divisor_zero := false
	end
feature
	type_check : BOOLEAN
	is_divisor_zero : BOOLEAN
	set_enum_list : ARRAYED_LIST[STRING]
	type_integer :INTEGER  = 1
	type_boolean : INTEGER = 2
	type_mixed : INTEGER = 0
	type_set_enum : BOOLEAN
	type_set : INTEGER = 3
	type_flag : INTEGER

feature -- Give the evaluated expression
    visit_boolean_constant(e: BOOLEAN_CONSTANT)
	do
		--value := e.output
		value.make_empty
		value.append (e.output)
		type_flag := type_boolean
		type_check := true
		type_set_enum := false
	end

	visit_integer_constant(e: INTEGER_CONSTANT)
	do
		--value := e.output
		value.make_empty
		value.append (e.output)
		type_flag := type_integer
		type_check := true
		type_set_enum := false
	end

	visit_addition(e: BINARY_OPERATION)
	local
		left_visit_type_check : TYPE_CHECKER
		right_visit_type_check : TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)

		if (left_visit_type_check.type_flag = type_integer) and (right_visit_type_check.type_flag = type_integer)
			and (not left_visit_type_check.type_set_enum) and (not right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			is_divisor_zero := left_visit_type_check.is_divisor_zero or
			right_visit_type_check.is_divisor_zero
			type_check := true
			type_flag := type_integer
		end

	end

	visit_division(e: BINARY_OPERATION)
	local
		left_visit_type_check : TYPE_CHECKER
		right_visit_type_check : TYPE_CHECKER
		divisor_check : EVALUATOR
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		create divisor_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		e.right.accept (divisor_check)
		if (left_visit_type_check.type_flag = type_integer) and (right_visit_type_check.type_flag = type_integer)
			and (not left_visit_type_check.type_set_enum) and (not right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			is_divisor_zero := left_visit_type_check.is_divisor_zero or
			right_visit_type_check.is_divisor_zero
			if divisor_check.value.to_integer = 0 then
				is_divisor_zero := true
			end
			type_check := true
			type_flag := type_integer
		end
	end

	visit_conjunction(e: BINARY_OPERATION)
	local
		left_visit_type_check: TYPE_CHECKER
		right_visit_type_check: TYPE_CHECKER

	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if (left_visit_type_check.type_flag = type_boolean) and (right_visit_type_check.type_flag = type_boolean)
			and (not left_visit_type_check.type_set_enum) and (not right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			is_divisor_zero := left_visit_type_check.is_divisor_zero or
			right_visit_type_check.is_divisor_zero
			type_check := true
			type_flag := type_boolean
		end

	end

	visit_difference(e: BINARY_OPERATION)
	local
		left_visit_type_check: TYPE_CHECKER
		right_visit_type_check: TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if (left_visit_type_check.type_flag = right_visit_type_check.type_flag)
			and (left_visit_type_check.type_set_enum and right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			is_divisor_zero := left_visit_type_check.is_divisor_zero or
			right_visit_type_check.is_divisor_zero
			type_check := true
			type_flag := left_visit_type_check.type_flag
			type_set_enum := true
		end
	end


	visit_disjunction(e: BINARY_OPERATION)
	local
		left_visit_type_check : TYPE_CHECKER
		right_visit_type_check : TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if (left_visit_type_check.type_flag = type_boolean) and (right_visit_type_check.type_flag = type_boolean)
			and (not left_visit_type_check.type_set_enum) and (not right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			is_divisor_zero := left_visit_type_check.is_divisor_zero or
			right_visit_type_check.is_divisor_zero
			type_check := true
			type_flag := type_boolean
		end
	end



	visit_equality(e: BINARY_OPERATION)
	local
		left_visit_type_check: TYPE_CHECKER
		right_visit_type_check: TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if (left_visit_type_check.type_flag = right_visit_type_check.type_flag)
		 and (left_visit_type_check.type_set_enum = right_visit_type_check.type_set_enum)
		 and left_visit_type_check.type_check and right_visit_type_check.type_check then
			type_check := true
			type_flag := type_boolean
		end
	end

	visit_generalized_and(e: UNARY_OPERATION)
	local
		visit_type_check : TYPE_CHECKER
	do
		create visit_type_check.make
		e.child.accept (visit_type_check)
		if (visit_type_check.type_flag = type_boolean) and visit_type_check.type_set_enum
		and visit_type_check.type_check then
			type_flag := type_boolean
			type_check := true
		end

	end

	visit_generalized_or(e: UNARY_OPERATION)
	local
		visit_type_check : TYPE_CHECKER
	do
		create visit_type_check.make
		e.child.accept (visit_type_check)
		if (visit_type_check.type_flag = type_boolean) and visit_type_check.type_set_enum
		and visit_type_check.type_check then
			type_flag := type_boolean
			type_check := true
		end

	end

	visit_greater_than(e: BINARY_OPERATION)
	local
		left_visit_type_check : TYPE_CHECKER
		right_visit_type_check : TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if (left_visit_type_check.type_flag = type_integer) and (right_visit_type_check.type_flag = type_integer)
			and (not left_visit_type_check.type_set_enum) and (not right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			is_divisor_zero := left_visit_type_check.is_divisor_zero or
			right_visit_type_check.is_divisor_zero
			type_check := true
			type_flag := type_boolean
		end
	end

	visit_implication(e: BINARY_OPERATION)
	local
		left_visit_type_check : TYPE_CHECKER
		right_visit_type_check : TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if (left_visit_type_check.type_flag = type_boolean) and (right_visit_type_check.type_flag = type_boolean)
			and (not left_visit_type_check.type_set_enum) and (not right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			is_divisor_zero := left_visit_type_check.is_divisor_zero or
			right_visit_type_check.is_divisor_zero
			type_check := true
			type_flag := type_boolean
		end
	end

	visit_intersection(e: BINARY_OPERATION)
	local
		left_visit_type_check : TYPE_CHECKER
		right_visit_type_check : TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if left_visit_type_check.type_flag = right_visit_type_check.type_flag
			and ( left_visit_type_check.type_set_enum) and (right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			type_flag :=left_visit_type_check.type_flag
			type_check := true
			type_set_enum := true
		else
			type_flag := type_mixed
		end

	end

	visit_less_than(e: BINARY_OPERATION)
	local
		left_visit_type_check : TYPE_CHECKER
		right_visit_type_check : TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if (left_visit_type_check.type_flag = type_integer) and (right_visit_type_check.type_flag = type_integer)
			and (not left_visit_type_check.type_set_enum) and (not right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			is_divisor_zero := left_visit_type_check.is_divisor_zero or
			right_visit_type_check.is_divisor_zero
			type_check := true
			type_flag := type_boolean
		end
	end

	visit_multiplication(e: BINARY_OPERATION)
	local
		left_visit_type_check : TYPE_CHECKER
		right_visit_type_check : TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if (left_visit_type_check.type_flag = type_integer) and (right_visit_type_check.type_flag = type_integer)
			and (not left_visit_type_check.type_set_enum) and (not right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			is_divisor_zero := left_visit_type_check.is_divisor_zero or
			right_visit_type_check.is_divisor_zero
			type_check := true
			type_flag := type_integer
		end
	end

	visit_negation(e: UNARY_OPERATION)
	local
		visit_type_check : TYPE_CHECKER
	do
		create visit_type_check.make
		e.child.accept (visit_type_check)
		if (visit_type_check.type_flag = type_boolean)
		and visit_type_check.type_check and not visit_type_check.type_set_enum then
			type_check := true
			type_flag := type_boolean
		end
	end

	visit_negative(e: UNARY_OPERATION)
	local
		visit_type_check : TYPE_CHECKER
	do
		create visit_type_check.make
		e.child.accept (visit_type_check)

		if (visit_type_check.type_flag = type_integer)
		and visit_type_check.type_check and not visit_type_check.type_set_enum then
			type_check := true
			type_flag := type_integer
		end
	end

	visit_subtraction(e: BINARY_OPERATION)
	local
		left_visit_type_check : TYPE_CHECKER
		right_visit_type_check : TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if (left_visit_type_check.type_flag = type_integer) and (right_visit_type_check.type_flag = type_integer)
			and (not left_visit_type_check.type_set_enum) and (not right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			is_divisor_zero := left_visit_type_check.is_divisor_zero or
			right_visit_type_check.is_divisor_zero
			type_check := true
			type_flag := type_integer
		end
	end

	visit_sum(e: UNARY_OPERATION)
	local
		visit_type_check : TYPE_CHECKER
	do
		create visit_type_check.make
		e.child.accept (visit_type_check)
		if (visit_type_check.type_flag = type_integer) and (visit_type_check.type_set_enum)
		and visit_type_check.type_check then
			type_check := true
			type_flag := type_integer
		end
	end

	visit_union(e: BINARY_OPERATION) -- N
	local
		left_visit_type_check : TYPE_CHECKER
		right_visit_type_check : TYPE_CHECKER
	do
		create left_visit_type_check.make
		create right_visit_type_check.make
		e.left.accept (left_visit_type_check)
		e.right.accept (right_visit_type_check)
		if left_visit_type_check.type_flag = right_visit_type_check.type_flag and (left_visit_type_check.type_set_enum)
			and (right_visit_type_check.type_set_enum)
			and left_visit_type_check.type_check and right_visit_type_check.type_check then
			type_flag := left_visit_type_check.type_flag
			type_check := true
			type_set_enum := true
		else
			type_flag := type_mixed
			type_check := false
		end

	end


	visit_set_enumeration (e : SET_ENUMERATION)
	local
		eval : TYPE_CHECKER
		exit_bool : BOOLEAN
	do
		create eval.make
		from
			e.start
			e.item.accept(eval)
		    if eval.type_set_enum then
				type_flag := type_set
		    elseif eval.type_flag = type_integer and not eval.type_set_enum then
		    	type_flag := type_integer
		    elseif eval.type_flag = type_boolean and not eval.type_set_enum then
		    	type_flag := type_boolean
		    end

		until
			e.after or exit_bool
		loop
			-- if the first one is boolean, check to see if all the other ones are boolean
			e.item.accept(eval)
		    if type_flag = type_set then
		    	if not eval.type_set_enum then
		    		type_check:= false
		    		exit_bool := true
		    	else
		    		type_check := true
		    	end
		    elseif type_flag = type_integer then
		    	if eval.type_set_enum or (eval.type_flag = type_boolean) then
		    		type_check := false
		    		exit_bool := true
		    	else
		    		type_check := true
		    	end
		    elseif type_flag = type_boolean then
		    	if eval.type_set_enum or (eval.type_flag = type_integer) then
		    		type_check := false
		    		exit_bool := true
		    	else
		    		type_check := true
		    	end
		    end


			e.forth


		end
		type_set_enum := true
	end

	visit_null_expression (e  : NULL_EXPRESSION)
	do
	end

end
