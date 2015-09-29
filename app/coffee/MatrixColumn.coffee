class MatrixColumn

	# -- settings
	smooth: 5 # check stepBegin and stepEnd after any modification
	transformations: [
		'none'
		'none'
		'none'
		'rotate'
		'flip-hor'
		'flip-ver'
	]
	# -- instance properties
	# element: htmlElement
	# rows: [htmlElement]
	# begin: int
	# length: int

	constructor: (@parent)->
		do @createElement
		do @generateRows
		do @randomize
		return

	createElement: ()->
		@element = document.createElement 'div'
		@element.classList.add 'column'
		@parent.wrapper.appendChild @element
		return

	generateRows: ()->
		@rows = []
		frag = document.createDocumentFragment()
		for dummy in [0...@parent.rowsAmount]
			row = document.createElement 'div'
			row.classList.add 'row'
			row.innerHTML = @generateRandomChar()
			frag.appendChild row
			@rows.push row
		@element.appendChild frag
		return

	# return characters with these codes: 0..9, 65382...65437
	generateRandomChar: ()->
		charMin = 65382
		charMax = 65437
		rand = Math.floor(Math.random() * (charMax - charMin + 10))
		rand += if rand < 10 then 48 else (charMin - 10)
		String.fromCharCode rand

	randomize: ()->
		@begin = Math.ceil(Math.random() * @parent.rowsAmount * 4)
		@begin *= -1
		@length = @smooth * 2
		@length += Math.floor(Math.random() * @parent.rowsAmount)
		# apply random transformations
		for row in @rows
			for trans in @transformations
				row.classList.remove(trans)
			row.classList.add @getRandomTransform()
		return

	getRandomTransform: ()->
		randClass = Math.floor Math.random() * @transformations.length
		@transformations[randClass]

	step: ()->
		@begin += 1
		if @begin < 0
			return
		endPos = @begin - @length
		if endPos > @parent.rowsAmount
			do @randomize
			return
		@stepBegin()
		@stepEnd(endPos)
		@swapRandom()
		return

	stepBegin: ()->
		for index in [@begin...@begin-@smooth]
			if @rows[index]?
				diff = index - @begin + @smooth
				@rows[index].style.color = @formatColor diff*10 + 50
		return

	stepEnd: (endPos)->
		for index in [endPos+@smooth...endPos]
			if @rows[index]?
				diff = index - endPos
				@rows[index].style.color = @formatColor diff*10 - 5, 50
		return

	swapRandom: ()->
		rand = Math.ceil Math.random() * @length
		rand = @begin - rand
		if @rows[rand]?
			@rows[rand].innerHTML = @generateRandomChar()
		return

	formatColor: (lightness, saturation = 100)->
		"hsl(120, #{saturation}%, #{lightness}%)"
