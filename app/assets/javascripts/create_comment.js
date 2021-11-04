function commentSwitch(e) {
  e.preventDefault()
  createCommentLink = e.target;
  commentForm = e.path[1].querySelector('.comment-form') || e.path[3].querySelector('.comment-form');
  commentContent = e.path[1].querySelector('.comment-content') || e.path[3].querySelector('.comment-content') || undefined;
  createCommentLink.setAttribute('style', 'display: none');
  commentForm.setAttribute('style', 'display: block');
}

document.addEventListener('click', e => {
  if (e.target.className === 'create-comment') {
    commentSwitch(e);
    if (commentContent) {
      commentContent.setAttribute('style', 'display: none');
    }
  } else if (e.target.className === 'create-comment no-content-hide') {
    commentSwitch(e);
  }
})
