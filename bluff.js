var me={};
var game_status={};

$(function(){
    draw_selection();
    fill_cards_start();

    $('#bluff_login').click( login_to_game);
})

function draw_selection(){
    var t="<form action='#' onsubmit='show_me()' method='POST'>";
    t+="<label for='Your Cards:'>Your Cards:</label>";
    t+="<select id='cards' name='cards' id='cards'>";
    t+='</select>';
    t+="<br>";
    t+="<br>";
    t+="<input type='submit' onclick='show_me()' value='Play this card'>";
    t+="</form>";
    $('#select-list').html(t);
}
function fill_cards_start(){
    // var c = (o.piece!=null)?o.piece_color + o.piece:''; // edw
    $.ajax(
        {   
            url:"bluff.php/show_cards/player1",
            success: fill_cards
        }

    );
}
function fill_cards(data){
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
    // alert(text);

    const myArray = text.split(" ");
    text=myArray[0];
    let symbol =myArray[1];
    // alert(text+" and "+symbol);

    $.ajax({url: "bluff.php/play_cards/",
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {text: text, symbol: symbol})
        });
}

function login_to_game() {
	if($('#username').val()=='') {
		alert('You have to set a username');
		return;
	}
    var username = $('#username').val();
	var number = $('#playerno').val();
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
	$('#game_initializer').hide();
	// update_info();
	// game_status_update();
}


function login_error(data,y,z,c) {
	var x = data.responseJSON;
	alert(x.errormesg);
}