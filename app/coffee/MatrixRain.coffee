class MatrixRain

	# -- settings
	colSize: 14
	rowSize: 18
	# -- instance properties
	# colsAmount: int
	# rowsAmount: int
	# columns: [MatrixColumn]
	# intv: interval
	# wrapper: htmlElement

	constructor: ()->
		do @setEnvParams
		if not @wrapper?
			console.log 'Wrapper element not found!!!'
			return
		do @generateColumns
		do @initTimer
		return

	setEnvParams: ()->
		@wrapper = document.querySelector('.page-wrapper')
		@rowsAmount = Math.floor window.innerHeight / @rowSize
		@colsAmount = Math.floor window.innerWidth / @colSize
		return

	generateColumns: ()->
		@columns = []
		for index in [0...@colsAmount] by 1
			@columns.push new MatrixColumn(@)
		return

	initTimer: ()->
		columns = @columns
		@intv = setInterval ()->
			column.step() for column in columns
			return
		, 100
		return
