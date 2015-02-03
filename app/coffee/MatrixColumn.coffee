class MatrixColumn

	index: 0
	element: null
	rows: []

	constructor: (@parent)->
		@index = @parent.cols.list.length
		do @createElement
		do @generateRows
		return

	createElement: ()->
		@element = document.createElement 'div'
		@element.classList.add 'column'
		@parent.wrapper.appendChild @element
		return

	generateRows: ()->
		frag = document.createDocumentFragment()
		for dummy in [0...@parent.rows.amount] by 1
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
