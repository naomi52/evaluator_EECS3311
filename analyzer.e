
note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ANALYZER

inherit
	ANY
		redefine
			out
		end

create {ANALYZER_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			--Strings, message specifies the current state.
			create report.make_empty
			create error_message.make_empty

			create {NULL_EXPRESSION}myexpression.make_first
			create integer_constant.make
			create binary_op.make
			create boolean_constant
			create unary_operation.make
			create set_enumerator.make
			create evaluate_visitor.make
			create print_visitor.make
			create type_check_visitor.make
			create my_stack.make(0)
			is_new := true
			set_error_message (status_initialized)

		end

feature -- Attributes
	report : STRING
	error_message :STRING
	evaluate_visitor : EVALUATOR
	print_visitor : PRETTY_PRINT
	type_check_visitor : TYPE_CHECKER
	is_new : BOOLEAN
	my_stack : ARRAYED_LIST [INTEGER]
	-- used to ensure user does not try to close a currently open set which is empty
	is_new_set : BOOLEAN
	set_enum_count : INTEGER
	is_divisor_zero : BOOLEAN

feature{NONE} -- Internal Attributes
	myexpression : EXPRESSION
	binary_op : BINARY_OPERATION
	integer_constant : INTEGER_CONSTANT
	boolean_constant : BOOLEAN_CONSTANT
	unary_operation : UNARY_OPERATION
	set_enumerator : SET_ENUMERATION
	first_set : BOOLEAN



feature -- Error reporting using strings
	status_ok : STRING
		attribute Result := "OK." end
	status_initialized: STRING
		attribute Result := "Expression is initialized." end
	status_incomplete_exp: STRING
		attribute Result := "Error (Expression is not yet fully specified)." end
	status_completed_exp: STRING
		attribute Result := "Error (Expression is already fully specified)." end
	status_divisor_zero: STRING
	    attribute Result := "Error (Divisor is zero)." end
	status_expression_cannot_be_reset : STRING
		attribute Result := "Error (Initial expression cannot be reset)." end
	status_enumeration_not_being_specified : STRING
		attribute Result := "Error (Set enumeration is not being specified)." end
	status_enum_must_not_be_empty :STRING
		attribute Result := "Error: (Set enumeration must be non-empty)." end
	status_not_type_correct_evaluate : STRING
		attribute Result := "Error (Expression is not type-correct)." end
	status_is_type_correct : STRING
		attribute Result := " is type-correct." end
	status_is_not_type_correct : STRING
		attribute Result := " is not type-correct." end
feature -- Set operations
	set_error_message (e : STRING)
	do
		error_message.make_empty
		error_message.append (e)
	end

	is_type_correct : BOOLEAN
	do
		myexpression.accept (type_check_visitor)
		Result := type_check_visitor.type_check
	end

feature -- main operations
	evaluate
	require
		no_expression_in_stack and is_type_correct and not is_divisor_zero
	do

		report.make_empty
		myexpression.accept(evaluate_visitor)
		error_message.make_empty
	    report.append (print_visitor.value)
	    error_message.append (evaluate_visitor.value)

	end

	pretty_print
	do
		report.make_empty
		myexpression.accept(print_visitor)
		report.append (print_visitor.value)
	end

	type_check
	require
		no_expression_in_stack
	do
		myexpression.accept(type_check_visitor)
		report.make_empty
		report.append (print_visitor.value)

		error_message.make_empty
		error_message.append (print_visitor.value)
		error_message.append (status_is_type_correct)
		is_divisor_zero := type_check_visitor.is_divisor_zero
	end

feature -- Binary operations commands

	add_addition
	do
		add_binary_operation(create {PLUS})
	end

	add_subtraction
	do
		add_binary_operation(create {SUBTRACTION})
	end
	add_multiplication
		-- add binary operation 'multiplication'
	do
		add_binary_operation(create {MULTIPLICATION})
	end

	add_division
		-- add binary operation 'division'
	do
		add_binary_operation(create {DIVIDES})

	end

    -- binary logical operations

    add_conjunction
    do
    	add_binary_operation(create {REGULAR_AND})

    end

    add_disjunction
    do
    	add_binary_operation(create {REGULAR_OR})
    end

    add_implication
    do
       add_binary_operation(create {IMPLICATION})
    end



    add_equality
    -- binary relational
    do
    	add_binary_operation(create {EQUAL_TO})
    end

    add_greater_than
    -- binary relational
    do
    	 add_binary_operation(create {GREATER_THAN})
    end

    add_less_than
    -- binary relational
    do
    	add_binary_operation(create {LESS_THAN})
    end


    add_union
    -- binary set op
    do
    	add_binary_operation(create {UNION})
    end

    add_intersection
    -- binary set op
    do
    	add_binary_operation(create {INTERSECT})
    end

    add_difference
    -- binary set op
    do
    	add_binary_operation(create {DIFFERENCE})
    end

feature -- Unary operation commands

	add_negative
	--arithmatic
	do
		add_unary_operation(create {NEGATIVE})
	end


	add_negation
	--logical
	do
		add_unary_operation(create {NEGATION})
	end


	add_sum
	--composite
	do
		add_unary_operation(create {SUM})
	end

	add_generalized_and
	do
		add_unary_operation(create {FORALL})
	end

	add_generalized_or
	do
		add_unary_operation(create {EXISTS})
	end

feature -- Primitive Type Expressions
	add_integer_constant (i : INTEGER_64)
	require
		not is_expression_fully_specified
	do
		create integer_constant.make
		integer_constant.set_integer_constant(i)
		if is_new then
			myexpression := integer_constant.deep_twin
			is_new := false
		else
			if attached {COMPOSITE_EXPRESSION}myexpression as comp_exp then
				comp_exp.add (integer_constant)
			end
		end

		if is_new_set then
			is_new_set := false
		end

		if not (peek = expression_at_set_enumeration) then
			pop
		end

		set_error_message (status_ok)
	ensure
		error_message.is_equal (status_ok)
	end

	add_boolean_constant (b : BOOLEAN)
	require
		not is_expression_fully_specified
	do
		create boolean_constant
		boolean_constant.set_boolean_constant(b)
		if is_new then
			myexpression := boolean_constant.deep_twin
			is_new := false
		else
			if attached {COMPOSITE_EXPRESSION}myexpression as comp_exp then
				comp_exp.add (boolean_constant)
			end

		end

		if is_new_set then
			is_new_set := false
		end

		if not (peek = expression_at_set_enumeration) then
			pop
		end

		set_error_message (status_ok)
	ensure
		error_message.is_equal (status_ok)
	end


	reset
		-- Reset model state.
	require
		not is_newly_initialized
	do
		make
		is_new := true
		set_error_message(status_ok)
	ensure
		error_message.is_equal (status_ok)
	end

feature -- Enumeration operations
	start_set_enumeration
	require
		not is_expression_fully_specified
	do
		create set_enumerator.make
		-- this will need to be updated

		set_enumerator.set_expression_state (expresssion_is_extended)
		set_enumerator.add_operation (create {QUESTION})
		if is_new then
			myexpression := set_enumerator.deep_twin
			is_new := false
		else
			if attached {COMPOSITE_EXPRESSION}myexpression as comp_exp then
				comp_exp.add (set_enumerator)
			end
		end

		is_new_set := true

		pop
		push (expression_at_set_enumeration)
		set_enum_count := set_enum_count + 1
		set_error_message (status_ok)

	ensure
		error_message.is_equal (status_ok)
	end

	end_set_enumeration
	require
		not is_expression_fully_specified and is_set_enum_being_specified and not is_set_enum_empty
	do
		if attached {COMPOSITE_EXPRESSION}myexpression as comp_exp then
			comp_exp.end_set_enumeration
			pop_set_enumeration
			set_error_message (status_ok)
			set_enum_count := set_enum_count - 1
		end
	ensure
		error_message.is_equal (status_ok)
	end

feature{NONE} -- Auxillary Commands
	-- add binary operation
	add_binary_operation (e : TERMINALS)
	require
		not is_expression_fully_specified
	do
		-- create a new binary operation and add it to the list of operations.
		create binary_op.make
		binary_op.add_operation (e)
		if is_new then
			myexpression := binary_op.deep_twin
			is_new := false
		else
			if attached {COMPOSITE_EXPRESSION}myexpression as comp_exp then
				comp_exp.add (binary_op)
			end
		end

		if is_new_set then
			is_new_set := false
		end

		pop
		push(expresssion_is_extended)
		push(expresssion_is_extended)
		set_error_message (status_ok)
	ensure
		error_message.is_equal (status_ok)
	end


	add_unary_operation(e: TERMINALS)
	require
		not is_expression_fully_specified
	do
		create unary_operation.make
		unary_operation.add_operation(e)
		if is_new then
			myexpression := unary_operation.deep_twin
			is_new := false
		else
			if attached {COMPOSITE_EXPRESSION}myexpression as comp_exp then
				comp_exp.add (unary_operation)
			end
		end

		if is_new_set then
			is_new_set := false
		end
		pop
		push(expresssion_is_extended)
		set_error_message (status_ok)
	ensure
		error_message.is_equal (status_ok)
	end

feature  -- Error Booleans
	no_expression_in_stack : BOOLEAN
	do
		Result := my_stack.is_empty
	end

	is_expression_fully_specified : BOOLEAN
	do
		Result := my_stack.is_empty and not is_new
	end

	is_set_enum_being_specified : BOOLEAN
	do
		Result := not (set_enum_count = 0)
	end

	is_set_enum_empty : BOOLEAN
	do
		Result := is_new_set
	end

	is_newly_initialized : BOOLEAN
	do
		Result := is_new
	end

feature{NONE} -- Stack Operations
    expression_at_set_enumeration : INTEGER = 2
	expresssion_is_extended : INTEGER = 1
	pop
	do
		if not my_stack.is_empty and not (peek = expression_at_set_enumeration) then
			my_stack.go_i_th (my_stack.count)
			my_stack.remove
		end
	end

	push ( i : INTEGER)
	do
		my_stack.extend (i)
	end

	peek : INTEGER
	do
		if not my_stack.is_empty then
			Result := my_stack.at (my_stack.count)
		else
			Result := 0
		end
	end


	pop_set_enumeration
	do
		if not my_stack.is_empty  then
			my_stack.go_i_th (my_stack.count)
			my_stack.remove
		end
	end

feature -- Queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("Expression currently specified: ")
			if is_new then
				report.make_empty
				--report := "?"
				report.append ("?")
			end
			Result.append (report)
			Result.append ("%N")
			Result.append ("  ")
			Result.append ("Report: ")
			Result.append (error_message)

		end




end


