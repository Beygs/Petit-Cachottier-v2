createComment = document.querySelector('.create-comment');
commentForm = document.querySelector('.comment-form');

document.addEventListener('click', e => {
  if (e.target.className === 'create-comment') {
    createComment.setAttribute('style', 'display: none');
    commentForm.setAttribute('style', 'display: block');
  }
})
