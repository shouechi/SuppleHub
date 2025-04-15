import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.action === 'destroy') {
    const commentElement = document.getElementById(`comment-${data.comment_id}`);
    if (commentElement) {
      commentElement.remove();
    }
    } else if (data.action === "create") {
      // 現在のユーザーIDを取得
      const currentUserId = document.querySelector('meta[name="current-user-id"]')?.content;
      
      // 削除ボタンの表示を判断（コメント作成者と現在のユーザーが一致する場合）
      const deleteButton = currentUserId && currentUserId == data.comment.user_id
      ? `<a href="/posts/${data.comment.post_id}/comments/${data.comment.id}"
            data-turbo-method="delete"
            data-turbo-confirm="本当に削除しますか？"
            class="btn btn-ghost btn-xs text-error">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash-2">
              <path d="M3 6h18"></path>
              <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path>
              <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path>
              <line x1="10" y1="11" x2="10" y2="17"></line>
              <line x1="14" y1="11" x2="14" y2="17"></line>
            </svg>
          </a>`
      : '';
    
    const html = `
      <div class="flex gap-4 p-4 border-b border-base-200" id="comment-${data.comment.id}">
        <!-- ユーザーアバター -->
        <div class="avatar placeholder self-start">
          <div class="bg-neutral-focus text-neutral-content rounded-full w-12">
            <span>${data.user.charAt(0).toUpperCase()}</span>
          </div>
        </div>
    
        <div class="flex-1">
          <div class="flex justify-between items-center mb-2">
            <div>
              <p class="font-medium">${data.user}</p>
              <p class="text-xs text-gray-500">${data.comment.created_at}</p>
            </div>
            ${deleteButton}
          </div>
    
          <div class="prose max-w-none">
            <p>${data.comment.content}</p>
          </div>
        </div>
      </div>
    `;
    
      
      const comments = document.getElementById('comments');
      const newComment = document.getElementById('comment_content');
      comments.insertAdjacentHTML('afterbegin', html);
      newComment.value = '';
    }
  }
});