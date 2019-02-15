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
                var usr_id = data['id_user']
                var file = data['file']
                console.log(file)
                if (message != "") {
                    $("#chat-log" + '-' + type).append("<div class='msg'><b>" + obj_user + ":</b>" + "<br>" + message + "<br></div>");
                }
                if (file != ""){
                    $("#chat-log" + '-' + type).append("<div class='msg'><b>" + obj_user + ":</b>" + "<br>" + "<a href=" + file + ">"+ file +"<br>")
                }
                if (usr_id != id_user) {
                    $(".msg").addClass("new-msg");
                } else {
                    $(".msg").removeClass();
                }
                scrollfunc();
            };

            document.querySelector('#chat-message-input' + '-' + type).onkeyup = function(e) {
                if (e.keyCode === 13) {  // enter, return
                    document.querySelector('#chat-message-submit' + '-' + type).click();
                }
            };

            $(document).click(function(e) {
                $(".msg").removeClass();})

            document.querySelector('#chat-message-submit' + '-' + type).onclick = function(e) {
            var messageInputDom = document.querySelector('#chat-message-input' + '-' + type);
            var message = messageInputDom.value;
            if (message != "") {
            chatSocket.send(JSON.stringify({
                'file': "",
                'message': message,
                'id_user': id_user, 
                'id': id,
            }));
            messageInputDom.value = '';
        };}

        $(".ord").click(
            function(){
            string_id = $(this).attr("id")
            array_id = string_id.split("_")
            chatSocket.send(JSON.stringify({
                'file': $("#file_" + array_id[2]).attr("href"),
                'image': '',
                'message': '',
                'id_user': id_user, 
                'id': id,

            }));
        })

        };


        function positionChat(id, type, id_user, des1, des2, des3, des4)   {
            var positionNumber = id;

            var chatSocket = new WebSocket(
                'ws://' + 'client.gsmagency.ru:1122' +
                '/ws/'+ type + '/' + positionNumber + '/');
            chatSocket.onmessage = function(e) {
                var data = JSON.parse(e.data);
                var message = data['message'];
                var obj_user = data['obj_user']
                var image = data['image']
                var usr_id = data['id_user']
                var file = data['file']
                if (message != "") {
                    $("#chat-log" + '-' + type).append("<div class='msg'><b>" + obj_user + ":</b>" + "<br>" + message + "<br></div>");
                }
                if (image != ""){
                    $("#chat-log" + '-' + type).append("<div class='msg'><b>" + obj_user + ":</b>" + "<br>" + "<img height='500px' src='/media/" + image + "'><br>");
                }
                if (file != ""){
                    $("#chat-log" + '-' + type).append("<div class='msg'><b>" + obj_user + ":</b>" + "<br>" + "<a href=" + file + ">"+ file +"<br>")
                }
                if (usr_id != id_user) {
                    $(".msg").addClass("new-msg");
                } else {
                    $(".msg").removeClass();
                }
                scrollfunc();
            };

            document.querySelector('#chat-message-input' + '-' + type).onkeyup = function(e) {
                if (e.keyCode === 13) {  // enter, return
                    document.querySelector('#chat-message-submit' + '-' + type).click();
                }
            };

            // document.querySelector('#chat-message-input' + '-' + type).onfocus = function(e) {
            //     $(".msg").removeClass();
            // }
            $(document).click(function(e) {
                        $(".msg").removeClass();})

            document.querySelector('#chat-message-submit' + '-' + type).onclick = function(e) {
            var messageInputDom = document.querySelector('#chat-message-input' + '-' + type);
            var message = messageInputDom.value;
            if (message != "") {
            chatSocket.send(JSON.stringify({
                'image': '',
                'message': message,
                'id_user': id_user, 
                'id': id,
                'file': "",
            }));
            messageInputDom.value = '';
        };}

            $(".pos").click(
            function(){
            string_id = $(this).attr("id")
            array_id = string_id.split("_")
            chatSocket.send(JSON.stringify({
                'file': $("#file_" + array_id[2]).attr("href"),
                'image': '',
                'message': '',
                'id_user': id_user, 
                'id': id,

            }));
        })
            try {
            // Первый дизайн
            document.querySelector("#position_img1_to_socket").onclick = function(e){
                var messageInputDom = document.querySelector('#chat-message-input' + '-' + type);
                var message = messageInputDom.value;
                chatSocket.send(JSON.stringify({
                'image': des1,
                'message': message,
                'id_user': id_user, 
                'id': id,
                "file": "",

            }));
            messageInputDom.value = '';
            };
        } catch(e){

        }

            try {
            // Второй дизайн
            document.querySelector("#position_img2_to_socket").onclick = function(e){
                var messageInputDom = document.querySelector('#chat-message-input' + '-' + type);
                var message = messageInputDom.value;
                chatSocket.send(JSON.stringify({
                'image': des2,
                'message': message,
                'id_user': id_user, 
                'id': id,
                "file": "",

            }));
            messageInputDom.value = '';
            };
        } catch(e){

        }

        try {
            // Третий дизайн
            document.querySelector("#position_img3_to_socket").onclick = function(e){
                var messageInputDom = document.querySelector('#chat-message-input' + '-' + type);
                var message = messageInputDom.value;
                chatSocket.send(JSON.stringify({
                'image': des3,
                'message': message,
                'id_user': id_user, 
                'id': id,
                'file': "",

            }));
            messageInputDom.value = '';
            };
        } catch(e){

        }

            try {
            // Четвертый дизайн
            document.querySelector("#position_img4_to_socket").onclick = function(e){
                var messageInputDom = document.querySelector('#chat-message-input' + '-' + type);
                var message = messageInputDom.value;
                chatSocket.send(JSON.stringify({
                'image': des4,
                'message': message,
                'id_user': id_user, 
                'id': id,
                'file': "",

            }));
            messageInputDom.value = '';
            };
        } catch(e){

        }
    }