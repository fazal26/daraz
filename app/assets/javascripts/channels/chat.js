App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var comments;
    comments = $('#commentBox');
    comments.prepend(data['comment']);
  }
});