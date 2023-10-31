function make2DArray(cols, rows) {
  let arr = new Array(cols);
  for (let i = 0; i < arr.length; i++) {
    arr[i] = new Array(rows);
  }
  return arr;
}

let grid;
let cols;
let rows;
let resolution = 20;
let canvasCreated = false;

function shouldCreateCanvas() {
  // Check the URL or any other condition
  return window.location.pathname === '/welcome/about';
}

function setup() {
  if (!canvasCreated && shouldCreateCanvas()) {
    frameRate(7);
    createCanvas(windowWidth, windowHeight);
    cols = Math.floor(width / resolution);
    rows = Math.floor(height / resolution);
    grid = make2DArray(cols, rows);
    for (let i = 0; i < cols; i++) {
      for (let j = 0; j < rows; j++) {
        grid[i][j] = floor(random(2));
      }
    }
    canvasCreated = true;
  }
}

function draw() {
  clear();

  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      let x = i * resolution;
      let y = j * resolution;
      if (grid[i][j] == 1) {
        fill(color('rgba(250, 249, 241, 1)'));
        noStroke();
        rect(x, y, resolution, resolution);
      }
      if (grid[i][j] == 0) {
        fill(color('rgba(225, 219, 208, 0)'));
        noStroke();
        rect(x, y, resolution, resolution);
      }
    }
  }

  let next = make2DArray(cols, rows);

  // Compute next based on grid
  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      let state = grid[i][j];
      // Count live neighbors!
      let sum = 0;
      let neighbors = countNeighbors(grid, i, j);

      if (state == 0 && neighbors == 3) {
        next[i][j] = 1;
      } else if (state == 1 && (neighbors < 2 || neighbors > 3)) {
        next[i][j] = 0;
      } else {
        next[i][j] = state;
      }
    }
  }

  grid = next;
}

function countNeighbors(grid, x, y) {
  let sum = 0;
  for (let i = -1; i < 2; i++) {
    for (let j = -1; j < 2; j++) {
      let col = (x + i + cols) % cols;
      let row = (y + j + rows) % rows;
      sum += grid[col][row];
    }
  }
  sum -= grid[x][y];
  return sum;
}

function makeWhiteCell(i, j) {
  grid[i][j] = 1;
  grid[i + 1][j] = 1;
  grid[i - 1][j] = 1;
  grid[i][j - 1] = 1;
  grid[i][j + 1] = 1;
}

function mouseClicked(event) {
  const vh =
    Math.max(
      document.documentElement.clientHeight || 0,
      window.innerHeight || 0
    ) / 100;
  num1 = Math.floor(event.x / resolution);
  num2 =
    Math.floor((event.y - 230 * vh + window.scrollY) / resolution) -
    2;
  console.log('---------');
  console.log('230 на вьпорт ' + 230 * vh);
  console.log('нахождение по y ' + event.y);
  console.log('скролл ' + window.scrollY);
  makeWhiteCell(num1, num2);
}
