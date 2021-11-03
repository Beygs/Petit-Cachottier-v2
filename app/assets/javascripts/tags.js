const tagContainer = document.querySelector('.tag-container');
const input = document.querySelector('.tag-input');
const tagsArray = document.querySelector('.tags-array')

let tags = [];

initialize();

function initialize() {
  tagsArray.value.split(';').forEach(tag => {
    tags.push(tag);
    addTags();
  })
}

function createTag(label) {
  const div = document.createElement('div');
  div.setAttribute('class', 'tag');
  const span = document.createElement('span');
  span.innerHTML = label;
  const closeBtn = document.createElement('i');
  closeBtn.setAttribute('class', 'fas fa-times');
  closeBtn.setAttribute('data-item', label)

  div.appendChild(span);
  div.appendChild(closeBtn);

  return div;
}

function reset() {
  document.querySelectorAll('.tag').forEach(tag => {
    tag.parentElement.removeChild(tag);
  })
}

function addTags() {
  reset();
  tags = tags.filter(tag => tag !== '');
  tags.slice().reverse().forEach(tag => {
    const new_tag = createTag(tag);
    tagContainer.prepend(new_tag);
  })
  tagsArray.value = tags.join(';');
}

input.addEventListener('keyup', e => {
  if (e.key === ';') {
    tags.push(input.value.slice(0, -1));
    addTags();
    input.value = '';
  }
});

document.addEventListener('click', e => {
  if (e.target.tagName === 'I') {
    const value = e.target.getAttribute('data-item');
    const id = tags.indexOf(value);
    tags = [...tags.slice(0, id), ...tags.slice(id + 1)]
    addTags();
  }
})
