    function scrollfunc(){
        var elem = document.getElementsByClassName('chat-scroll');
        var i;
        for (i in elem) {
            elem[i].scrollTop = elem[i].scrollHeight;
        }
    }

    function orderNumberChat(id, type, id_user){
            var idNumber = id;

            var chatSocket = new WebSocket(
                'ws://' + 'client.gsmagency.ru:1122' +
                '/ws/'+ type + '/' + idNumber + '/');

            chatSocket.onmessage = function(e) {
                var data = JSON.parse(e.data);
                var message = data['message'];
                var obj_user = data['obj_user']
                $("#chat-log" + '-' + type).append("<div class='msg'><b>" + obj_user + ":</b>" + "<br>" + message + "<br></div>");
                // $(".msg").addClass("new-msg");
                scrollfunc();
            };

            document.querySelector('#chat-message-input-order').focus();
            document.querySelector('#chat-message-input' + '-' + type).onkeyup = function(e) {
                if (e.keyCode === 13) {  // enter, return
                    document.querySelector('#chat-message-submit' + '-' + type).click();
                }
            };

            document.querySelector('#chat-message-submit' + '-' + type).onclick = function(e) {
            var messageInputDom = document.querySelector('#chat-message-input' + '-' + type);
            var message = messageInputDom.value;
            chatSocket.send(JSON.stringify({
                'message': message,
                'id_user': id_user, 
                'id': id,
            }));

            messageInputDom.value = '';
            };
        }