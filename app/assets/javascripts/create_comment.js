function commentSwitch(e) {
  e.preventDefault()
  const createCommentLink = e.target;
  const commentForm = e.path ? e.path[1].querySelector('.comment-form') 
    || e.path[3].querySelector('.comment-form')
    : e.composedPath()[1].querySelector('.comment-form')
    || e.composedPath()[3].querySelector('.comment-form');
  createCommentLink.setAttribute('style', 'display: none');
  commentForm.setAttribute('style', 'display: block');
}

document.addEventListener('click', e => {
  console.log(e.composedPath())

  const commentContent = e.path ? e.path[1].querySelector('.comment-content')
    || e.path[3].querySelector('.comment-content')
    : e.composedPath()[1].querySelector('.comment-content')
    || e.composedPath()[3].querySelector('.comment-content')
    || undefined;

  if (e.target.className === 'create-comment') {
    commentSwitch(e);
    if (commentContent) {
      commentContent.setAttribute('style', 'display: none');
    }
  } else if (e.target.className === 'create-comment no-content-hide') {
    commentSwitch(e);
  }
})
