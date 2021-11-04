document.addEventListener('click', e => {
  console.log(e)
  if (e.target.className === 'create-comment') {
    console.log(e.path[1].querySelector('.comment-form'));
    createCommentLink = e.target;
    commentForm = e.path[1].querySelector('.comment-form') || e.path[3].querySelector('.comment-form');
    commentContent = e.path[1].querySelector('.comment-content') || e.path[3].querySelector('.comment-content') || undefined;
    console.log(commentContent)
    createCommentLink.setAttribute('style', 'display: none');
    commentForm.setAttribute('style', 'display: block');
    if (commentContent) {
      commentContent.setAttribute('style', 'display: none');
    }
  }
})
