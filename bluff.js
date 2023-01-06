var me={};
var game_status={};
var key=0;
var number = null;

//var turn = "A";
var plturn = null;
var bbaa;
var change_turn;

$(function(){
    
    number = $('#playerno').val();

    $('#bluff_login').click( login_to_game);
   // $('#bluff_login').click( fill_cards_start);

})

var intervalId = window.setInterval(function(){

$.ajax({url: "bluff.php/show_calls/",
        method: 'GET',
        dataType: "json",
        contentType: 'application/json',
        success:change_label
    });  
function change_label(data){
    var o=data[0];
    document.getElementById('my_label').innerHTML=(o.total+","+o.text);

}
 }, 100);

var intervalId2 = window.setInterval(function(){
    $.ajax(
        {
            method: 'GET',
            dataType: "json",
            contentType: 'application/json',
            url:"bluff.php/checkturn/",
            success:checkTheTurn
        }
    )
    function checkTheTurn(data){
        var aaaa=data[0];
        bbaa = aaaa.player_turn;
        // alert('turncheck: ' + aaaa.player_turn);
    }
}, 100);

function draw_selection(){
    var t=null;
    if(number=='A'){
        t="<h3>You are Player 1</h3>";
    }
    if(number=='B'){
        t="<h3>You are Player 2</h3>";
    }
    t+="<label for='Your Cards:'>Your Cards:</label>";
    t+="<select id='cards' name='cards' id='cards'>";
    t+='</select>';
    t+="<br>";
    t+="<br>";
    //<button id='bluff_login' class='btn btn-primary'>Join Game</button><br>
    t+="<button id='play_card' onclick='show_me()'>Play this card</button>";
    t+="<br>";
    t+="<br>";
    t+="<label>Type your last played(times,symbol):  </label>";  
    t+="<input type='text' placeholder='Example:3,J' id='call' name='call'><br><br>";
    t+="<button  onclick='make_call()'>Make the call</button>";
    t+="<br>";
    t+="<br>";
    t+="<label>Last call was:<label>";
    t+="<label id='my_label'><label>";
    $('#select-list').html(t);
}
function make_call(){
  var e=null;   
    e = document.getElementById("call").value;
    const myArray = e.split(",");
    let total=myArray[0];
    let text=myArray[1];

    $.ajax({url: "bluff.php/calls/",
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {total: total, text: text, change_turn: change_turn}),
            
        });  

        // allazei ti seira
    // $.ajax({url: "bluff.php/changeturn/",
    //     method: 'PUT',
    //     dataType: "json",
    //     contentType: 'application/json',
    //     data: JSON.stringify( {change_turn: change_turn})
            
    //     });  
        
}

$.ajax({url: "bluff.php/show_calls/",
        method: 'GET',
        dataType: "json",
        contentType: 'application/json',
        success:change_label
    });  
function change_label(data){
    var o=data[0];
    document.getElementById('my_label').innerHTML=(o.total+","+o.text);

}
function fill_cards_start(){
    // var c = (o.piece!=null)?o.piece_color + o.piece:''; // edw
   
    if (number == "A") {
        $.ajax(
            {   
                url:"bluff.php/show_cards/player1",
                success: fill_cards
            }
        )
    };

    if (number == "B") {
        $.ajax(
            {   
                url:"bluff.php/show_cards/player2",
                success: fill_cards
            }
        )
    };
}
function fill_cards(data){
    draw_selection();
    $('#game_initializer').hide();
    var selectElement=document.getElementById("cards");
   var i, L = selectElement.options.length - 1;
   for(i = L; i >= 0; i--) {
      selectElement.remove(i);
   }
    for(var i=0;i<data.length;i++){
        var o=data[i];
        var x = document.getElementById("cards");
        var option = document.createElement("option");
        option.text = o.card_text+" "+o.card_symbol;
        x.add(option);

    }
    if (i==0){
        alert('won:' + number);
        $.ajax({url: "bluff.php/checkwin/",
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {number: number})
        });

        $('#select-list').hide();
        alert("YOU WON!!");
    }

}



// function turncheck(data){
//     var aaaa=data[0];
//     bbaa = aaaa.player_turn;
//     alert('turncheck: ' + aaaa.player_turn);
// }

function show_me(){
    // $.ajax(
    //     {
    //         url:"bluff.php/checkturn/",
    //         success: function(data) {
    //             var aaaa=data[0];
    //             bbaa = aaaa.player_turn;
    //             alert('turncheck: ' + aaaa.player_turn);
    //         }
    //     }
    // )

    var e = document.getElementById("cards");
    var value = e.value;
    var text = e.options[e.selectedIndex].text;

    const myArray = text.split(" ");
    text=myArray[0];
    let symbol =myArray[1];

    

    if (number == "A" && bbaa == "A") {
        $.ajax({url: "bluff.php/play_cards1/",
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {text: text, symbol: symbol})
        });
        change_turn = "B";
    }else if (number == "B" && bbaa == "B") {
        $.ajax({url: "bluff.php/play_cards2/",
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {text: text, symbol: symbol})
        });
        change_turn = "A";
    }

    alert("You just played:"+text+" "+symbol);
    fill_cards_start();

    // if(bbaa == "A") {
    //     change_turn = "B";
    // }else if(bbaa == "B") {
    //     change_turn = "A";
    // }

    // $.ajax({url: "bluff.php/changeturn/",
    //     method: 'PUT',
    //     dataType: "json",
    //     contentType: 'application/json',
    //     data: JSON.stringify( {change_turn: change_turn})
            
    //     });  

    // let selectElement = document.getElementById("mySelect");
    // let length = selectElement.options.length;

    // let select = document.querySelector('select');
    // let optionsLength = select.options.length
    // if (optionsLength == 1) {
    //     alert('no cards left');
    //     $.ajax({url: "bluff.php/checkwin/",
	// 		method: 'GET',
	// 		dataType: "json",
	// 		contentType: 'application/json',
	// 		//data: JSON.stringify( {text: text, symbol: symbol})
    //     });
    // }
}


function login_to_game() {
    var username = $('#username').val();
    number = $('#playerno').val();

	if($('#username').val()=='') {
		alert('You have to set a username');
		return;
	}
    else {
    var username = $('#username').val();
	number = $('#playerno').val();
	//draw_selection(playerno);
	//fill_cards_start();
    //alert(username);
    //alert(number);
	
	$.ajax({url: "bluff.php/users/"+number, // edw 
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {username: $('#username').val(), playerno: number}),
                success: fill_cards_start,
			error: login_error});
    }
}



function login_result(data) {
	me = data[0];
	// update_info();
	// game_status_update();
}


function login_error(data,y,z,c) {
	var x = data.responseJSON;
	alert(x.errormesg);
}