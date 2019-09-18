App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var comments;
    if (data['parent_id']){      
      var path = "#comment-"+ data.parent_id;
      comments = $(path);
    }else{
      comments = $('#commentBox');
    }
    comments.prepend(data['comment']);
    comments.scrollTop(comments[0].scrollHeight);
  }
});