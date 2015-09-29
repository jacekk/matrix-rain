var MatrixColumn;

MatrixColumn = (function() {
  MatrixColumn.prototype.smooth = 5;

  MatrixColumn.prototype.transformations = ['none', 'none', 'none', 'rotate', 'flip-hor', 'flip-ver'];

  function MatrixColumn(parent) {
    this.parent = parent;
    this.createElement();
    this.generateRows();
    this.randomize();
    return;
  }

  MatrixColumn.prototype.createElement = function() {
    this.element = document.createElement('div');
    this.element.classList.add('column');
    this.parent.wrapper.appendChild(this.element);
  };

  MatrixColumn.prototype.generateRows = function() {
    var dummy, frag, row, _i, _ref;
    this.rows = [];
    frag = document.createDocumentFragment();
    for (dummy = _i = 0, _ref = this.parent.rowsAmount; 0 <= _ref ? _i < _ref : _i > _ref; dummy = 0 <= _ref ? ++_i : --_i) {
      row = document.createElement('div');
      row.classList.add('row');
      row.innerHTML = this.generateRandomChar();
      frag.appendChild(row);
      this.rows.push(row);
    }
    this.element.appendChild(frag);
  };

  MatrixColumn.prototype.generateRandomChar = function() {
    var charMax, charMin, rand;
    charMin = 65382;
    charMax = 65437;
    rand = Math.floor(Math.random() * (charMax - charMin + 10));
    rand += rand < 10 ? 48 : charMin - 10;
    return String.fromCharCode(rand);
  };

  MatrixColumn.prototype.randomize = function() {
    var row, trans, _i, _j, _len, _len1, _ref, _ref1;
    this.begin = Math.ceil(Math.random() * this.parent.rowsAmount * 4);
    this.begin *= -1;
    this.length = this.smooth * 2;
    this.length += Math.floor(Math.random() * this.parent.rowsAmount);
    _ref = this.rows;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      row = _ref[_i];
      _ref1 = this.transformations;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        trans = _ref1[_j];
        row.classList.remove(trans);
      }
      row.classList.add(this.getRandomTransform());
    }
  };

  MatrixColumn.prototype.getRandomTransform = function() {
    var randClass;
    randClass = Math.floor(Math.random() * this.transformations.length);
    return this.transformations[randClass];
  };

  MatrixColumn.prototype.step = function() {
    var endPos;
    this.begin += 1;
    if (this.begin < 0) {
      return;
    }
    endPos = this.begin - this.length;
    if (endPos > this.parent.rowsAmount) {
      this.randomize();
      return;
    }
    this.stepBegin();
    this.stepEnd(endPos);
    this.swapRandom();
  };

  MatrixColumn.prototype.stepBegin = function() {
    var diff, index, _i, _ref, _ref1;
    for (index = _i = _ref = this.begin, _ref1 = this.begin - this.smooth; _ref <= _ref1 ? _i < _ref1 : _i > _ref1; index = _ref <= _ref1 ? ++_i : --_i) {
      if (this.rows[index] != null) {
        diff = index - this.begin + this.smooth;
        this.rows[index].style.color = this.formatColor(diff * 10 + 50);
      }
    }
  };

  MatrixColumn.prototype.stepEnd = function(endPos) {
    var diff, index, _i, _ref;
    for (index = _i = _ref = endPos + this.smooth; _ref <= endPos ? _i < endPos : _i > endPos; index = _ref <= endPos ? ++_i : --_i) {
      if (this.rows[index] != null) {
        diff = index - endPos;
        this.rows[index].style.color = this.formatColor(diff * 10 - 5, 50);
      }
    }
  };

  MatrixColumn.prototype.swapRandom = function() {
    var rand;
    rand = Math.ceil(Math.random() * this.length);
    rand = this.begin - rand;
    if (this.rows[rand] != null) {
      this.rows[rand].innerHTML = this.generateRandomChar();
    }
  };

  MatrixColumn.prototype.formatColor = function(lightness, saturation) {
    if (saturation == null) {
      saturation = 100;
    }
    return "hsl(120, " + saturation + "%, " + lightness + "%)";
  };

  return MatrixColumn;

})();
