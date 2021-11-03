const canvas = document.querySelector('canvas');

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

const c = canvas.getContext('2d');

const mouse = {
  x: undefined,
  y: undefined
}

const maxRadius = 20;

const colors = [
  '#f6768e',
  '#da8ccd',
  '#a4a8eb',
  '#7ebce6',
  '#f6bd60',
  '#fde12d',
  '#ffbe0b'
]

window.addEventListener('mousemove', event => {
  mouse.x = event.x;
  mouse.y = event.y + window.scrollY;
})

window.addEventListener('resize', () => {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;

  init();
})

window.addEventListener('scroll', e => {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight + window.scrollY;
})

function Circle(x, y, dx, dy, radius) {
  this.x = x;
  this.y = y;
  this.dx = dx;
  this.dy = dy;
  this.radius = radius;
  this.minRadius = radius;
  this.color = colors[Math.floor(Math.random() * colors.length)];

  this.draw = () => {
    c.beginPath();
    c.arc(this.x, this.y, this.radius, Math.PI * 2, false);
    c.fillStyle = this.color;
    c.fill();
  }

  this.update = () => {
    if (this.x + this.radius > canvas.width || this.x - this.radius < 0) {
      this.dx = -this.dx;
    }

    if (this.y + this.radius > canvas.height || this.y - this.radius < 0) {
      this.dy = -this.dy;
    }

    this.x += this.dx;
    this.y += this.dy;

    if (
      mouse.x - this.x < 50 
      && mouse.x - this.x > -50
      && mouse.y - this.y < 50 
      && mouse.y - this.y > -50) {
      
      if (this.radius < maxRadius) {
        this.radius += 1;
      }
    } else if (this.radius > this.minRadius) {
      this.radius -= 1;
    }

    this.draw();
  }
}

let circles = [];

function init() {
  circles = [];

  for (let i = 0; i < 800; i++) {
    let radius = Math.random() * 3 + 1;
    let x = Math.random() * (innerWidth - radius * 2) + radius;
    let dx = (Math.random() - 0.5) * 2;
    let y = Math.random() * (innerHeight - radius * 2) + radius;
    let dy = (Math.random() - 0.5) * 2;

    circles.push(new Circle(x, y, dx, dy, radius))
  }
}

function animate() {
  requestAnimationFrame(animate);
  c.clearRect(0, 0, canvas.width, canvas.height);
  circles.forEach(circle => {
    circle.update();
  })
}

init();
animate();