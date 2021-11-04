const tx = document.getElementsByTagName("textarea");
for (let i = 0; i < tx.length; i++) {
  tx[i].setAttribute(
    "style", 
    "min-height: calc(3.5rem + 2px); height:" + (tx[i].scrollHeight) + "px;overflow-y:hidden;"
  );
  tx[i].addEventListener("input", OnInput, false);
}

function OnInput() {
  this.style.height = "auto";
  this.style.height = (this.scrollHeight) + "px";
}

flash = document.querySelector('.flash');

setTimeout(() => {
  flash.remove();
}, 6000)

const ul = document.getElementsByTagName('ul')

for (let i = 0; i < ul.length; i++) {
  if (ul[i].children.length === 0) {
    ul[i].innerHTML = ''
  }
}
