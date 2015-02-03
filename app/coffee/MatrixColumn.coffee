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
		for index in [0...@parent.rows.amount]
			row = document.createElement 'div'
			row.classList.add 'row'
			row.innerHTML = index + 11
			frag.appendChild row
			@rows.push row
		@element.appendChild frag
		return
