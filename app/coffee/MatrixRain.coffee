class MatrixRain

	cols: {
		size: 20
		amount: 20
		list: []
	}
	rows: {
		size: 20
		amount: 20
	}

	constructor: ()->
		do @setEnvParams
		do @generateColumns
		do @initTimer
		return

	setEnvParams: ()->
		@wrapper = document.querySelector('.page-wrapper')
		if not @wrapper?
			console.log 'Wrapper element not found!!!'
			return
		@rows.amount = Math.ceil window.innerHeight / @rows.size
		@cols.amount = Math.floor window.innerWidth / @cols.size
		return

	generateColumns: ()->
		for index in [0...@cols.amount]
			@cols.list.push new MatrixColumn(@)
		return

	initTimer: ()->
		return
