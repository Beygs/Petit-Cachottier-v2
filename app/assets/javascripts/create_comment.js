document.addEventListener('click', e => {
  if (e.target.className === 'create-comment') {
    console.log(e.path[1].querySelector('.comment-form'));
    createCommentLink = e.target;
    commentForm = e.path[1].querySelector('.comment-form');
    commentContent = e.path[1].querySelector('.comment-content') || undefined;
    createCommentLink.setAttribute('style', 'display: none');
    commentForm.setAttribute('style', 'display: block');
    if (commentContent) {
      commentContent.setAttribute('style', 'display: none');
    }
  }
})
