const wave11 = document.getElementById('wave11');
const wave21 = document.getElementById('wave12');
const wave31 = document.getElementById('wave13');
const wave12 = document.getElementById('wave12');
const wave22 = document.getElementById('wave22');
const wave32 = document.getElementById('wave32');

const tween1 = KUTE.fromTo(
  wave11,
  { path: wave11 },
  { path: wave12 },
  { repeat: 999, duration: 3000, yoyo: true }
);

const tween2 = KUTE.fromTo(
  '#wave21',
  { path: '#wave21' },
  { path: '#wave22' },
  { repeat: 999, duration: 3000, yoyo: true }
);

const tween3 = KUTE.fromTo(
  '#wave31',
  { path: '#wave31' },
  { path: '#wave32' },
  { repeat: 999, duration: 3000, yoyo: true }
);

tween1.start();
tween2.start();
tween3.start();
