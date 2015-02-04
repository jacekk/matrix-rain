var MatrixRain;

MatrixRain = (function() {
  MatrixRain.prototype.colSize = 14;

  MatrixRain.prototype.rowSize = 18;

  function MatrixRain() {
    this.setEnvParams();
    if (this.wrapper == null) {
      console.log('Wrapper element not found!!!');
      return;
    }
    this.generateColumns();
    this.initTimer();
    return;
  }

  MatrixRain.prototype.setEnvParams = function() {
    this.wrapper = document.querySelector('.page-wrapper');
    this.rowsAmount = Math.floor(window.innerHeight / this.rowSize);
    this.colsAmount = Math.floor(window.innerWidth / this.colSize);
  };

  MatrixRain.prototype.generateColumns = function() {
    var index, _i, _ref;
    this.columns = [];
    for (index = _i = 0, _ref = this.colsAmount; _i < _ref; index = _i += 1) {
      this.columns.push(new MatrixColumn(this));
    }
  };

  MatrixRain.prototype.initTimer = function() {
    var columns;
    columns = this.columns;
    this.intv = setInterval(function() {
      var column, _i, _len;
      for (_i = 0, _len = columns.length; _i < _len; _i++) {
        column = columns[_i];
        column.step();
      }
    }, 100);
  };

  return MatrixRain;

})();
