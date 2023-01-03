var me={};
var game_status={};
var key=0;
var number = null;

$(function(){
    
    number = $('#playerno').val();

    $('#bluff_login').click( login_to_game);
    $('#bluff_login').click( fill_cards_start);

})



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
    $('#select-list').html(t);
}
function fill_cards_start(){
    // var c = (o.piece!=null)?o.piece_color + o.piece:''; // edw
   
    if (number == "A") {
    $.ajax(
        {   
            url:"bluff.php/show_cards/player1",
            success: fill_cards
        }
    )};

    if (number == "B") {
        $.ajax(
            {   
                url:"bluff.php/show_cards/player2",
                success: fill_cards
            }
        )};
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

}

function show_me(){
    var e = document.getElementById("cards");
    var value = e.value;
    var text = e.options[e.selectedIndex].text;


    const myArray = text.split(" ");
    text=myArray[0];
    let symbol =myArray[1];
    if (number == "A") {
        $.ajax({url: "bluff.php/play_cards1/",
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {text: text, symbol: symbol})
        });
    }else {
        $.ajax({url: "bluff.php/play_cards2/",
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {text: text, symbol: symbol})
        });
    }
    alert("You just played:"+text+" "+symbol);
    fill_cards_start();

}

function login_to_game() {
	if($('#username').val()=='') {
		alert('You have to set a username');
		return;
	}
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
			success: login_result,
			error: login_error});
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