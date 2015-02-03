class MatrixRain

	cols: {
		size: 14
		amount: 0
		list: []
	}
	rows: {
		size: 18
		amount: 0
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
		for dummy in [0...@cols.amount] by 1
			@cols.list.push new MatrixColumn(@)
		return

	initTimer: ()->
		return
